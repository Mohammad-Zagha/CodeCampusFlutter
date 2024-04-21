import 'dart:typed_data';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/controllers/addCourseController.dart';
import 'package:kotlinproj/screens/videoUploadScreen.dart';
import 'dart:io'; // Import dart:io for File
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {

  final AddCourseController addCourseController = Get.find();
  String? selectedValue;
  File? _selectedImage;
  File? _selectedCourseImage;
  final Map<String, String> optionsMap = {
    "in person": "inPerson",
    "remotely": "remotely",
  };
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _temp = File(pickedFile.path);
      setState(() {
        _selectedImage = File(pickedFile.path); // Set the selected image
      });
      Uint8List imageBytes = await _temp.readAsBytes();
      addCourseController.coverImage = imageBytes;
      String? mimeType = lookupMimeType(pickedFile.path);
      addCourseController.coverMimeType = "$mimeType";
    }
  }

  Future<void> _pickImageFromGalleryCourse() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _temp = File(pickedFile.path);
      setState(() {
        _selectedCourseImage = File(pickedFile.path);

      });
      // Read the file as a byte array
      Uint8List imageBytes = await _temp.readAsBytes();
      addCourseController.mainImage = imageBytes;
      String? mimeType = lookupMimeType(pickedFile.path);
      addCourseController.mainMimeType = "$mimeType";

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
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
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(right: 7),
                  child: GFButton(
                    onPressed: () async{
                     await addCourseController.uploadCourse();
                      Get.to(VideoUploadScreen());
                    },
                    size: 28,
                    shape: GFButtonShape.pills,
                    color: const Color(0xff00E676),
                    child: const Icon(Icons.navigate_next,color: Colors.white,),
                    ),
                  ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 10),
              child: Text(
                "Add a new\nCourse !",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    fontSize: 40),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 15),
              child: Text(
                "Here, you can share your knowledge and passion with\nlearners from around the globe.",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                    fontSize: 14),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // Apply a border radius to all corners
                borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                // If you want a border around the Stack, uncomment the following line
                // border: Border.all(color: Colors.blue, width: 2),
              ),
              clipBehavior: Clip.antiAlias, // This is necessary to clip the child Stack's content to the border radius
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _selectedImage != null
                            ? FileImage(_selectedImage!) as ImageProvider
                            : AssetImage('assets/placeholder2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,

                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color to white
                          shape: BoxShape.circle, // Optional: Makes the container circular
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _pickImageFromGallery,
                          icon: Icon(Icons.edit),
                          color: Colors.black, // Optional: Change the icon color if needed
                        ),
                      )

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(2), // The border width
                        decoration: BoxDecoration(
                          color: Colors.grey, // Border color
                          shape: BoxShape.circle, // Ensures the container is circular to match the GFAvatar shape
                        ),
                        child: GFAvatar(
                          backgroundImage: _selectedCourseImage != null
                              ? FileImage(_selectedCourseImage!) as ImageProvider
                              : AssetImage('assets/noimage.jpg'),
                          size: 75,
                          // Other GFAvatar properties or customization can be added here
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 220,
                      top: 135,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color to white
                          shape: BoxShape.circle, // Optional: Makes the container circular
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _pickImageFromGalleryCourse,
                          icon: Icon(Icons.edit,size: 15,),
                          color: Colors.black, // Optional: Change the icon color if needed
                        ),
                      )

                  ),

                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              height: 270,
              decoration: BoxDecoration(
                color: Colors.white, // Ensure shadow is visible
                borderRadius:
                    BorderRadius.circular(20), // Rounded corners for shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87
                        .withOpacity(0.2), // Shadow color with opacity
                    spreadRadius: 0,
                    blurRadius:
                        10, // Adjust blur radius for desired shadow effect
                    offset: Offset(0.5, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: addCourseController.courseNameController,
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Course name",
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey.withOpacity(0.12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .green), // Or use your theme's focusedColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: addCourseController.descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Description",
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey.withOpacity(0.12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .green), // Or use your theme's focusedColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: addCourseController.locationController,
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Location",
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey.withOpacity(0.12),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .green), // Or use your theme's focusedColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        child: TextField(
                          controller: addCourseController.numberOfStudentsController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            label: Text("# of students"),
                            labelStyle: TextStyle(color: Colors.grey[600]),

                            // No border is drawn by default, underline is shown when the TextField is enabled and focused
                            border: InputBorder.none,

                            // Underline for the enabled state
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .grey[350]!), // Change color as needed
                            ),

                            // Underline for the focused state
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .green), // Or use your theme's focusedColor
                            ),
                          ),
                        ),
                      ),
                      Container(

                        width: 100,
                        child: TextField(
                          controller: addCourseController.priceController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            label: Text("Price"),
                            labelStyle: TextStyle(color: Colors.grey[600]),

                            // No border is drawn by default, underline is shown when the TextField is enabled and focused
                            border: InputBorder.none,

                            // Underline for the enabled state
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .grey[350]!), // Change color as needed
                            ),

                            // Underline for the focused state
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .green), // Or use your theme's focusedColor
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              // Match the TextField's look
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedValue != null
                                      ? Colors.green
                                      : Colors.grey[350]!, // Focus color logic
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedValue,
                                hint: Text('Present',
                                    style: TextStyle(color: Colors.grey[600])),
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey[600]), // Custom icon
                                onChanged: (String? newValue) {
                                 addCourseController.present = newValue!;
                                },
                                items: optionsMap.entries
                                    .map<DropdownMenuItem<String>>(
                                      (MapEntry<String, String> entry) =>
                                          DropdownMenuItem<String>(
                                        value: entry.key,
                                        child: Text(entry.key,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )
                                    .toList(),
                                style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.transparent),
                                dropdownColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GFButton(
                  onPressed: () {
                    Get.to(VideoUploadScreen());
                  },
                  elevation: 4,
                  size: 28,
                  shape: GFButtonShape.pills,
                  icon: Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.white,
                  ),
                  color: const Color(0xff00E676),
                  child: const Text(
                    "Get Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Lat: 30.008745",
                  style: TextStyle(fontFamily: 'Helvetica-rounded'),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Lng: 14.665245",
                  style: TextStyle(fontFamily: 'Helvetica-rounded'),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
