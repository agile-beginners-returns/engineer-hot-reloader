import 'package:flutter/material.dart';

// 引数にタイトルの文字と、valueChangedを受け取るボタンを作成してほしい
class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.title,
    required this.selectedAnswer,
  }) : super(key: key);

  final String title;
  final void Function() selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
      onPressed: selectedAnswer,
      child: Text(title),
      ),
    );
  }
}
