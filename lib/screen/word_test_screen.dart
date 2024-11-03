import 'dart:convert';

import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:engineer_hot_reload_app/components/answer_button.dart';
import 'package:engineer_hot_reload_app/models/test_model.dart';
import 'package:engineer_hot_reload_app/screen/result_screen.dart';
import 'package:engineer_hot_reload_app/screen/translation_test_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineer_hot_reload_app/components/loading.dart';
// import 'package:webview_flutter/webview_flutter.dart';

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
          return QuestionListWidget(
            questionsJson: data,
            articleUrl: widget.articleUrl,
          );
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
  final String articleUrl;

  QuestionListWidget({required this.questionsJson, required this.articleUrl});

  @override
  _QuestionListWidgetState createState() => _QuestionListWidgetState();
}

class _QuestionListWidgetState extends ConsumerState<QuestionListWidget> {
  bool _isWidgetVisible = false; // 表示・非表示の管理
  // late final WebViewController controller;

  // controller = WebViewController()
  //     ..loadRequest(Uri.parse(webViewUrl))
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..addJavaScriptChannel(
  //       'webViewName',
  //       onMessageReceived: (message) {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text(message.message)));
  //       },
  //     );

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
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
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.web),
        //   onPressed: () {
        //     showModalBottomSheet(
        //       context: context,
        //       backgroundColor:
        //           Colors.transparent, // Transparent background for the modal
        //       isScrollControlled:
        //           true, // Allows dragging the modal to full height
        //       builder: (BuildContext context) {
        //         return Container(
        //           margin:
        //               EdgeInsets.only(top: 64), // Offset the modal from the top
        //           decoration: BoxDecoration(
        //             color: Colors.white, // Modal's main color
        //             borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20),
        //             ), // Rounded top corners
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(16.0),
        //             child: SingleChildScrollView(
        //               // Make the content scrollable
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   Container(
        //                     height: MediaQuery.of(context).size.height *
        //                         0.7, // 70% of screen height
        //                     // child: child: WebViewWidget(
        //   controller: controller,
        // ),
        //                   ),
        //                   ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.pop(context); // Close the modal
        //                     },
        //                     child: Text("Close"),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      );
    }
    return CircularProgressIndicator();
  }

  selectedAnswer(BuildContext context, String choice, String correctAnswer) {
    print('choice: $choice');
    pragma('correctAnswer: $correctAnswer');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TranslationWordTestAnswerScreen(
                  userAnswer: choice,
                  correctAnswerIndex: correctAnswer,
                )));
  }
}
