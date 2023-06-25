import 'package:flutter/material.dart';
import 'package:mobile_mini_hackathon_team_b/pages/home_page.dart';
import 'package:mobile_mini_hackathon_team_b/components/base_app_bar.dart';

const List<String> list = <String>['振動する', 'BGMを流す', '教授にメール送信'];
const Color focusedColor = Colors.amber;

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  String dropdownValue = list.first;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime now = DateTime.now();


  /*
   * タイムピッカー
   */
  Future<void> _selectTime(BuildContext context, TimeOfDay time) async {
    final ThemeData theme = Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
        primary: focusedColor,
      ),
    );
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (time == startTime) {
          startTime = picked;
        } else if (time == endTime) {
          endTime = picked;
        }
      });
    }
  }

  void _showComparisonDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("開始時刻が終了時刻よりも遅くなってはいけません。"),
          actions: [
            Center(
              child: TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Column(
        children: [
          const SizedBox (
            height: 48,
          ),
          const Text(
            '授業開始時刻',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${startTime.hour.toString().padLeft(2, "0")}:${startTime.minute.toString().padLeft(2, "0")}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context, startTime),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        '時刻選択',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox (
            height: 32,
          ),
          const Text(
              '授業終了時刻',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${endTime.hour.toString().padLeft(2, "0")}:${endTime.minute.toString().padLeft(2, "0")}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context, endTime),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                        '時刻選択',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox (
            height: 32,
          ),
          const Text(
              '罰ゲーム',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: focusedColor, // 選択時の枠線の色を指定
                  ),
                ),
              ),
              isExpanded: true,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              DateTime dateTime1 = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
              DateTime dateTime2 = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
              if (dateTime1.isAfter(dateTime2)) {
                _showComparisonDialog();
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.yellow,
              backgroundColor: Colors.black,
              shape: const StadiumBorder(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '授業を受ける！',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
          ),
          const SizedBox (
            height: 120,
          ),
        ],
      ),
    );
  }
}
