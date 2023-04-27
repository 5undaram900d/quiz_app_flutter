
import 'package:a06_quiz_app/a02_custom_text.dart';
import 'package:a06_quiz_app/a03_quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class A01_MainQuiz extends StatelessWidget {
  const A01_MainQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){},
                icon: const Icon(CupertinoIcons.home, color: Colors.white, size: 40,),
              ),
              Image.network('https://img.freepik.com/free-vector/quiz-background-with-items-flat-design_23-2147599082.jpg?w=740&t=st=1680930654~exp=1680931254~hmac=75b890ed768cc55d0711a4dfddd15348227d85c5096684fc71c878acfde9c259'),
              const SizedBox(height: 20,),
              normalText(text: 'Welcome to our', size: 18, color: Colors.white),
              headingText(text: 'Quiz App', size: 32, color: Colors.white),
              const SizedBox(height: 10,),
              normalText(text: "Let's start to take the quiz, check and boost your knowledge", size: 18, color: Colors.white),

              // this widget used to take whole space in between them
              const Spacer(),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(   // it provide onTap:
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const A03_QuizScreen()),);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    width: size.width - 100,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(text: 'Continue', size: 18, color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
