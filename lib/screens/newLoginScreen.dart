import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:kotlinproj/screens/siginup_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../controllers/Auth_Controller.dart';

class NewLogin extends StatelessWidget {
  final SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[400],
          ),
          onPressed: () {
          Get.offNamed('/presingin');
          },
        ),
        title: RichText(
          text: TextSpan(
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
                  color: Colors.greenAccent[700],
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
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60, left: 10),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      fontSize: 46),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Text(
                      "As a",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed('/presingin');
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust padding to control the size
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.5)),
                          color: Colors.lightGreen[50], // Background color of the chip
                          borderRadius: BorderRadius.circular(20.0), // Rounded corners to mimic a chip
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Minimize the width of the row
                            children: [
                              Text(
                                signInController.selectedRole.toString(),
                                style: TextStyle(fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600
                                ), // Smaller text
                              ),
                              SizedBox(width: 4.0), // Space between text and icon
                              CircleAvatar(
                                radius: 10.0, // Smaller circle avatar
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.edit, size: 16.0, color: Color(0xff00E676)), // Pencil icon
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    Text(
                      "Code , Learn , Get Better and make Connections",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "With the one and only CODE CAMPUS",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100, left: 10, right: 10),
                  child: TextField(
                    controller: signInController.emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xff00E676),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.greenAccent[700]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00E676),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00E676),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    controller: signInController.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        color: Color(0xff00E676),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.greenAccent[700]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00E676),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00E676),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => signInController.accountNotFound.isTrue
                  ? AnimatedOpacity(
                opacity: signInController.accountNotFound.isTrue ? 1.0 : 0.0,
                duration: Duration(seconds: 4),
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text(
                    ' Please check your credentials or sign up.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

              )
                  : Container()), // Empty container to maintain layout
              Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    "Forgot Your Password?",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Center(
                      child: GFButton(
                        onPressed: () async {
                          await signInController.signIn();
                          if (signInController.confirmEmailFirst.isTrue) {
                            signInController.confirmEmailFirst.value= false;
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text:
                                  'Please confirm your account\n Enter the code',
                              confirmBtnText: 'Enter Code',
                              cancelBtnText: 'Cancel',
                              confirmBtnColor: Colors.yellow,
                              onConfirmBtnTap: () {
                                signInController.resendFlag.value = true;
                                  Get.toNamed('/OTP');

                              },
                            );
                          }
                        },
                        color: Color(0xff00E676),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        shape: GFButtonShape.pills,
                        blockButton: true,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: GFButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/about');
                          },
                          color: Color(0xff00E676),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Color(0xff00E676),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          shape: GFButtonShape.pills,
                          type: GFButtonType.outline,
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
