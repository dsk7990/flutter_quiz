import 'package:flutter/material.dart';
import 'package:flutter_quiz/homepage/provider/quiz_data_provider.dart';
import 'package:flutter_quiz/homepage/view/home_page_view.dart';
import 'package:flutter_quiz/utils/strings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizDataProvider>(
            create: (_) => QuizDataProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringUtils.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePageView(),
      ),
    );
  }
}
