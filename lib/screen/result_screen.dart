import 'package:engineer_hot_reload_app/screen/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineer_hot_reload_app/api_request.dart';

class ResultScreen extends ConsumerWidget {
  late final int score;
  late final int total;

  // Define separate scores and totals for each type of question
  late final int wordScore;
  late final int wordTotal;

  late final int translationScore;
  late final int translationTotal;

  late final int techScore;
  late final int techTotal;

  late final List<String> learnedWords;

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

  String getFourQuestionRank(int score) {
    if (score <= 1) {
      return 'C';
    } else if (score == 2) {
      return 'B';
    } else if (score == 3) {
      return 'A';
    } else if (score == 4) {
      return 'S';
    } else {
      return '';
    }
  }

  String getTwoQuestionRank(int score) {
    if (score == 0) {
      return 'C';
    } else if (score == 1) {
      return 'A';
    } else if (score == 2) {
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
    final testList = ref.read(testListProvider);
    score = testList.where((question) => question.isCorrect!).length;
    wordScore =
        testList.sublist(0, 4).where((question) => question.isCorrect!).length;
    wordTotal = testList.sublist(0, 4).length;
    translationScore =
        testList.sublist(4, 8).where((question) => question.isCorrect!).length;
    translationTotal = testList.sublist(4, 8).length;
    techScore =
        testList.sublist(8, 10).where((question) => question.isCorrect!).length;
    techTotal = testList.sublist(8, 10).length;

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
                            getRank(score), // Display rank based on score
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
                        '$score / 10', // Display the score variable here
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
                  title: "　単語問題　",
                  score: wordScore,
                  total: wordTotal,
                  rank: getFourQuestionRank(wordScore),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildNeumorphicRectangle(
                  context: context,
                  title: "日本語訳問題",
                  score: translationScore,
                  total: translationTotal,
                  rank: getFourQuestionRank(translationScore
                  
                ),
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: buildNeumorphicRectangle(
                  context: context,
                  title: "技術確認問題",
                  score: techScore,
                  total: techTotal,
                  rank: getTwoQuestionRank(techScore),
                ),
              ),
              SizedBox(height: 20),
              // "Topに戻る" button with larger size
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TopScreen()));
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

Widget buildNeumorphicRectangle(
    {required BuildContext context,
    required String title,
    required int score,
    required int total,
    required String rank}) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
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
                  rank, // Display rank based on score
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
        Text(
          '$score / $total',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       '学んだ単語',
        //       style: TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black,
        //       ),
        //     ),
        //     SizedBox(height: 4),
        //     for (var word in learnedWords.take(2))
        //       Text(
        //         '・$word ・$word',
        //         style: TextStyle(fontSize: 16, color: Colors.black),
        //       ),
        //   ],
        // ),
      ],
    ),
  );
}
