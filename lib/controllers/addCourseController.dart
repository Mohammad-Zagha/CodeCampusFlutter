import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:kotlinproj/screens/videoInfoScreen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import '../classes/CourseClass.dart';
import 'TokenService.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:http_parser/http_parser.dart';
class AddCourseController extends GetxController {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController numberOfStudentsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videoDescriptionController = TextEditingController();

  String CurrentCourseId = "";
  late String present;
  late Uint8List coverImage;
  late Uint8List mainImage;
  late Uint8List thumbnail;
  File? videoFile;
  RxString videoName = RxString("");
  RxString totalVideoLength = RxString("");
  late String coverMimeType;
  late String mainMimeType;
  late String thumbnailMimeType;
  late String videoTitle;
  final TokenService _tokenService = TokenService();
  RxList<VideoLecture> videoLectures = <VideoLecture>[].obs;
  RxList<Course> courses = <Course>[].obs;

  Future<void> printData() async {
    print({
      'courseNameController': courseNameController.text,
      'descriptionController': descriptionController.text,
      'locationController': locationController.text,
      'numberOfStudentsController': numberOfStudentsController.text,
      'priceController': priceController.text,
      'present': present,
      'coverMimeType': coverMimeType,
      'mainMimeType': mainMimeType
    });
    print(coverImage);
    print(mainImage);
  }
  Future<void> uploadVideo() async {
    String thumbnailImageBase64 = base64Encode(thumbnail);
    String? token = await _tokenService.getToken();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.102:3000/api/v1/Teacher/upload-video/$CurrentCourseId'),
      );
      request.headers['token'] = token!;
      request.fields['title'] = videoTitleController.text;
      request.fields['description'] = videoDescriptionController.text;
      request.fields['thumbnailBase64'] = thumbnailImageBase64;
      request.fields['thumbnailMimeType'] = thumbnailMimeType;
      request.fields['duration'] = '${totalVideoLength.value}';
      request.files.add(
        await http.MultipartFile.fromPath(
          'videoUrl',
          videoFile!.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Video uploaded successfully!');
        getCourseVideos(CurrentCourseId);
        Get.back();
      } else {
        print('Failed to upload video');
      }
    } catch (error) {
      print('Error uploading video: $error');
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      File tempVideoFile = File(pickedFile.path);
      String fileName = path.basename(tempVideoFile.path);
      videoName.value = fileName;
        videoFile = tempVideoFile;
      VideoPlayerController videoController = VideoPlayerController.file(tempVideoFile);
      await videoController.initialize();
      Duration videoLength = videoController.value.duration;
      totalVideoLength.value = '${videoLength.inHours.toString().padLeft(2, '0')}:${videoLength.inMinutes.remainder(60).toString().padLeft(2, '0')}:${videoLength.inSeconds.remainder(60).toString().padLeft(2, '0')}';
      print(totalVideoLength.value);
      // Navigate to VideoInfoScreen
      Get.to(VideoInfoScreen());
    }
  }



  Future<void> uploadCourse() async {
    String? token = await _tokenService.getToken();
    String coverImageBase64 = base64Encode(coverImage);
    String mainImageBase64 = base64Encode(mainImage);

    var url = Uri.http('192.168.1.102:3000', '/api/v1/Teacher/addcourse');
    var body = json.encode({
      'courseName': courseNameController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'numberOfStudents': numberOfStudentsController.text,
      'price': priceController.text,
      'present': present,
      'coverImage': coverImageBase64,
      'mainImage': mainImageBase64,
      'coverMimeType': coverMimeType,
      'mainMimeType': mainMimeType,
    });

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String courseId = responseData['courseId'];
      CurrentCourseId=courseId;// Extract courseId from response
      print('Course uploaded successfully!');
    } else {
      print('Failed to upload course');
    }
  }
  Future<void> getCourses() async {
    String? token = await _tokenService.getToken();
    var url = Uri.http('192.168.1.102:3000', '/api/v1/Teacher/myCourses');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token",
      },
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;

      // Parse the JSON string into a Dart object
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // Access the 'courses' array from the response
      List<dynamic> coursesJson = jsonResponse['courses'];

      // Create a list to store Course objects
      List<Course> fetchedCourses = [];

      // Iterate over the 'courses' array and convert each item to a Course object
      coursesJson.forEach((courseJson) {
        // Create a Course object from the JSON data and add it to the list
        fetchedCourses.add(Course.fromJson(courseJson));
      });

      // Update the courses list with the fetched courses
      courses.assignAll(fetchedCourses);


    } else if (response.statusCode == 404) {
      courses.clear();
      print(response.body);
    } else {
      print('Failed to Fetch courses');
    }
  }
  Future<void> getCourseVideos(String courseId) async {
    String? token = await _tokenService.getToken();
    print(courseId);
    var url = Uri.http('192.168.1.102:3000', '/api/v1/Teacher/getCourseVideos/$courseId');

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      List<VideoLecture> lectures = responseData.map((item) => VideoLecture.fromJson(item)).toList();

      videoLectures.assignAll(lectures);
      print('Video Lectures:');
      videoLectures.forEach((lecture) {
        print('ID: ${lecture.id}');
        print('Video: ${lecture.video}');
        print('Title: ${lecture.title}');
        print('thumbnailData: ${lecture.thumbnailData}');
        print('Description: ${lecture.description}');
        print('Duration: ${lecture.duration}');
        print('--------------------------------');
      });
    } else {
      print(json.decode(response.body));
      print('Failed to Fetch course');
    }
  }


}
