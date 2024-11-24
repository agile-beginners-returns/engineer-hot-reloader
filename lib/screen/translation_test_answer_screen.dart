import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:engineer_hot_reload_app/screen/result_screen.dart';
import 'package:engineer_hot_reload_app/screen/word_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationWordTestAnswerScreen extends ConsumerStatefulWidget {
  final String userAnswer;
  final String correctAnswerIndex;

  const TranslationWordTestAnswerScreen({
    required this.userAnswer,
    required this.correctAnswerIndex,
    Key? key,
  }) : super(key: key);

  @override
  _TranslationWordTestAnswerScreenState createState() =>
      _TranslationWordTestAnswerScreenState();
}

class _TranslationWordTestAnswerScreenState
    extends ConsumerState<TranslationWordTestAnswerScreen> {
  bool showIcon = true; // アイコンの表示を制御するフラグ

  @override
  Widget build(BuildContext context) {
    final questionList = ref.watch(testListProvider);
    final questionListIndex = ref.watch(indexNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon)
              Icon(
                widget.userAnswer ==
                        questionList[questionListIndex]
                            .choices
                            .values
                            .elementAt(int.parse(widget.correctAnswerIndex) - 1)
                    ? Icons.trip_origin
                    : Icons.close,
                size: 100,
                color: widget.userAnswer ==
                        questionList[questionListIndex]
                            .choices
                            .values
                            .elementAt(int.parse(widget.correctAnswerIndex) - 1)
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
                      .elementAt(int.parse(widget.correctAnswerIndex) - 1);

                  return ListTile(
                    title: Text(choice),
                    leading: choice == widget.userAnswer
                        ? Icon(Icons.check)
                        : Icon(null),
                    tileColor: (widget.userAnswer == correctAnswer &&
                            choice == widget.userAnswer)
                        ? (() {
                            ref
                                .read(testListProvider.notifier)
                                .insertIsCorrect(questionListIndex, true);
                            return Color(0xFF4EE774);
                          })()
                        : choice == widget.userAnswer
                            ? (() {
                                ref
                                    .read(testListProvider.notifier)
                                    .insertIsCorrect(questionListIndex, false);
                                return Color(0xFFF35474);
                              })()
                            : choice == correctAnswer
                                ? Color(0xFF4EE774)
                                : null,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showIcon = false; // アイコンの表示を切り替え
                    });
                    if (questionListIndex == questionList.length - 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(),
                        ),
                      );
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
