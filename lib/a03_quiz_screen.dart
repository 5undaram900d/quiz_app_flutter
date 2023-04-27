
import 'dart:async';

import 'package:a06_quiz_app/a04_api_services.dart';
import 'package:a06_quiz_app/a05_result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'a02_custom_text.dart';

class A03_QuizScreen extends StatefulWidget {
  const A03_QuizScreen({Key? key}) : super(key: key);

  @override
  State<A03_QuizScreen> createState() => _A03_QuizScreenState();
}

class _A03_QuizScreenState extends State<A03_QuizScreen> {

  int seconds = 60;
  bool isLiked = false;

  var currQusIndex = 0;

  Timer? timer;

  late Future quiz;

  int points = 0;

  bool isLoaded = false;

  var optionList = [];
  var optionColor = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();           // on open screen start the timer
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();        // on going outside screen timer will stop
  }

  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(seconds>0){
          seconds--;
        }
        else{
          timer.cancel();
        }
      });
    });
  }

  resetColor(){
    optionColor = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white];
  }

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
          child: FutureBuilder(
            future: quiz,             // quiz is initialise already inside the initState
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){

                var data = snapshot.data["results"];
                if(!isLoaded){
                  optionList = data[currQusIndex]['incorrect_answers'];
                  optionList.add(data[currQusIndex]['correct_answer']);
                  optionList.shuffle();
                  isLoaded = true;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(CupertinoIcons.xmark_circle, color: Colors.white, size: 40,),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              normalText(text: '$seconds', size: 24, color: Colors.white),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey, width: 2)
                            ),
                            child: TextButton.icon(
                              onPressed: (){
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              },
                              icon: Icon(CupertinoIcons.heart_fill, size: 18, color: isLiked ? Colors.red : Colors.white,),
                              label: normalText(text: 'Like', size: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Image.network('https://e7.pngegg.com/pngimages/696/845/png-clipart-pub-quiz-test-quiz-bowl-flashcard-button-miscellaneous-game.png', height: 200,),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: normalText(text: 'Question ${currQusIndex+1} of ${data.length}', size: 18, color: Colors.white54),
                      ),
                      const SizedBox(height: 20,),
                      normalText(text: data[currQusIndex]["question"], size: 20, color: Colors.white),
                      const SizedBox(height: 20,),
                      ListView.builder(
                        shrinkWrap: true,           //important because we are use ListView.builder inside the Column
                        itemCount: optionList.length,
                        itemBuilder: (BuildContext context, int index) {

                          var answer = data[currQusIndex]["correct_answer"];

                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                if(answer.toString() == optionList[index].toString()){
                                  optionColor[index] = Colors.green;

                                  points = points+10;

                                }
                                else{
                                  optionColor[index] = Colors.red;
                                }


                                if(currQusIndex < data.length - 1){
                                  Future.delayed(const Duration(seconds: 1), (){
                                    isLoaded = false;
                                    currQusIndex++;

                                    resetColor();

                                    timer!.cancel();
                                    seconds = 60;
                                    startTimer();
                                  });
                                }
                                else{
                                  timer!.cancel();
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: optionColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: headingText(text: optionList[index].toString(), size: 18, color: Colors.blue),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => A05_ResultScreen(gotPoints: points,)));
                        },
                        child: const Text('Score'),
                      ),
                    ],
                  ),
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            }
          ),
        ),
      )
    );
  }
}