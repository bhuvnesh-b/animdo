import 'package:flutter/material.dart';
import 'package:frivia/provider/game_page_provider.dart';
import 'package:provider/provider.dart';



class GamePage extends StatelessWidget {

  final String difflvl;
  double? _deviceheight,_devicewidth;

  GamePageProvider? _pageProvider;

  GamePage({required this.difflvl});

  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;
    //here all the children and the descendents will be able 
    //to access the gamepageprovider ,so when the page's state is
    //change then every element under it will change 
    return ChangeNotifierProvider(
      create: (_context) => GamePageProvider(context: context , difflvl: difflvl),
      child: _buildUi(),
      );
  }


  Widget _buildUi(){
    return Builder(
      builder: (_context) {
        _pageProvider = _context.watch<GamePageProvider>();
        if(_pageProvider!.questions != null){
          return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceheight! * .05
                ),
              child: _gameUi()
              ),
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white
              )
            );
        }
      },
    );
  }

  Widget _gameUi(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questxt(),
        Column(
          children: [
            _truebtn(),
            SizedBox(height: _deviceheight! * .03),
            _falsebtn(),
          ],
        ),
      ],
    );
  }

  Widget _questxt() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _truebtn() {
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green.shade600,
      minWidth: _devicewidth! * 0.8,
      height: _deviceheight! * 0.1,
      child: const Text("True" ,
      style: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      ),
      );
  }

  Widget _falsebtn() {
    return MaterialButton(
      onPressed: (){
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red.shade600,
      minWidth: _devicewidth! * 0.8,
      height: _deviceheight! * 0.1,
      child: const Text("False" ,
      style: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w500,
          ),
        ),
      );
  }
}