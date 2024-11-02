import 'package:engineer_hot_reload_app/word_test_screen.dart';
import 'package:flutter/material.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController articleUrlController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Engineer hot Reloader',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                        height: 20,
                        child: Image.asset('assets/images/fire.png')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: articleUrlController,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'URLを入力',
                          )),
                    ),
                    IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => toWordTestScreen(
                            context, articleUrlController.text)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toWordTestScreen(BuildContext context, String articleUrl) {
    if (articleUrl.isEmpty) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WordTestScreen(articleUrl: articleUrl)));
  }
}
