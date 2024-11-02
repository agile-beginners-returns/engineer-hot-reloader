import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultScreen extends ConsumerWidget {
  final String articleUrl;
  const ResultScreen({required this.articleUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleUrl),
      ),
      body: Center(
        child: Text('Result Screen'),
      ),
    );
  }
}
