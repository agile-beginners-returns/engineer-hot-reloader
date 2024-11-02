import 'dart:convert';

import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:engineer_hot_reload_app/components/answer_button.dart';
import 'package:engineer_hot_reload_app/models/test_model.dart';
import 'package:engineer_hot_reload_app/screen/result_screen.dart';
import 'package:engineer_hot_reload_app/screen/translation_test_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineer_hot_reload_app/components/loading.dart';

class WordTestScreen extends ConsumerStatefulWidget {
  final String articleUrl;
  const WordTestScreen({required this.articleUrl});

  @override
  _WordTestScreenState createState() => _WordTestScreenState();
}

class _WordTestScreenState extends ConsumerState<WordTestScreen> {
  late Future<Map<String, dynamic>?> response;
  @override
  void initState() {
    super.initState();
    // 初期化処理をここに記述
  }

  @override
  Widget build(BuildContext context) {
    response = ref
        .watch(jsonStateNotifierProvider.notifier)
        .callDifyAPI(widget.articleUrl);

    return FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          // 値を取得している途中の場合
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loading(),
            );
          }
          // エラーが発生した場合
          if (snapshot.hasError) {
            return Center(
              child: Text('エラーが発生しました: ${snapshot.error}'),
            );
          }

          // データが取得できたが、nullの場合
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('データが存在しません'),
            );
          }
          final data = snapshot.data!['Questions'];
          return QuestionListWidget(questionsJson: data);
        });
  }

  selectedAnswer(BuildContext context) {
    print('selectedAnswer');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultScreen()));
  }
}

// final indexProvider = StateProvider<int>((ref) => 0);

final indexNotifierProvider = StateNotifierProvider<IndexNotifier, int>((ref) {
  return IndexNotifier();
});

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier() : super(0);

  void increment() {
    state++;
  }
}

class QuestionListWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> questionsJson;

  QuestionListWidget({required this.questionsJson});

  @override
  _QuestionListWidgetState createState() => _QuestionListWidgetState();
}

class _QuestionListWidgetState extends ConsumerState<QuestionListWidget> {
  @override
  void initState() {
    super.initState();
    // `initState`でProviderにアクセスし、データを追加
    final questionList = ref.read(testListProvider);
    if (questionList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(testListProvider.notifier).addQuestions(widget.questionsJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // `wordListProvider`からQuestionリストを読み取る
    final questionList = ref.watch(testListProvider);
    final questionListIndex = ref.watch(indexNotifierProvider);
    print("リストの長さ: ${questionList.length}");

    // print("1番目の問題:${questionList[0].question}");
    if (questionList.isNotEmpty) {
      print("indexの数:${questionListIndex}");
      return Scaffold(
        appBar: AppBar(
          title: Text('Questions List'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80.0,
                    bottom: 80.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: questionListIndex < 4
                      ? const Text('単語の意味としてもっとも適切なものを答えてください',
                          style: TextStyle(fontSize: 16))
                      : questionListIndex < 8
                          ? const Text('問題の日本語訳として最も適切なものを答えてください',
                              style: TextStyle(fontSize: 16))
                          : const Text('技術問題です。問題に対して適切なものを答えてください',
                              style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, bottom: 40.0),
                  child: Text(questionList[questionListIndex].question,
                      style:
                          TextStyle(fontSize: questionListIndex < 4 ? 50 : 20)),
                ),
                for (final choice
                    in questionList[questionListIndex].choices.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: AnswerButton(
                        title: choice,
                        selectedAnswer: () => selectedAnswer(context, choice,
                            questionList[questionListIndex].answer)),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return CircularProgressIndicator();
  }

  selectedAnswer(BuildContext context, String choice, String correctAnswer) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WordTestAnswerScreen(
                  userAnswer: choice,
                  correctAnswerIndex: correctAnswer,
                )));
  }
}
