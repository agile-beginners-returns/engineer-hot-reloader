import 'package:engineer_hot_reload_app/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordTestScreen extends ConsumerStatefulWidget {
  final String articleUrl;
  const WordTestScreen({required this.articleUrl});

  @override
  _WordTestScreenState createState() => _WordTestScreenState();
}

class _WordTestScreenState extends ConsumerState<WordTestScreen> {
  late Future<Map<String, dynamic>> response;
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
          print('data:${snapshot.data}');
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
                      // Expanded(
                      //     child: ListView.builder(
                      //         itemCount: 4,
                      //         itemBuilder: (context, index) {
                      //           return ListTile(
                      //             title: Text('選択肢$index'),
                      //           );
                      //         })),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
