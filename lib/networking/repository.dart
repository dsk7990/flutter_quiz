import 'package:flutter_quiz/homepage/model/quiz_model.dart';

import 'api_provider.dart';

class Repository {
  static const String BASE_URL = 'https://opentdb.com/';

  final String GET_QUIZ_DATA = '${BASE_URL}api.php';

  final ApiProvider _provider = ApiProvider();

  Future<QuizModel> fetchQuizData(Map<String, dynamic> queryParams) async {
    final response =
        await _provider.get(GET_QUIZ_DATA, queryParameters: queryParams);
    return QuizModel.fromJson(response);
  }
}
