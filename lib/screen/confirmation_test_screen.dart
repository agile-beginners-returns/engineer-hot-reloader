import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmationTestScreen extends ConsumerWidget {
  final String articleUrl;
  const ConfirmationTestScreen({required this.articleUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleUrl),
      ),
      body: Center(
        child: Text('Confirmation Test Screen'),
      ),
    );
  }
}
