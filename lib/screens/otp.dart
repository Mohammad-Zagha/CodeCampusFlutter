import 'dart:async';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/controllers/Auth_Controller.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../controllers/Strudent_Auth_Controller.dart';

class OTP extends StatefulWidget {

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final SignInController signInController = Get.find();
  Timer? _timer;
  int _remainingTime = 60;
  bool _isButtonDisabled = false;

  void _startTimer() {
    setState(() {
      _isButtonDisabled = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _stopTimer();
      }
    });
  }
  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isButtonDisabled = false;
      _remainingTime = 60;
    });
  }




  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    if(!signInController.resendFlag.isFalse)
      {
          signInController.reSendOTP();
          signInController.resendFlag.value=false;
      }
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }




  @override
  Widget build(BuildContext context) {
    String currentText="";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[700],
          ),
          onPressed: () {
            Get.toNamed('/login');
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
      body: SingleChildScrollView( // Wrap the column in a SingleChildScrollView
        child: Column(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/otp.json'),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top:2, left: 16),
              child: Text(
                "We've sent you a code to the Provided email",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black87,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      blurRadius: 100,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  selectedFillColor: Colors.transparent,
                  inactiveColor: Color(0xff00E676),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  borderWidth: 2,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: signInController.otpController,
                errorAnimationController: errorController,
                onCompleted: (v) {

                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't get the email? "),
              GestureDetector(
                onTap: _isButtonDisabled ? null : () {

                  signInController.reSendOTP();
                  _startTimer();
                },
                child: Text(
                  _isButtonDisabled ? "Resend ($_remainingTime)" : "Resend",
                  style: TextStyle(
                    color: _isButtonDisabled ? Colors.grey : Color(0xff00E676),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  onPressed: (
                      ) async{
                      await signInController.confirmEmailByCode();
                  },
                  shape: GFButtonShape.pills,
                  color: const Color(0xff00E676),
                  child: const Text(
                    "Finish",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                SizedBox(width: 20,),
                GFButton(
                  onPressed: () {},
                  shape: GFButtonShape.pills,
                  color: Colors.redAccent,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
