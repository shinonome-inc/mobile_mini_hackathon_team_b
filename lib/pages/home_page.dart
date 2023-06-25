import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: アラートダイアログを表示
          },
          child: const Text('アラートダイアログを表示'),
        ),
      ),
    );
  }
}
