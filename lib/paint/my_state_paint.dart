import 'package:bar_chart_race/models/rectangle.dart';
import 'package:flutter/material.dart';

class MyStatePaint extends CustomPainter {
  final List<Rectangle> currentState;
  final double maxValue;
  final double rectHeight;
  final double totalWidth;
  final int numberOfRactanglesToShow;
  final String title;
  final TextStyle titleTextStyle;

  // rectangle paint
  final Paint rectPaint;
  // lines paint
  final Paint linePaint;

  // the lenth of the maximum value
  double maxLength;
  MyStatePaint({
    @required this.currentState,
    @required this.maxValue,
    @required this.numberOfRactanglesToShow,
    @required this.totalWidth,
    @required this.rectHeight,
    this.title,
    this.titleTextStyle,
  })  : rectPaint = Paint(),
        linePaint = Paint() {
    // proporties for rectangle paint
    rectPaint.style = PaintingStyle.fill;
    rectPaint.strokeWidth = 0;
    rectPaint.strokeCap = StrokeCap.round;

    // proporties for lines paint
    linePaint.color = Colors.grey;
    linePaint.style = PaintingStyle.stroke;
    linePaint.strokeWidth = 2;
    linePaint.strokeCap = StrokeCap.round;

    maxLength = totalWidth * 0.95;
  }

  final double spaceBetweenTwoRectangles = 6;
  final double yShift = 50;
  final double xShift = 70;
  // define text painter to paint text (write text)
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  final TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
  );

  // define text painter to paint title
  final TextPainter titlePainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  final TextStyle textStyleBold = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(xShift, yShift);
    // draw title if not null
    if (title != null) _drawTitle(canvas, title);
    // first we draw the line under the ractangles
    _drawLines(canvas);
    // we draw the rectangles
    for (int i = 0; i < currentState.length; i++) {
      _drawRectangle(currentState[i], canvas);
    }
    // draw current state label
    String stateLabel = currentState[0].stateLabel;

    if (stateLabel != null) {
      _drawStateLabel(canvas, size, stateLabel);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // TODO test this
  void _drawStateLabel(Canvas canvas, Size size, String label) {
    // draw value (text)
    textPainter.text = TextSpan(
      text: label,
      style: textStyleBold,
    );
    double x = totalWidth;
    double y = rectHeight * numberOfRactanglesToShow;
    print(y);
    canvas.save();
    textPainter.layout();
    canvas.translate(x, y);
    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width,
        textPainter.height,
      ),
    );
    canvas.restore();
  }

  void _drawTitle(Canvas canvas, String title) {
    // draw the title of the chart
    textPainter.text = TextSpan(
      text: title,
      style: titleTextStyle ?? textStyleBold,
    );
    double x = totalWidth / 2;
    double y = -40;
    canvas.save();
    textPainter.layout();
    canvas.translate(x, y + 3);
    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ),
    );
    canvas.restore();
  }

  void _drawRectangle(Rectangle rect, Canvas canvas) {
    // draw rectangle
    Path path = Path();
    double maxHeight =
        numberOfRactanglesToShow * (rectHeight + spaceBetweenTwoRectangles) -
            spaceBetweenTwoRectangles;
    // define postitons of the four corner to draw the rectangle
    double x1 = 0,
        y1 = rect.position * (rectHeight + spaceBetweenTwoRectangles);
    // if the rectancles if outside, we don't draw it
    if (y1 >= maxHeight) return;
    // min is to draw a rectangle partially, (in case it's showning up or hiding)
    double x2 = rect.length * maxLength, y2 = min(y1 + rectHeight, maxHeight);

    path.moveTo(x1, y1);
    path.lineTo(x2, y1);
    path.lineTo(x2, y2);
    path.lineTo(x1, y2);
    rectPaint.color = rect.color;
    canvas.drawPath(path, rectPaint);

    // draw value (text)
    String value = rect.value.round().toString();
    if (value.length > 5) {
      value = value.substring(0, 5) + "..";
    }
    textPainter.text = TextSpan(
      text: value,
      style: textStyle,
    );
    canvas.save();
    textPainter.layout();
    canvas.translate(x2, y1 + 3);
    textPainter.paint(
      canvas,
      Offset(
        5,
        0,
      ),
    );
    canvas.restore();

    // draw the title for each rectangle
    String label = rect.label;
    if (label.length > 7) {
      label = label.substring(0, 7) + "..";
    }
    textPainter.text = TextSpan(
      text: label,
      style: textStyle,
    );
    canvas.save();
    textPainter.layout();
    canvas.translate(0, y1 + 3);
    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width - 2,
        0,
      ),
    );
    canvas.restore();
  }

  // draw the lines with the respective value based on the current maximum value
  void _drawLines(Canvas canvas) {
    double lastDigit = maxValue;
    double p = 1;
    while (lastDigit >= 10) {
      lastDigit = lastDigit / 10.0;
      p *= 10;
    }
    double step;
    if (lastDigit < 3) {
      step = 0.5 * p / maxValue * maxLength;
    } else {
      step = 2 * p / maxValue * maxLength;
    }
    double posX = step;
    while (posX <= totalWidth) {
      double value = posX / maxLength * maxValue;
      _drawLine(canvas, posX, value.round());
      posX += step;
    }
  }

  void _drawLine(Canvas canvas, double posX, int value) {
    Path path = Path();
    // define the two point of the line
    double x1 = posX, y1 = 0;
    double x2 = posX,
        y2 = numberOfRactanglesToShow *
                (rectHeight + spaceBetweenTwoRectangles) -
            spaceBetweenTwoRectangles;
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    canvas.drawPath(path, linePaint);
    // draw the value (text)
    textPainter.text = TextSpan(
      text: value.round().toString(),
      style: textStyle,
    );
    canvas.save();
    textPainter.layout();
    canvas.translate(x1, y1);
    textPainter.paint(
      canvas,
      Offset(-(textPainter.width / 2), -(textPainter.height)),
    );
    canvas.restore();
  }

  double min(double a, double b) {
    return a < b ? a : b;
  }
}
