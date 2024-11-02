import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordTestAnswerScreen extends ConsumerStatefulWidget {
  final String userAnswer;
  final String correctAnswer;
  const WordTestAnswerScreen({
    required this.userAnswer,
    required this.correctAnswer,
  });

  @override
  _WordTestAnswerScreenState createState() => _WordTestAnswerScreenState();
}

class _WordTestAnswerScreenState extends ConsumerState<WordTestAnswerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Answer'),
            ],
          ),
        ),
      ),
    );
  }
}
