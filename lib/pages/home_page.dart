import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);
  final DateTime startTime;
  final DateTime endTime;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _formatDateTime(DateTime time) {
    final DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '授業時間${_formatDateTime(widget.startTime)}〜${_formatDateTime(widget.endTime)}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('警告が表示されたらキャンセルを選択してください。\nキャンセルしないと罰ゲームが執行されます。')
            ],
          ),
        ),
      ),
    );
  }
}
