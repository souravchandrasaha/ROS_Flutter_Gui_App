import 'package:flutter/material.dart';

class DisplayGrid extends StatelessWidget {
  DisplayGrid({required this.step, required this.width, required this.height});
  double step = 20;
  double width = 300;
  double height = 300;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      color: theme.scaffoldBackgroundColor,
      child: CustomPaint(
        painter: GridPainter(
            step: step, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  late double step = 20;
  Color color = Colors.black;
  GridPainter({required this.step, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round // 设置画笔的端点为圆形，以便绘制圆形点
      ..strokeWidth = 0.2;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
