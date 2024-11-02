import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final jsonStateNotifierProvider2 =
    AsyncNotifierProvider<JsonStateNotifier2, Map<String, dynamic>>(() {
  return JsonStateNotifier2();
});

class JsonStateNotifier2 extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    //読み込み時の初期値をロード
    return {'Questions': null};
  }

  Future<Map<String, dynamic>> callDevtoAPI() async {
    final url =
        Uri.parse("https://dev.to/api/articles?per_page=4&page=1&top=1");

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {'Questions': null};
      }
    } catch (e) {
      return {'Questions': null};
    }
  }
}
