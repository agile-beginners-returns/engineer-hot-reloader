import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(6, 6),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "AIが問題を生成中...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Colors.grey.shade300,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                  Shadow(
                    color: Colors.white,
                    offset: Offset(-1, -1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
