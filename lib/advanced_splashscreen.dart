library advanced_splashscreen;

import 'dart:async';

import 'package:flutter/material.dart';

class AdvancedSplashScreen extends StatefulWidget {

  // widget
  final Widget child;
  final int seconds;
  final int milliseconds;

  // animate
  final bool animate;

  // appearance
  final List<Color> colorList;
  final String backgroundImage;
  final double bgImageOpacity;
  final String appIcon;
  final String appTitle;
  final TextStyle appTitleStyle;

  AdvancedSplashScreen({this.child, this.seconds = 1, this.milliseconds = 0, this.animate = true, this.colorList = const [], this.backgroundImage, this.bgImageOpacity = 0.5, this.appIcon = "images/flutter_social.png", this.appTitle = "Flutter Social", this.appTitleStyle = const TextStyle(fontSize: 23.0, color: Colors.white, fontFamily: "", fontWeight: FontWeight.bold)});

  @override
  _AdvancedSplashScreenState createState() => _AdvancedSplashScreenState();
}

class _AdvancedSplashScreenState extends State<AdvancedSplashScreen> with TickerProviderStateMixin {

  Animation<double> _animation;
  Animation<double> _animationText;
  AnimationController _animationController;

  List<double> stopList = [];

  @override
  void initState() {
    super.initState();

    buildStopList();

    handleScreenReplacement();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: (widget.seconds / 2).truncate(), milliseconds: (widget.milliseconds / 2.5).truncate()));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    _animationText = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    if(widget.animate){
      _animationController.forward();
    }
  }

  @override
  void dispose() {

    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[

          // if background image is passed
          (widget.backgroundImage != null)
              ?
          Opacity(
            opacity: widget.bgImageOpacity,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.backgroundImage,),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
              :
          // if no background image is passed
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: stopList,
                  colors: widget.colorList,
                )
            ),
          ),
          Container(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child){

                return Transform(
                    transform: Matrix4.translationValues(_animation.value * size.width, 0.0, 0.0),
                    child: (widget.appIcon != null)
                        ?
                    Center(
                      child: Image.asset(widget.appIcon, width: size.width / 3, height: size.height / 3,),
                    )
                        :
                    SizedBox(width: 0.0, height: 0.0,)
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child){

              return Transform(
                transform: Matrix4.translationValues(0.0, -1 * _animationText.value * size.height, 0.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(widget.appTitle, style: widget.appTitleStyle,),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void handleScreenReplacement() {

    Timer(Duration(seconds: widget.seconds, milliseconds: widget.milliseconds), (){

      if(widget.child == null){

        throw new ArgumentError(
            'No child was passed. widget.child must not be null.'
        );
      }
      else{

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return widget.child;
        }));
      }
    });
  }

  void buildStopList() {

    stopList = [];

    double stopListVal = 0.4;
    widget.colorList.forEach((color){
      stopList.add(stopListVal);
      stopListVal += 0.2;
    });
  }
}



