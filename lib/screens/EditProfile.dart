import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/classes/TeacherClass.dart';
import 'package:kotlinproj/classes/UserService.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final UserService userService = Get.find();
  void initState() {
    super.initState();
    if(userService.teacher.value != null)
      {
        _usernameController.text = userService.teacher.value?.teacherName??'';
        _emailController.text = userService.teacher.value?.email??'';
        _phoneController.text = userService.teacher.value?.phone.substring(4,12) ?? '';
        _ageController.text = userService.teacher.value?.age.toString()?? '';

      }
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1,
                fontFamily: 'Helvetica-rounded',
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: GFAvatar(
                backgroundImage: AssetImage('assets/anastoma.jpg'),
                size: 100,
              ),
            ),
            SizedBox(height: 50,),
            TextField(
              controller:_usernameController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: Text("Username"),

                labelStyle: TextStyle(color: Colors.grey[600]),

                // No border is drawn by default, underline is shown when the TextField is enabled and focused
                border: InputBorder.none,

                // Underline for the enabled state
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]!), // Change color as needed
                ),

                // Underline for the focused state
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Or use your theme's focusedColor
                ),


                // Other properties like content padding, icon colors, etc., will inherit from your theme
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: Text("E-mail"),
                labelStyle: TextStyle(color: Colors.grey[600]),

                // No border is drawn by default, underline is shown when the TextField is enabled and focused
                border: InputBorder.none,

                // Underline for the enabled state
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]!), // Change color as needed
                ),

                // Underline for the focused state
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Or use your theme's focusedColor
                ),


                // Other properties like content padding, icon colors, etc., will inherit from your theme
              ),
            ),
            SizedBox(height: 15,),
            Container(

              child: IntlPhoneField(
              controller: _phoneController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  floatingLabelAlignment: FloatingLabelAlignment.start,

                  labelStyle: TextStyle(color: Colors.grey[600]),

                  // No border is drawn by default, underline is shown when the TextField is enabled and focused
                  border: InputBorder.none,

                  // Underline for the enabled state
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]!), // Change color as needed
                  ),

                  // Underline for the focused state
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Or use your theme's focusedColor
                  ),



                ),
                initialCountryCode: 'PS',
                onChanged: (phone) {

                },
                validator: (value) {
                  if (value == null) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
              ),
            ),
            EasyAutocomplete(

              decoration: InputDecoration(

                  fillColor: Colors.transparent,
                  filled: true,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                      label: Text('Gender'),
                  labelStyle: TextStyle(color: Colors.grey[600]),

                  // No border is drawn by default, underline is shown when the TextField is enabled and focused
                  border: InputBorder.none,

                  // Underline for the enabled state
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]!), // Change color as needed
                  ),

                  // Underline for the focused state
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Or use your theme's focusedColor
                  ),
              ),
                    initialValue: 'Male',
                  suggestions: ['male', 'female',],
                onChanged: (value) {},
                onSubmitted: (value) => {}
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: Text("Age"),
                labelStyle: TextStyle(color: Colors.grey[600]),

                // No border is drawn by default, underline is shown when the TextField is enabled and focused
                border: InputBorder.none,

                // Underline for the enabled state
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]!), // Change color as needed
                ),

                // Underline for the focused state
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Or use your theme's focusedColor
                ),


                // Other properties like content padding, icon colors, etc., will inherit from your theme
              ),
            ),
            Center(
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GFButton(
                    onPressed: ()  {
                    },
                    color:Colors.grey,
                    child: Text(
                      "Cancle",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    shape: GFButtonShape.pills,
                      type: GFButtonType.outline,

                  ),
                  GFButton(
                    onPressed: ()  {
                    },
                    color: Color(0xff00E676),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    shape: GFButtonShape.pills,
                    elevation: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
