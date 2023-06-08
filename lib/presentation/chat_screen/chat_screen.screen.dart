import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/chat_screen.controller.dart';

class ChatScreenScreen extends GetView<ChatScreenController> {
  const ChatScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatScreenScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatScreenScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
