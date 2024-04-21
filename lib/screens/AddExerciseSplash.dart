import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/screens/AddExercise.dart';
import 'package:lottie/lottie.dart';
class AddExerciseSplash extends StatefulWidget {
  const AddExerciseSplash({super.key});

  @override
  State<AddExerciseSplash> createState() => _AddExerciseSplashState();
}

class _AddExerciseSplashState extends State<AddExerciseSplash> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Lottie.asset("assets/Quiz.json"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("🌍 Learn On the Go!" , textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Our quizzes are perfect for a quick brain exercise anytime, anywhere. ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("🔍 Discover Fun & Learning!" , textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Dive into a world of interactive quizzes designed to challenge your mind ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),

          GFButton(
            onPressed: ()  {
              Get.to(AddExercise());
            },
            color: Color(0xff00E676),
            child: Text(
              "Start",
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            shape: GFButtonShape.pills,
            blockButton: true,
          ),
        ],
      ),
    );
  }
}
