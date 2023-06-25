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
  final AudioPlayer player = AudioPlayer();
  late Timer timer;
  static const int graceSeconds = 10;
  int _elapsedSeconds = 0;
  int _cancelButtonAppearanceSeconds = 0;
  int _penaltyGameSeconds = 0;
  int get _timeLimit =>
      showCancelButton ? _penaltyGameSeconds - _elapsedSeconds : 1;

  bool showCancelButton = false;

  int _generateRandomValue() {
    int maxNumber = 20;
    int minNumber = 10;
    return math.Random().nextInt(maxNumber - minNumber + 1) + minNumber;
  }

  String _formatDateTime(DateTime time) {
    final DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(time);
  }

  void _cancelTimer() {
    timer.cancel();
  }

  void _playSound() {
    player.play(AssetSource(SoundPaths.bgm));
  }

  @override
  void initState() {
    super.initState();
    _cancelButtonAppearanceSeconds = _generateRandomValue();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        showCancelButton = _elapsedSeconds >= _cancelButtonAppearanceSeconds;
        setState(() {
          _elapsedSeconds++;
        });
        if (showCancelButton) {
          _penaltyGameSeconds = _cancelButtonAppearanceSeconds + graceSeconds;
        }
        if (_timeLimit <= 0) {
          _playSound();
          _cancelTimer();
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
              const Text('警告が表示されたら必ずキャンセルしてください。'),
              const SizedBox(height: 64.0),
              SizedBox(
                height: 120.0,
                child: showCancelButton
                    ? Column(
                        children: [
                          const Text(
                            '⚠️$graceSeconds秒以内にキャンセルしてください。\nキャンセルしないと大音量で音楽が再生されます。',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _cancelTimer();
                              player.stop();
                              setState(() {
                                showCancelButton = false;
                              });
                            },
                            child: const Text('キャンセル'),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
