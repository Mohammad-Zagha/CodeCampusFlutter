import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/screens/teacherInfo.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:material_text_fields/labeled_text_field.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';

class newSignupScreen extends StatefulWidget {
  const newSignupScreen({Key? key}) : super(key: key);

  @override
  _newSignupScreenState createState() => _newSignupScreenState();
}

class _newSignupScreenState extends State<newSignupScreen> {
  final _formKey = GlobalKey<FormState>();
bool  passwordVisible = false;
  bool acceptTerms = false;
bool confirmPasswordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  var phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[700],
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/about');
          },
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'RobotoMono',
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'CODE',
                style: TextStyle(
                  color: Color(0xff00E676),
                ),
              ),
              TextSpan(
                text: ' CAMPUS',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      fontSize: 30),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "As a teacher",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "A good teacher can inspire hope, ignite the imagination, and instill a love of learning - Brad Henry.",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                      child: LabeledTextField(
                        title: 'Name & Email',
                        labelSpacing: 8,
                        titleStyling: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textField: MaterialTextField(
                          keyboardType: TextInputType.text,
                          hint: 'Username',
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.text_format),
                          suffixIcon: const Icon(Icons.check),
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: MaterialTextField(
                        keyboardType: TextInputType.emailAddress,
                        hint: 'Email',
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.email_outlined),
                        suffixIcon: const Icon(Icons.check),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!isValidEmail(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: LabeledTextField(
                        title: 'Password',
                        labelSpacing: 8,
                        titleStyling: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textField: MaterialTextField(
                          keyboardType: TextInputType.text,
                          hint: 'Password',
                          textInputAction: TextInputAction.done,
                          obscureText: !passwordVisible, // Modified here
                          controller: passwordController,
                          theme: FilledOrOutlinedTextTheme(
                            fillColor: Colors.green.withAlpha(50),
                            radius: 12,
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8 || value.length > 20) {
                              return 'Password must be between 8 and 20 characters long';
                            } else if (!containsNumberAndSymbol(value)) {
                              return 'Password must contain symbols and numbers';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: MaterialTextField(

                        controller: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        hint: 'Confirm Password',
                        textInputAction: TextInputAction.done,
                        obscureText: !confirmPasswordVisible,
                        theme: FilledOrOutlinedTextTheme(
                          fillColor: Colors.green.withAlpha(50),
                          radius: 12,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                      child: IntlPhoneField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'PS',
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "By clicking \"Continue\" you agree to our Terms of condition and Policies",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              acceptTerms = value ?? false;
                            });
                          },
                          activeColor: Colors.greenAccent[700],

                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              acceptTerms = !acceptTerms;
                            });
                          },
                          child: Text(
                            "Accept Terms",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: Center(
                        child: GFButton(
                          icon: Icon(Icons.navigate_next_outlined),
                          onPressed: () {
                            if (_formKey.currentState!.validate() && acceptTerms) {
                              TeacherSignUpInfo teacherSignUpInfoObject = TeacherSignUpInfo(
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                phoneNumber: phoneNumber,
                              );
                              // Validate the form before proceeding
                              Get.to(TeacherInfo(teacherSignUpInfo: teacherSignUpInfoObject));
                            } else if (!acceptTerms) {
                              // Show a message indicating that terms must be accepted
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please accept terms to continue.'),
                                ),
                              );
                            }
                          },
                          color: Color(0xff00E676),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                          shape: GFButtonShape.pills,
                          blockButton: true,

                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TeacherSignUpInfo {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;

  TeacherSignUpInfo({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });
}

bool isValidEmail(String email) {
  // Email validation regex pattern
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}

bool containsNumberAndSymbol(String value) {
  // Check if password contains both numbers and symbols
  return RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])').hasMatch(value);
}
