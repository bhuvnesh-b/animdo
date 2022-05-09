import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class GamePageProvider extends ChangeNotifier {

  final Dio _dio = Dio();
  final int _maxques = 10;
  final String difflvl;

  List? questions;
  int _currentquescnt = 0;
  int _score = 0;
  

  BuildContext context;
  GamePageProvider({required this.context , required this.difflvl}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getquestions();
  }

    Future<void> _getquestions() async {
      var _response = await _dio.get('' ,
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': '$difflvl',
        },
      );
      var _data = jsonDecode(_response.toString());
      questions = _data["results"];
      notifyListeners();
    }
    String getCurrentQuestionText() {
      return questions![_currentquescnt]["question"];
    }

    void answerQuestion(String _answer) async {
      bool iscorrect = questions![_currentquescnt]["correct_answer"] == _answer;
      if(iscorrect) _score++;
      _currentquescnt++;
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: iscorrect? Colors.green : Colors.red,
            title: Icon(
              iscorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        },
      );
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pop(context);
      if(_currentquescnt == _maxques){
        endGame();
      }
      else notifyListeners();
    }
  
    Future<void> endGame() async{
      showDialog(context: context,
      builder: (BuildContext _context){
        return AlertDialog(
          backgroundColor: Colors.black38,
          title:const Text(
            "GAME OVER!",
            style: TextStyle(color: Colors.white,
              fontSize: 25
            ),
          ),
          
          content: Text(
            "Score: $_score/10",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
            ),
        );
        
      }
      );

      await Future.delayed(
        const Duration(seconds: 3)
        );
        Navigator.pop(context);
        Navigator.pop(context);
    }
}