import 'package:chips_choice/chips_choice.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import '../CustomWidgets/CustomChip.dart';
import '../controllers/Auth_Controller.dart';
import 'package:lottie/lottie.dart';
class PreSingin extends StatefulWidget {

  @override
  State<PreSingin> createState() => _PreSinginState();
}

class _PreSinginState extends State<PreSingin> {
  List<String> tags = ['Teacher , Student'];
  final SignInController signInController= Get.find();
  var tag="";

  @override
  Widget build(BuildContext context) {

    List<String> options = ["Student", "Teacher",];

    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Container(
              height: 250,
              width: 400,
              child:Lottie.asset('assets/role1.json'),
            ),),
            Center(
              child: Text("Choose Your roll",style: TextStyle(
                  color: Colors.black87,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Center(child: Text("Let's get started on your journey to discovery . First, tell us who you are",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey[700],
                  fontSize: 15
                ),

              ),),
            ),

            Center(
              child: ChipsChoice<String>.single(
                value: tag, // 'tag' is the currently selected choice
                onChanged: (val) {
                  setState(() => tag = val); // Update the state with the new selection
                  print("Selected choice: $tag"); // Print the selected choice
                },
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options, // 'options' should have only two elements for this use case
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceBuilder: (item, i) {
                  return CustomChip(
                    label: item.label,
                    width: 130,
                    height: 100,
                    selected: item.selected,
                    onSelect: item.select!,
                  );
                },
              ),
            ),
            Container(
              width: 150,
              child: GFButton(
                fullWidthButton: true,
                onPressed: tag =="" ?null : (){
                  signInController.selectedRole(tag);
                  Get.toNamed('/login', arguments: {'role': tag});
                },
                disabledColor: Colors.grey,
                color: Color(0xff7BDEC8),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                shape: GFButtonShape.pills,

              ),
            ),
          ],
        ),
      ),

    );
  }
}
