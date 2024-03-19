import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late Animation<double> boxHeight;
  late Animation<double> boxWidth;
  late Animation<double> boxShape;
  late Animation<Color?> boxColor;
  late Animation<Offset> boxOffset;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      upperBound: 1,
      lowerBound: 0,
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    boxHeight = TweenSequence(
      [
        TweenSequenceItem<double>(tween: Tween(begin: 50, end: 140), weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 0.5),
      ),
    );

    boxOffset = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -120)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.25, 0.5),
    ));

    boxWidth = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 60, end: 140), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.25),
      ),
    );

    boxColor = ColorTween(begin: const Color(0xffC6C8EC), end: Colors.yellow).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.75, 1),
      ),
    );

    boxShape = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 140), weight: 1)
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 0.75),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: boxOffset.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(boxShape.value),
                      border: Border.all(
                        color: Colors.blue,
                        width: 3,
                      ),
                      color: boxColor.value,
                    ),
                    height: boxHeight.value,
                    width: boxWidth.value,
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (animationController.status == AnimationStatus.completed) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
              child:
              const Text("Animation"),
            ),
          ],
        ),
      ),
    );
  }
}