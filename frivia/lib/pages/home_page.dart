import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  double _currsliderval = 0;
  String difflvl = 'easy';
  double? _deviceheight,_devicewidth;
  

  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children:[
              Column(
                children: [
                  _head(),
                  _difftext(),
                ],
              ),
            _diffslider(),
             _strtbtn()
            ]
          ),
        )
        ),
    );
  }


  Widget _diffslider() {
    return Slider(
      value: _currsliderval,
    min: 0,
    max: 2,
    divisions: 2,
    label: "difficulty",
    activeColor: const Color.fromARGB(255, 0, 109, 198),
    inactiveColor: const Color.fromARGB(255, 0, 24, 43),
    onChanged: (double value){
      setState((){
        _currsliderval = value;
      });
    },
    );
  }

  Widget  _head() {
    return const Text(
      "Frivia",
      style: TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _difftext() {
    String diff  = "Easy";
    if(_currsliderval == 0) {diff = "Easy";}
    else if(_currsliderval == 1) {diff = "Medium";}
    else {diff = "Hard";}
    return Text(
      diff,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w200,
      ),
    );
  }


  Widget _strtbtn() {
    if(_currsliderval == 0) {difflvl = 'easy';}
    else if(_currsliderval == 1) {difflvl = 'medium';}
    else {difflvl = 'hard';}
    return MaterialButton(
     color:const Color.fromARGB(255, 2, 74, 181),
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext _context) {
          return GamePage(difflvl: difflvl);
            }
          ),
        );
      },
      minWidth: _devicewidth! * .4,
      height: _deviceheight! * .1,
      child: const Text(
        "START",
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      )
     );
  }
}