import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final articleStateNotifierProvider =
    AsyncNotifierProvider<ArticleStateNotifier, List<Map<String, dynamic>>>(() {
  return ArticleStateNotifier();
});

class ArticleStateNotifier extends AsyncNotifier<List<Map<String, dynamic>>> {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    //読み込み時の初期値をロード
    return [];
  }

  Future<Map<String, dynamic>> callDevtoAPI() async {
    final url =
        Uri.parse("https://dev.to/api/articles?per_page=4&page=1&top=1");

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final articles = jsonDecode(response.body) as Map<String, dynamic>;
        print(articles);
        return articles;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
