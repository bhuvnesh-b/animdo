import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

//we can use vsync if we have singletickerproviderstate in our class
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  double _buttonRadius = 100;

  // Tween is used to assign random values between given begining and end like here changing the background color size 
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0,end: 1.0);

  AnimationController? _starIconAnimController;


  //init function for initialising animation controller function
  @override
  void initState() {
    super.initState();

    //vsync tells how the animation is updated 
    _starIconAnimController = AnimationController(vsync: this,
    duration : const Duration(seconds: 4
      ),
    );
    _starIconAnimController!.repeat();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButton(),
                _starIcon(),
              ],
            )
          ],
        )
      )
    );
  }

  Widget _pageBackground() {

    //function to make the animation for background
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.elasticInOut,
      duration: Duration(seconds: 2),
      //builder function for tween 
      builder: (
        _context,
        double _scale,
        _child){
          return Transform.scale(
            scale: _scale,
            child: _child,
          );
        },
      child: Container(
        color: Colors.blue,
      )
    );
  }

  Widget _circularAnimationButton() {
    //to allign the button in center
    return Center(
      //to print in the console when we press the button 
      child: GestureDetector(

        //method of increasing the button size on pressing it 
        onTap:() {
          setState(() {
            _buttonRadius += _buttonRadius==200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
        
        //this is the duration for which our animatiion would work 
        duration: const Duration(seconds: 2),

        //for adding extra effect to the shrinking and enlargin of the button size
        curve: Curves.bounceInOut,
        height: _buttonRadius,
        width: _buttonRadius,
        decoration: BoxDecoration(
          color: Colors.purple ,
          borderRadius: BorderRadius.circular(_buttonRadius)
          ),
          child:const Center(
            child: Text(
              "Click!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starIcon(){
    return AnimatedBuilder(
      animation: _starIconAnimController!.view,
      builder: (_buildContext, _child){
        //transform is used to create different animation 
        return Transform.rotate(
          angle:_starIconAnimController!.value * 2 *pi,
          child:_child,
        );

      },
      child: const Icon(
      Icons.star,
      size: 100,
      color: Colors.white
      ),
    );
  }
}
