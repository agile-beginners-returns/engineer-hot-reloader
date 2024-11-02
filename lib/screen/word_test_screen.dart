import 'dart:convert';

import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:engineer_hot_reload_app/components/answer_button.dart';
import 'package:engineer_hot_reload_app/models/test_model.dart';
import 'package:engineer_hot_reload_app/screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('AIが問題を生成中...'),
                ],
              ),
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

          // print('data -> :${data}');
          final testList = data.entries.map((entry) {
            return {entry.key: entry.value};
          }).toList();

          // print("testList > $testList");

          // response.then((data)=>{
          //   if (data == null) {
          //   return;
          // }
          // });
          ref.read(testListProvider.notifier).addQuestions(data);

          // `wordListProvider`からQuestionリストを読み取る
          final questionList = ref.watch(testListProvider);
          // print('questionList:$questionList');

          // final testList = Tests.fromJson(
          //     jsonDecode(data!['data']['outputs']['output_json']));
          // print('testList:$testList');
          // print('test1:${testList[0].question}');
          // dataにアクセス
          // Map<String, dynamic> data_nested = data!['data'];

          // // outputsにアクセス
          // Map<String, dynamic> outputs = data_nested['outputs'];

          // // output_jsonにアクセス
          // Map<String, dynamic> outputJson = outputs['output_json'];

          // // Questionsにアクセス
          // Map<String, dynamic> questions = outputJson['Questions'];

          // 特定の質問（Word1）にアクセス
          // Map<String, dynamic> word1 = questions['Word1'];
          // final responsQestions =
          //     data!['data']['outputs']['output_json']['Questions'];
          // print('responsQestions:$responsQestions');
          // print(
          //     'data -> data -> outputs -> output_json:${data!['data']['outputs']['output_json'['Questions']}');
          // final qestions = data['data']['outputs']['output_json']['Questions'];

          // print('data:$data');
          // print('data -> data :${data!['data']}');
          // print('data -> data :${data!['data']['output_json']}');
          // print('data -> data :${data!['data']['output_json']}');
          // print(
          //     'data -> data -> outputs :${data!['data']['outputs']['output_json']['Questions']}');

          return SafeArea(
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0, bottom: 80.0),
                        child: const Text('単語の意味としてもっとも適切なものを答えてください',
                            style: TextStyle(fontSize: 16)),
                      ),
                      // TODO: testProviderの内容から問題を表示する
                      Text('Hot', style: TextStyle(fontSize: 50)),
                      AnswerButton(
                        title: "A",
                        selectedAnswer: () => selectedAnswer(context),
                      ),
                      AnswerButton(
                        title: "B",
                        selectedAnswer: () => selectedAnswer(context),
                      ),
                      AnswerButton(
                        title: "C",
                        selectedAnswer: () => selectedAnswer(context),
                      ),
                      AnswerButton(
                        title: "D",
                        selectedAnswer: () => selectedAnswer(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  selectedAnswer(BuildContext context) {
    print('selectedAnswer');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultScreen()));
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(testListProvider.notifier).addQuestions(widget.questionsJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    // `wordListProvider`からQuestionリストを読み取る
    final questionList = ref.watch(testListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Questions List'),
      ),
      body: ListView.builder(
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          final question = questionList[index];
          return ListTile(
            title: Text('Question: ${question.question}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...question.choices.entries
                    .map((entry) => Text('Choice ${entry.key}: ${entry.value}'))
                    .toList(),
                Text('Answer: ${question.answer}'),
                Text('Other Meanings: ${question.otherMeanings}'),
                Text('Example: ${question.example}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
