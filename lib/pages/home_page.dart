import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_mini_hackathon_team_b/constants/sound_paths.dart';

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
  static const int graceSeconds = 10;
  int _elapsedSeconds = 0;
  int _cancelButtonAppearanceSeconds = 0;
  int _penaltyGameSeconds = 0;
  int get _timeLimit =>
      showCancelButton ? _penaltyGameSeconds - _elapsedSeconds : 1;

  bool get showCancelButton =>
      _elapsedSeconds >= _cancelButtonAppearanceSeconds;

  int _generateRandomValue() {
    int maxNumber = 20;
    int minNumber = 10;
    return math.Random().nextInt(maxNumber - minNumber + 1) + minNumber;
  }

  String _formatDateTime(DateTime time) {
    final DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(time);
  }

  void _playSound() {
    final AudioPlayer player = AudioPlayer();
    player.play(AssetSource(SoundPaths.bgm));
  }

  @override
  void initState() {
    super.initState();
    _cancelButtonAppearanceSeconds = _generateRandomValue();
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          _elapsedSeconds++;
        });
        if (showCancelButton) {
          _penaltyGameSeconds = _cancelButtonAppearanceSeconds + graceSeconds;
        }
        if (_timeLimit <= 0) {
          print('罰ゲーム執行');
          _cancelButtonAppearanceSeconds += _generateRandomValue();
        }
      },
    );
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
              Text('経過秒数: $_elapsedSeconds'),
              Text('キャンセルボタン出現秒数: $_cancelButtonAppearanceSeconds'),
              Text('罰ゲーム開始秒数: $_penaltyGameSeconds'),
              Text('罰ゲーム開始まで: $_timeLimit'),
              const SizedBox(height: 16.0),
              const Text('警告が表示されたらキャンセルを選択してください。\nキャンセルしないと罰ゲームが執行されます。'),
              const SizedBox(height: 64.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('キャンセル'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
