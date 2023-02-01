import 'package:flutter/material.dart';
import 'package:flutter_quiz/homepage/model/quiz_model.dart';
import 'package:flutter_quiz/homepage/provider/quiz_data_provider.dart';
import 'package:flutter_quiz/homepage/widgets/question_ans_widget.dart';
import 'package:flutter_quiz/networking/widget/no_data_widget.dart';
import 'package:provider/provider.dart';

import '../../networking/api_response.dart';
import '../../networking/widget/error_widget.dart';
import '../../networking/widget/loading_widget.dart';
import '../../utils/strings.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuizDataProvider>(context, listen: false);
    data.getQuizData();

    return Consumer<QuizDataProvider>(builder: (context, value, child) {
      Status status = value.apiResponse.status;
      int cPage = value.currentPosition;
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(StringUtils.title),
        ),
        body: setUI(status, value.quizData ?? null),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: cPage != 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: FloatingActionButton(
                    heroTag: 'prev',
                    key: UniqueKey(),
                    onPressed: () {
                      pageController.jumpToPage(cPage - 1);
                    },
                    child: const Icon(Icons.arrow_circle_left)),
              ),
            ),
            Visibility(
              visible: value.quizData == null
                  ? false
                  : ((cPage + 1) == value.quizData!.results.length),
              child: FloatingActionButton.extended(
                heroTag: 'submit',
                key: UniqueKey(),
                onPressed: () {
                  data.submitQuiz(context);
                },
                backgroundColor: Colors.green,
                label: const Text('SUBMIT'),
              ),
            ),
            Visibility(
              visible: value.quizData == null
                  ? true
                  : ((cPage + 1) != value.quizData!.results.length),
              child: FloatingActionButton(
                heroTag: 'next',
                key: UniqueKey(),
                onPressed: () {
                  pageController.jumpToPage(cPage + 1);
                },
                child: const Icon(Icons.arrow_circle_right),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget setUI(Status status, QuizModel? quizModel) {
    switch (status) {
      case Status.LOADING:
        return const NetworkLoading();
      case Status.COMPLETED:
        return quizModel!.results.isNotEmpty
            ? PageView.builder(
                controller: pageController,
                itemCount: quizModel.results.length,
                onPageChanged: (value) {
                  Provider.of<QuizDataProvider>(
                          _scaffoldKey.currentState!.context,
                          listen: false)
                      .updateCurrentPage(value);
                },
                itemBuilder: (context, position) {
                  Result result = quizModel.results[position];
                  return QuestionAnsWidget(position: position, result: result);
                },
              )
            : const NoDataWidget();

      case Status.ERROR:
        return const NetworkError();

      default:
        return Container();
    }
  }
}
