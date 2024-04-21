import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  const Base64ImageWidget({Key? key, required this.base64String}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string into bytes
    Uint8List bytes = base64Decode(base64String);

    // Create an Image widget from the decoded bytes
    return ClipRRect(
      borderRadius:
      BorderRadius.circular(50),
      child: Image.memory(
        bytes,
        fit: BoxFit.cover, // You can adjust the fit as needed
      ),
    );
  }
}
