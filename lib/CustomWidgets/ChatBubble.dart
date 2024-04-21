import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';

import 'base64Image.dart';

class ChatBubble extends StatelessWidget {
  final String Message;
  const ChatBubble({super.key,required this.Message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent
      ),
      child: Text(
        Message,
        style: const TextStyle(fontSize: 16),
      ) ,
    );
  }
}
