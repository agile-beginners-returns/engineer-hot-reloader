import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final jsonStateNotifierProvider =
    AsyncNotifierProvider<JsonStateNotifier, Map<String, dynamic>>(() {
  return JsonStateNotifier();
});

class TestListNotifier extends StateNotifier<List<Question>> {
  TestListNotifier() : super([]);

  // JSONから複数の`Question`をリストに追加するメソッド
  void addQuestions(Map<String, dynamic> questionsJson) {
    // print('questionsJson$questionsJson');
    // "Questions"キーにアクセスして各エントリを`Question`に変換
    final questions = (questionsJson)
        .entries
        .map(
          (entry) => Question.fromJson(entry.value),
        )
        .toList();
    // questionnsの各要素のchoicesをランダムに並び替える
    // questions.forEach((element) {
    //   element.choices
    //     ..remove('Answer')
    //     ..remove('OtherMeanings')
    //     ..remove('Example');
    //   element.choices
    //     ..addAll({'Answer': element.answer})
    //     ..addAll({'OtherMeanings': element.otherMeanings})
    //     ..addAll({'Example': element.example});
    // });
    print("questions:${questions[0].question}");
    // 既存のリストに追加
    state = [...state, ...questions];
  }

  void insertIsCorrect(int index, bool isCorrect) {
    state[index] = state[index].copyWith(isCorrect: isCorrect);
  }
}

// `QuestionListNotifier`を使った`Provider`の定義
final testListProvider =
    StateNotifierProvider<TestListNotifier, List<Question>>((ref) {
  return TestListNotifier();
});

class Question {
  Question({
    required this.question,
    required this.choices,
    required this.answer,
    this.userAnswer,
    this.otherMeanings,
    required this.example,
    this.isCorrect,
  });
  final String question;
  final Map<String, dynamic> choices;
  final String answer;
  final String? userAnswer;
  final String? otherMeanings;
  final String example;
  final bool? isCorrect;

  Question copyWith({
    String? question,
    Map<String, dynamic>? choices,
    String? answer,
    String? userAnswer,
    String? otherMeanings,
    String? example,
    bool? isCorrect,
  }) {
    return Question(
      question: question ?? this.question,
      choices: choices ?? this.choices,
      answer: answer ?? this.answer,
      userAnswer: userAnswer ?? this.userAnswer,
      otherMeanings: otherMeanings ?? this.otherMeanings,
      example: example ?? this.example,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  // JSONデータから`Question`インスタンスを作成するファクトリーメソッド
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['Question'],
      choices: Map<String, String>.from(json['Choices']),
      answer: json['Answer'],
      otherMeanings: json['OtherMeanings'] ?? '',
      example: json['Example'] ?? '',
    );
  }
}

class JsonStateNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    //読み込み時の初期値をロード
    return {'Questions': null};
  }

  Future<Map<String, dynamic>?> callDifyAPI(String userInputUrl) async {
    // final url = Uri.parse(userInputUrl);
    final url = Uri.parse('https://api.dify.ai/v1/workflows/run');
    print('url:$url');
    final headers = {
      'Authorization': 'Bearer ${dotenv.get('DifyApiKey')}', // APIキーを入力してください
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "inputs": {
        "url": userInputUrl, // ユーザー入力のURLをここに渡します
      },
      "response_mode": "blocking",
      "user": "abc-123",
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('response:$response');
      print('response.statusCode:${response.statusCode}');
      print('response.body"${response.body}');

      if (response.statusCode == 200) {
        final response1 = jsonDecode(response.body) as Map<String, dynamic>;
        final response2 =
            jsonDecode(response1['data']['outputs']['output_json'])
                as Map<String, dynamic>;
        return response2;
      } else {
        print('else');
        return {'Error': null};
      }
    } catch (e) {
      print('catch');
      return {'Error': null};
    }
  }
}

//   Future<Map<String, dynamic>> callDifyAPI(String userInputUrl) async {
//   final url = Uri.parse(userInputUrl);
//   final headers = {
//     'Authorization': 'Bearer {api_key}', // APIキーを入力してください
//     'Content-Type': 'application/json',
//   };
//   final body = jsonEncode({
//     "inputs": {
//       "url": userInputUrl, // ユーザー入力のURLをここに渡します
//     },
//     "response_mode": "streaming",
//     "user": "abc-123",
//   });

//   try {
//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body) as Map<String, dynamic>;
//     } // レスポンスを処理します
//     else {
//       return {'Questions': null};
//     }
//   } catch (e) {
//     return {'Questions': null};
//   }
// }

// }

// final jsonResponseProvider =
//     FutureProvider.family<Map<String, dynamic>, String>((ref, url) async {
//   // 非同期でデータを取得
//   final response = await callDifyAPI(url);
//   return response;
// });

