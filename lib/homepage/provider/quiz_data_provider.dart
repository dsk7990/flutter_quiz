import 'package:flutter/material.dart';
import 'package:flutter_quiz/homepage/model/quiz_model.dart';
import 'package:flutter_quiz/result/view/result_view.dart';
import 'package:flutter_quiz/utils/strings.dart';

import '../../networking/api_response.dart';
import '../../networking/repository.dart';

class QuizDataProvider extends ChangeNotifier {
  QuizModel? quizData;
  int currentPosition = 0;

  final Repository _repository = Repository();

  APIResponse apiResponse = APIResponse.loading('Please wait...');
  Future getQuizData() async {
    apiResponse = APIResponse.loading('Please wait...');
    try {
      Map<String, dynamic> params = {"amount": '10'};

      quizData = await _repository.fetchQuizData(params);

      for (var item in quizData!.results) {
        List<String> list = [];
        list.add(item.correctAnswer!);
        list.addAll(item.incorrectAnswers!);
        list.shuffle();
        item.answers = list;
      }

      apiResponse = APIResponse.completed(quizData);
    } catch (e) {
      apiResponse = APIResponse.error(e.toString());
    }
    notifyListeners();
  }

  updateCurrentPage(int pos) {
    currentPosition = pos;
    notifyListeners();
  }

  updateList(int pos, Result result) {
    quizData!.results[pos] = result;
    notifyListeners();
  }

  submitQuiz(context) {
    int total = 0;
    int totalCorrectAns = 0;
    int totalInCorrectAns = 0;
    bool allQueAppeared = true;
    for (var item in quizData!.results) {
      if (item.isQueAppeared != null) {
        if (item.checkedAnswer == item.correctAnswer) {
          total = total + 5;
          totalCorrectAns = totalCorrectAns + 1;
        } else {
          total = total - 2;
          totalInCorrectAns = totalInCorrectAns + 1;
        }
      } else {
        allQueAppeared = false;
      }
    }
    if (allQueAppeared) {
      if (total < 0) {
        total = 0;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultView(
            total: total,
            totalCorrectAns: totalCorrectAns,
            totalInCorrectAns: totalInCorrectAns,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(StringUtils.errAppearAllQue)));
    }
  }
}
