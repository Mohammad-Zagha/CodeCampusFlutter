import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:lottie/lottie.dart';
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: Container(
                    child: Lottie.asset('assets/Done.json'),
                  ),
                ),
              ),
              Text(
                "Thank you !",
                style: TextStyle(
                    fontFamily: 'Helvetica-rounded',
                    fontWeight: FontWeight.w800,
                    fontSize: 46),
              ),
              Text(
                "Payment Confirmed",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[600],
                    fontSize: 22),
              ),
              Text(
                "Thank you for your purchase",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[600],
                    fontSize: 18),
              ),
              SizedBox(height: 20,),
              Center(
                child: GFButton(
                  onPressed: ()  {
                      Get.offNamed('/home');
                  },
                  color: Color(0xff00E676),
                  child: Text(
                    "Home",
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
            ],
          ),
        ],
      ),
    );
  }
}
