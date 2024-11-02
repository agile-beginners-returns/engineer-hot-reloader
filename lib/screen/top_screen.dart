import 'package:engineer_hot_reload_app/screen/word_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:engineer_hot_reload_app/devto_api_request.dart';

class TopScreen extends StatelessWidget {
  TopScreen({Key? key}) : super(key: key);

  // final List<Map<String, dynamic>> articles_test
  // ここにdevto_apiから取ってきたデータを入れたい

  final List<Map<String, dynamic>> articles = [
    {
      "cover_image":
          "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fp1e85q4vypcch88es74u.png",
      "title":
          "Node.js Frameworks Roundup 2024 — Elysia / Hono / Nest / Encore — Which should you pick?",
      "description":
          "Node.js web frameworks — where do we even begin? With so many options out there, choosing the right...",
      "url":
          "https://dev.to/encore/nodejs-frameworks-roundup-2024-elysia-hono-nest-encore-which-should-you-pick-19oj"
    },
    {
      "cover_image":
          "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fu3eoc0gbj7n13tzhjo24.jpg",
      "title": "Why Virtual DOM: Render and Performance",
      "description":
          "In this article, we will examine the dom in detail and what the virtual dom is.           What is the...",
      "url":
          "https://dev.to/sonaykara/why-virtual-dom-faster-rendering-and-performance-1cjh",
    },
    {
      "cover_image":
          "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Flybf060q51rao9fq4s2w.png",
      "title": "How to Dockerize and Deploy Fastify APIs",
      "description":
          "If you're just here to copy and paste, here's the final Dockerfile that will produce an image for...",
      "url":
          "https://dev.to/code42cate/how-to-dockerize-and-deploy-fastify-apis-3f7i",
    },
    {
      "cover_image":
          "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F0bss0hkv0h2u5vra80up.png",
      "title":
          "The Curious Case of the \$15,000 Spam: My Unexpected Investigation",
      "description":
          "Last Friday started off like any typical day—I was busy with my work in my office when I stumbled...",
      "url":
          "https://dev.to/programmerraja/the-curious-case-of-the-15000-spam-my-unexpected-investigation-1llg",
    },
    {
      "cover_image":
          "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fu1wboisyl9avre72vn1t.png",
      "title": "My Hacktobefest 2024 Experience",
      "description":
          "Hacktoberfest has a special place in my tech journey because my tech and open source journey started...",
      "url":
          "https://dev.to/pradumnasaraf/my-hacktobefest-2024-experience-385f",
    },
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController articleUrlController = TextEditingController(
      text:
          'https://devclass.com/2024/10/30/flutter-forked-as-flock-developer-cites-company-wide-issues-at-google/',
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // タイトルとアイコン
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 170,
                        child: Image.asset('assets/images/hotreloader2.png')),
                  ],
                ),
              ),
              // URL入力フォームとボタン
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E5EC),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-5, -5),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: const Color(0xFFA3B1C6),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: articleUrlController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'URLを入力',
                            hintStyle: TextStyle(color: Color(0xFF888888)),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.0),
                          ),
                          style: const TextStyle(color: Color(0xFF333333)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -3),
                            blurRadius: 6,
                          ),
                          BoxShadow(
                            color: const Color(0xFFA3B1C6),
                            offset: Offset(3, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        color: const Color(0xFF333333),
                        onPressed: () => toWordTestScreen(
                            context, articleUrlController.text),
                      ),
                    ),
                  ],
                ),
              ),
              // オススメ記事選択欄
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                child: Text(
                  "オススメ記事一覧",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          toWordTestScreen(context, article["url"]);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(-5, -5),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade500,
                                offset: const Offset(5, 5),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article["cover_image"] != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      article["cover_image"],
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article["title"],
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      article["description"],
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
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
