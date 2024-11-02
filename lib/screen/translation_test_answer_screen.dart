import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:engineer_hot_reload_app/screen/result_screen.dart';
import 'package:engineer_hot_reload_app/screen/word_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordTestAnswerScreen extends ConsumerWidget {
  final String userAnswer;
  final String correctAnswerIndex;
  // double iconSize = 100;

  const WordTestAnswerScreen({
    required this.userAnswer,
    required this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionList = ref.watch(testListProvider);
    final questionListIndex = ref.watch(indexNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              userAnswer ==
                      questionList[questionListIndex]
                          .choices
                          .values
                          .elementAt(int.parse(correctAnswerIndex) - 1)
                  ? Icons.trip_origin
                  : Icons.close,
              size: 100,
              color: userAnswer ==
                      questionList[questionListIndex]
                          .choices
                          .values
                          .elementAt(int.parse(correctAnswerIndex) - 1)
                  ? Colors.green
                  : Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Q.${questionList[questionListIndex].question}',
                  style: TextStyle(fontSize: questionListIndex < 4 ? 50 : 20),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      questionList[questionListIndex].choices.values.length,
                  itemBuilder: (context, index) {
                    final choice = questionList[questionListIndex]
                        .choices
                        .values
                        .elementAt(index);
                    final correctAnswer = questionList[questionListIndex]
                        .choices
                        .values
                        .elementAt(int.parse(correctAnswerIndex) - 1);

                    print("===== Index: $index =====");
                    print('userAnswer: $userAnswer');
                    print('correctAnswer: $correctAnswer');
                    print('choice: $choice');
                    print('correctAnswerIndex: $correctAnswerIndex');

                    return ListTile(
                      title: Text(choice),
                      leading:
                          choice == userAnswer ? Icon(Icons.check) : Icon(null),
                      tileColor:
                          (userAnswer == correctAnswer && choice == userAnswer)
                              ? Color(0xFF4EE774)
                              : choice == userAnswer
                                  ? Color(0xFFF35474)
                                  : choice == correctAnswer
                                      ? Color(0xFF4EE774)
                                      : null,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // uestionListIndexを
                    // iconSize = 0;
                    if (questionListIndex == questionList.length - 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen()));
                    } else {
                      ref.read(indexNotifierProvider.notifier).increment();
                      Navigator.pop(context);
                    }
                  },
                  child: questionListIndex == 9
                      ? const Text('評価画面へ')
                      : const Text('次の問題へ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
