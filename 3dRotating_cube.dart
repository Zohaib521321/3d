import 'package:flutter/material.dart';
import 'dart:math';

void main() {//main function
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Rotating Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('3D Rotating Cube'),
        ),
        body: Center(
          child: RotatingCube(),  //custom widget
        ),
      ),
    );
  }
}

class RotatingCube extends StatefulWidget {
  @override
  _RotatingCubeState createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController; //animation controller

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        final double rotationAngle = _animationController!.value * 2 * pi; //value of rotatiom angel
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(rotationAngle)
            ..rotateY(rotationAngle),
          alignment: Alignment.center,
          child: Cube(),
        );
      },
    );
  }
}

class Cube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.6;

    return Container(
      width: size,
      height: size,
      child: Stack(
        children: [
          CubeFace(color: Colors.red, rotation: pi / 4, child: Text('Front')),
          CubeFace(color: Colors.green, rotation: pi / 2, child: Text('Right')),
          CubeFace(color: Colors.blue, rotation: pi, child: Text('Back')),
          CubeFace(color: Colors.yellow, rotation: 3 * pi / 2, child: Text('Left')),
          CubeFace(color: Colors.orange, rotation: 3 * pi / 4, child: Text('Top')),
          CubeFace(color: Colors.purple, rotation: 3 *pi/2, child: Text('Bottom')), //rotation is angel rotation
        ],
      ),
    );
  }
}

class CubeFace extends StatelessWidget {  //custom widget
  final Color color;
  final double rotation;
  final Widget child;

  CubeFace({required this.color, required this.rotation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateX(rotation)
          ..setEntry(3, 2, 0.001),
        alignment: Alignment.center,
        child: Container(
          color: color,
          child: Center(child: child),
        ),
      ),
    );
  }
}
