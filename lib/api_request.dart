import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final jsonStateNotifierProvider =
    AsyncNotifierProvider<JsonStateNotifier, Map<String, dynamic>>(() {
  return JsonStateNotifier();
});

class JsonStateNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    //読み込み時の初期値をロード
    return {'Questions': null};
  }

  Future<Map<String, dynamic>> callDifyAPI(String userInputUrl) async {
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
        return jsonDecode(response.body) as Map<String, dynamic>;
      } // レスポンスを処理します
      else {
        print('else');
        return {'Questions': null};
      }
    } catch (e) {
      print('catch');
      return {'Questions': null};
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

