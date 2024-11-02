import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: selectedAnswer,
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
