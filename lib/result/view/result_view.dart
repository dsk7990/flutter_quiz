import 'package:flutter/material.dart';
import 'package:flutter_quiz/utils/strings.dart';

class ResultView extends StatelessWidget {
  int total;
  int totalCorrectAns;
  int totalInCorrectAns;
  ResultView(
      {Key? key,
      required this.total,
      required this.totalCorrectAns,
      required this.totalInCorrectAns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StringUtils.result),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringUtils.yourTotalMarks,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                total.toString(),
                style: const TextStyle(
                    fontSize: 45,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                '${StringUtils.correctAns}: $totalCorrectAns ',
                style: const TextStyle(fontSize: 30, color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${StringUtils.incorrectAns}: $totalInCorrectAns ',
                style: const TextStyle(fontSize: 30, color: Colors.red),
              ),
            ],
          ),
        ));
  }
}
