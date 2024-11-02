import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmationTestAnswerScreen extends ConsumerWidget {
  final String articleUrl;
  const ConfirmationTestAnswerScreen({required this.articleUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleUrl),
      ),
      body: Center(
        child: Text('Confirmation Test Answer Screen'),
      ),
    );
  }
}
