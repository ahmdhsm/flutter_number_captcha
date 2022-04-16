import 'dart:math';

import 'package:flutter/material.dart';

class NumberCaptcha extends StatefulWidget {
  const NumberCaptcha(this.code, {Key? key}) : super(key: key);

  final String code;

  @override
  State<NumberCaptcha> createState() => _NumberCaptchaState();
}

class _NumberCaptchaState extends State<NumberCaptcha> {
  final double width = 180;
  final double height = 40;
  final int dotCount = 100;
  final Color backgroundColor = Colors.white;

  Map getRandomData() {
    List list = widget.code.split("");
    double x = 0.0;
    double maxFontSize = 40.0;

    List mList = [];
    for (String item in list) {
      Color color = Color.fromARGB(
        255,
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );

      int fontWeight = Random().nextInt(9);

      TextSpan span = TextSpan(
        text: item,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.values[fontWeight],
          fontSize: maxFontSize - Random().nextInt(10),
        ),
      );

      TextPainter painter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );

      painter.layout();

      double y = Random().nextInt(height.toInt()).toDouble() - painter.height;

      if (y < 0) {
        y = 0;
      }

      Map strMap = {"painter": painter, "x": x, "y": y};

      mList.add(strMap);

      x += painter.width + 3;
    }

    double offsetX = (width - x) / 2;
    List dotData = [];

    for (var i = 0; i < dotCount; i++) {
      int r = Random().nextInt(255);
      int g = Random().nextInt(255);
      int b = Random().nextInt(255);
      double x = Random().nextInt(width.toInt() - 5).toDouble();
      double y = Random().nextInt(height.toInt() - 5).toDouble();
      double dotWidth = Random().nextInt(6).toDouble();
      Color color = Color.fromARGB(255, r, g, b);
      Map dot = {"x": x, "y": y, "dotWidth": dotWidth, "color": color};
      dotData.add(dot);
    }

    Map checkCodeDrawData = {
      "painterData": mList,
      "offsetX": offsetX,
      "dotData": dotData,
    };
    return checkCodeDrawData;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = 0.0;
    Map drawData = getRandomData();

    maxWidth = getTextSize(
      "8" * widget.code.length,
      TextStyle(fontWeight: FontWeight.values[8], fontSize: 25),
    ).width;

    return Container(
      color: backgroundColor,
      width: maxWidth > width ? maxWidth : width,
      height: height,
      child: CustomPaint(
        painter: HBCheckCodePainter(drawData: drawData),
      ),
    );
  }

  Size getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }
}

class HBCheckCodePainter extends CustomPainter {
  final Map drawData;
  HBCheckCodePainter({
    required this.drawData,
  });

  final Paint _paint = new Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    List mList = drawData["painterData"];

    double offsetX = drawData["offsetX"];

    canvas.translate(offsetX, 0);

    for (var item in mList) {
      TextPainter painter = item["painter"];
      double x = item["x"];
      double y = item["y"];
      painter.paint(
        canvas,
        Offset(x, y),
      );
    }

    canvas.translate(-offsetX, 0);
    List dotData = drawData["dotData"];
    for (var item in dotData) {
      double x = item["x"];
      double y = item["y"];
      double dotWidth = item["dotWidth"];
      Color color = item["color"];
      _paint.color = color;
      canvas.drawOval(Rect.fromLTWH(x, y, dotWidth, dotWidth), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
