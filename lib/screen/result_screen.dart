import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineer_hot_reload_app/api_request.dart';

class ResultScreen extends ConsumerWidget {
  final int score = 3;
  final int total = 4;

  // Define separate scores and totals for each type of question
  final int wordScore = 3;
  final int wordTotal = 4;

  final int translationScore = 2;
  final int translationTotal = 5;

  final int techScore = 4;
  final int techTotal = 6;

  final List<String> learnedWords = ["hot", "hot", "hot", "hot"];

  String getRank(int score) {
    if (score >= 1 && score <= 3) {
      return 'C';
    } else if (score >= 4 && score <= 6) {
      return 'B';
    } else if (score >= 7 && score <= 9) {
      return 'A';
    } else if (score == 10) {
      return 'S';
    } else {
      return '';
    }
  }

  void scrollToTop(BuildContext context) {
    // Implement scroll to top functionality if using a scrollable widget
    print("Returning to the top.");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rank',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(-4, -4),
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(4, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            getRank(wordScore), // Display rank based on score
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Text(
                        '$wordScore / 10', // Display the score variable here
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Three neumorphic rectangles with specific titles and scores
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildNeumorphicRectangle(
                  context: context,
                  title: "単語問題",
                  score: wordScore,
                  total: wordTotal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildNeumorphicRectangle(
                  context: context,
                  title: "日本語訳問題",
                  score: translationScore,
                  total: translationTotal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildNeumorphicRectangle(
                  context: context,
                  title: "技術確認問題",
                  score: techScore,
                  total: techTotal,
                ),
              ),
              SizedBox(height: 20),
              // "Topに戻る" button with larger size
              TextButton(
                onPressed: () {
                  scrollToTop(
                      context); // Call the function to scroll to the top
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // Increased button size
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey.shade300,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                child: Text(
                  "Topに戻る",
                  style: TextStyle(
                    fontSize: 18, // Increased font size for button text
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    )));
  }
}

Widget buildNeumorphicRectangle({
  required BuildContext context,
  required String title,
  required int score,
  required int total,
}) {
  final List<String> learnedWords = ["hot", "hot", "hot", "hot"];
  return Container(
    width: 300,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          offset: Offset(-4, -4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.grey.shade600,
          offset: Offset(4, 4),
          blurRadius: 8,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '$score / $total',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学んだ単語',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            for (var word in learnedWords.take(2))
              Text(
                '・$word ・$word',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
          ],
        ),
      ],
    ),
  );
}
