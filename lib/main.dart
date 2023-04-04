import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

late int _numOfPlayers;
final List<GlobalKey> _keys = List.generate(100, (index) => GlobalKey());
List<double> _getOffsetOfHome(GlobalKey key) {
  final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);
  return [position.dx, position.dy];
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake and Ladder',
      locale: const Locale("fa", "IR"),
      theme: ThemeData(fontFamily: "IRANSansXFaNum-Medium"),
      debugShowCheckedModeBanner: false,
      home: const SnakeAndLadderPage(),
    );
  }
}

class SnakeAndLadderPage extends StatefulWidget {
  const SnakeAndLadderPage({super.key});

  @override
  State<SnakeAndLadderPage> createState() => _SnakeAndLadderPageState();
}

class _SnakeAndLadderPageState extends State<SnakeAndLadderPage>
    with TickerProviderStateMixin {
  late List<List<int>> ladders;
  late List<List<int>> snakes;

  late AnimationController _animationController;
  var rnd = Random();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 0.8,
          colors: [
            Color(0xFF772F1A),
            Color.fromARGB(255, 62, 39, 35),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                drawBoard(),
                diceAndWhoTurnText(),
              ],
            ),
            drawSnakesAndLadders(),
          ],
        ),
      ),
    );
  }

  Row diceAndWhoTurnText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 200,
          child: GestureDetector(
            onTap: () {
              _animationController.forward(
                from: 0,
                // from: AnimationController(vsync: this).value,
              );
              _animationController.animateTo(rnd.nextDouble());
              // Future.delayed(
              //   Duration(milliseconds: rnd.nextInt(1000)),
              //   () => _animationController.stop(),
              // );
            },
            child: Center(
              child: Lottie.asset(
                'assets/gifs/dice_rolling.json',
                // repeat: false,
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController.duration = composition.duration;
                },
              ),
            ),
          ),
        ),
        // ignore: prefer_const_constructors
        Text(
          "نوبت : بازیکن 1",
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  FutureBuilder<dynamic> drawSnakesAndLadders() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 1)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Visibility(
            visible: true,
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown[400],
                  ),
                  child: const CircularProgressIndicator(color: Colors.white)),
            ),
          );
        } else {
          return Visibility(
            visible: true,
            child: Stack(
              children: [
                // 92 - 4
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[98])[0],
                    startY: _getOffsetOfHome(_keys[98])[1],
                    endX: _getOffsetOfHome(_keys[3])[0],
                    endY: _getOffsetOfHome(_keys[3])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.red,
                  ),
                ),
                // 67 - 6
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[66])[0],
                    startY: _getOffsetOfHome(_keys[66])[1],
                    endX: _getOffsetOfHome(_keys[5])[0],
                    endY: _getOffsetOfHome(_keys[5])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.red,
                  ),
                ),
                // 83 - 40
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[82])[0],
                    startY: _getOffsetOfHome(_keys[82])[1],
                    endX: _getOffsetOfHome(_keys[30])[0],
                    endY: _getOffsetOfHome(_keys[30])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.red,
                  ),
                ),
                // 23 - 59
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[22])[0],
                    startY: _getOffsetOfHome(_keys[22])[1],
                    endX: _getOffsetOfHome(_keys[51])[0],
                    endY: _getOffsetOfHome(_keys[51])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.green,
                  ),
                ),
                // 44 - 94
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[43])[0],
                    startY: _getOffsetOfHome(_keys[43])[1],
                    endX: _getOffsetOfHome(_keys[96])[0],
                    endY: _getOffsetOfHome(_keys[96])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.green,
                  ),
                ),
                // 9 - 53
                CustomPaint(
                  painter: ArrowPainter(
                    startX: _getOffsetOfHome(_keys[8])[0],
                    startY: _getOffsetOfHome(_keys[8])[1],
                    endX: _getOffsetOfHome(_keys[57])[0],
                    endY: _getOffsetOfHome(_keys[57])[1],
                    arrowSize: 22 / 1.75,
                    color: Colors.green,
                  ),
                ),
                CustomPaint(
                  painter: ShapesPainter(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Center drawBoard() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          reverse: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
          ),
          itemBuilder: (_, index) {
            return GestureDetector(
              // onTap: () => _getOffsetAndSize(_keys[index]),
              child: Container(
                key: _keys[index],
                decoration: BoxDecoration(
                  color: ((index ~/ 10) % 2 == 0) && (index % 2 == 0)
                      ? Colors.brown
                      : ((index ~/ 10) % 2 == 1) && (index % 2 == 1)
                          ? Colors.brown
                          : Colors.brown[800],
                  borderRadius:
                      (index == 0 || index == 9 || index == 90 || index == 99)
                          ? setBorderRadius(index)
                          : null,
                ),
                child: Center(
                  child: Text(
                    ((index ~/ 10) % 2 == 1)
                        ? (((index ~/ 10) * 20) + 10 - index).toString()
                        : (index + 1).toString(),
                    style: const TextStyle(color: Colors.amber),
                  ),
                ),
              ),
            );
          },
          itemCount: 100,
        ),
      ),
    );
  }

  setBorderRadius(int index) {
    switch (index) {
      case 0:
        return const BorderRadius.only(bottomLeft: Radius.circular(17.5));
      case 9:
        return const BorderRadius.only(bottomRight: Radius.circular(17.5));
      case 90:
        return const BorderRadius.only(topLeft: Radius.circular(17.5));
      case 99:
        return const BorderRadius.only(topRight: Radius.circular(17.5));
      default:
    }
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // // set the paint color to be white
    // paint.color = Colors.white;

    // // Create a rectangle with size and width same as the canvas
    // var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // // draw the rectangle using the paint
    // canvas.drawRect(rect, paint);

    // paint.color = Colors.yellow;

    // // create a path
    // var path = Path();
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, 0);
    // // close the path to form a bounded shape
    // path.close();

    // canvas.drawPath(path, paint);

    // set the color property of the paint
    paint.color = Colors.deepOrange;

    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(
        _getOffsetOfHome(_keys[0])[0] + 22, _getOffsetOfHome(_keys[0])[1] + 22);

    // draw the circle with center having radius 75.0
    canvas.drawCircle(center, 15, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double arrowSize;
  double startX;
  double startY;
  double endX;
  double endY;

  ArrowPainter({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.arrowSize,
    this.color = Colors.black,
    this.strokeWidth = 2.5,
  }) {
    startX += 22;
    startY += 22;
    endX += 22;
    endY += 22;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(startX, startY);
    path.lineTo(endX, endY);

    // Draw arrowhead
    double angle = atan2(endY - startY, endX - startX);
    double arrowX1 = endX - arrowSize * cos(angle - pi / 6);
    double arrowY1 = endY - arrowSize * sin(angle - pi / 6);
    double arrowX2 = endX - arrowSize * cos(angle + pi / 6);
    double arrowY2 = endY - arrowSize * sin(angle + pi / 6);
    path.moveTo(endX, endY);
    path.lineTo(arrowX1, arrowY1);
    path.moveTo(endX, endY);
    path.lineTo(arrowX2, arrowY2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return false;
  }
}

// class BeadPainter extends CustomPainter {
//   final Color color;
//   final double filledCircleRadius;
//   double x;
//   double y;

//   BeadPainter({
//     required this.x,
//     required this.y,
//     required this.filledCircleRadius,
//     this.color = Colors.black,
//   }) {
//     x += 22;
//     y += 22;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final double centerX = size.width / 2;
//     final double centerY = size.height / 2;
//     final Paint paint = Paint()..color = Colors.black;
//     const double filledCircleRadius = 3;
//     const double radiantStep = 2 * pi;
//     canvas.drawCircle(
//       Offset(centerX + sin(1 * radiantStep) * radius,
//           centerY + cos(1 * radiantStep) * radius),
//       filledCircleRadius,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(ArrowPainter oldDelegate) {
//     return false;
//   }
// }
