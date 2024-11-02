import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordTestAnswerScreen extends ConsumerWidget {
  final String userAnswer;
  final String correctAnswer;
  const WordTestAnswerScreen({
    required this.userAnswer,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Translation Test Answer Screen'),
      ),
    );
  }
}
