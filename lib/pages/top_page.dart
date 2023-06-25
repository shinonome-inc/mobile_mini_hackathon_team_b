import 'package:flutter/material.dart';
import 'package:mobile_mini_hackathon_team_b/pages/home_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final DateTime startTime = DateTime.now();
            final DateTime endTime = startTime.add(
              const Duration(minutes: 90),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(
                  startTime: startTime,
                  endTime: endTime,
                ),
              ),
            );
          },
          child: const Text('HomePageへ遷移'),
        ),
      ),
    );
  }
}
