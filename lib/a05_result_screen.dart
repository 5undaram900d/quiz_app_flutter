
import 'package:flutter/material.dart';
import 'a01_main_quiz.dart';
import 'a02_custom_text.dart';

class A05_ResultScreen extends StatelessWidget {

  var gotPoints;

  A05_ResultScreen({super.key, this.gotPoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const A01_MainQuiz()));
        },
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amberAccent, Colors.green],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: headingText(text: 'Your score: ${gotPoints.toString()}', size: 40, color: Colors.black),
        ),
      ),
    );
  }
}
