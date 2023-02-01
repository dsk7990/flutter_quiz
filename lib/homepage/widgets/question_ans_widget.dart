import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_quiz/homepage/model/quiz_model.dart';
import 'package:flutter_quiz/homepage/provider/quiz_data_provider.dart';
import 'package:provider/provider.dart';

class QuestionAnsWidget extends StatelessWidget {
  int position;
  Result result;

  QuestionAnsWidget({required this.position, required this.result});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(children: <Widget>[
          Html(
            data: result.question,
            style: {
              "body": Style(
                fontSize: const FontSize(24.0),
                fontWeight: FontWeight.bold,
              ),
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    result.category!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  result.difficulty.toString().split('.').last,
                  style:
                      TextStyle(color: setDifficulyColor(result.difficulty!)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.builder(
              itemCount: result.answers!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, pos) {
                String ans = result.answers![pos];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color: result.isQueAppeared == null
                              ? Colors.blue
                              : result.correctAnswer == ans
                                  ? Colors.green
                                  : result.checkedAnswer == ans
                                      ? Colors.red
                                      : Colors.blue)),
                  child: ListTile(
                    onTap: () {
                      if (result.isQueAppeared == null) {
                        result.checkedAnswer = ans;
                        result.isQueAppeared = true;
                        Provider.of<QuizDataProvider>(context, listen: false)
                            .updateList(position, result);
                      }
                    },
                    trailing: result.checkedAnswer == ans
                        ? const Icon(Icons.check)
                        : const SizedBox(
                            width: 20,
                          ),
                    title: Html(
                      data: ans,
                      style: {
                        "body": Style(
                          fontSize: const FontSize(16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                  ),
                );
              })
        ]),
      ),
    );
  }

  Color setDifficulyColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return Colors.green;
      case Difficulty.MEDIUM:
        return Colors.orange;
      case Difficulty.HARD:
        return Colors.red;
    }
  }
}
