import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';

class ChatPage extends StatefulWidget {
  final String receverUserName,receverUserId;

  const ChatPage({super.key,
  required this.receverUserId,
  required this.receverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.receverUserName),),

    );
  }
}
