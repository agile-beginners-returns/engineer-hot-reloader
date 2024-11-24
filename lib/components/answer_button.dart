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
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 12.0), // 縦方向の余白を追加
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // 角を丸くする
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.grey.shade600,
              offset: Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }
}
