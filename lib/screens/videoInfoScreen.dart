import 'dart:typed_data';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/controllers/addCourseController.dart';
import 'dart:io'; // Import dart:io for File
import 'package:image_picker/image_picker.dart';
import 'package:material_text_fields/labeled_text_field.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:mime/mime.dart';


class VideoInfoScreen extends StatefulWidget {
  const VideoInfoScreen({super.key});

  @override
  State<VideoInfoScreen> createState() => _VideoInfoScreenState();
}

class _VideoInfoScreenState extends State<VideoInfoScreen> {
  final AddCourseController addCourseController = Get.find();
  File? _selectedVideoImage;
  Future<void> _pickImageFromGalleryThumbnail() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _temp = File(pickedFile.path);
      setState(() {
        _selectedVideoImage = File(pickedFile.path);
      });
      // Read the file as a byte array
      Uint8List imageBytes = await _temp.readAsBytes();
      addCourseController.thumbnail = imageBytes;
      String? mimeType = lookupMimeType(pickedFile.path);
      addCourseController.thumbnailMimeType = "$mimeType";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.greenAccent[400],
                ),
                onPressed: () {
                  // Navigate back
                },
              ),
              Container(
                margin: const EdgeInsets.only(right: 7),
                child: GFButton(
                  onPressed: () async {
                    await addCourseController.uploadVideo();

                  },
                  size: 28,
                  shape: GFButtonShape.pills,
                  color: const Color(0xff00E676),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _selectedVideoImage != null
                            ? FileImage(_selectedVideoImage!) as ImageProvider
                            : AssetImage('assets/placeholder2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Obx(() => Positioned(
                    bottom: 10,
                    right: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the radius as needed
                      child: Container(
                        height: 25,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.6),
                        ),
                        child: Center(
                            child: Text(
                              addCourseController.totalVideoLength.value,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                      ),
                    ),
                  ),),

                  Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Set the background color to white
                          shape: BoxShape
                              .circle, // Optional: Makes the container circular
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _pickImageFromGalleryThumbnail,
                          icon: Icon(Icons.edit),
                          color: Colors
                              .black, // Optional: Change the icon color if needed
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, top: 5, right: 25),
            child: LabeledTextField(
              title: 'Video Title',
              labelSpacing: 8,
              titleStyling: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textField: MaterialTextField(
                keyboardType: TextInputType.text,
                hint: 'Title',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.text_format),
                  controller: addCourseController.videoTitleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Video must have a title';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, top: 5, right: 25),
            child: LabeledTextField(
              title: 'Video Description',
              labelSpacing: 8,
              titleStyling: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textField: MaterialTextField(
                keyboardType: TextInputType.text,
                hint: 'Description',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.text_format),
                controller: addCourseController.videoDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Video must have a description';
                  }
                  return null;
                },
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 7, left: 25, top: 10),
                child: GFButton(
                  onPressed: () async {
                   await addCourseController.pickVideo();
                  },
                  size: 28,
                  shape: GFButtonShape.pills,
                  color: const Color(0xff00E676),
                  child: Text(
                    "Change Video",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Obx(() =>  Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    addCourseController.videoName.value,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                ),
              ),),

            ],
          ),

        ],
      ),
    );
  }
}
