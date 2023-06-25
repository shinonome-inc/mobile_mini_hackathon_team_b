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
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Text('HomePageへ遷移'),
        ),
      ),
    );
  }
}
