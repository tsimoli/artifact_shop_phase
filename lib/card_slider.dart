import 'dart:async';

import 'package:flutter/material.dart';

class CardSlider extends StatefulWidget {
  final StreamController<double> cardUpdateStream;

  const CardSlider({Key key, this.cardUpdateStream}) : super(key: key);

  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  var _value = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SliderTheme(
          data: SliderThemeData(
              activeTrackColor: Colors.blueGrey,
              inactiveTrackColor: Colors.blueGrey,
              disabledActiveTrackColor: Colors.blue,
              disabledInactiveTrackColor: Colors.blue,
              activeTickMarkColor: Colors.blue,
              inactiveTickMarkColor: Colors.blue,
              disabledActiveTickMarkColor: Colors.blue,
              disabledInactiveTickMarkColor: Colors.blue,
              thumbColor: Colors.blue,
              disabledThumbColor: Colors.blue,
              overlayColor: Colors.transparent,
              valueIndicatorColor: Colors.blue,
              thumbShape: _CustomThumbShape(),
              valueIndicatorShape: _CustomValueIndicatorShape(),
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorTextStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              )),
          child: Slider(
            value: _value,
            min: 1.0,
            max: 8.0,
            semanticFormatterCallback: (double value) =>
                value.round().toString(),
            label: '${_value.round()}',
            onChanged: (double value) {
              setState(() {
                _value = value;
                widget.cardUpdateStream.add(value);
              });
            },
          ),
        ),
      ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 6.0;
  static const double _disabledThumbSize = 5.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Tween<double> sizeTween = new Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final Path thumbPath = _card(
      55.0,
      35.0,
      thumbCenter,
    );

    final Path thumbPath2 = _card(
      40.0,
      35.0,
      thumbCenter,
    );
    final Offset ovalOffset = new Offset(0.0, 21.0);

    final Path oval = _oval(thumbCenter + ovalOffset, 3.0);

    canvas.drawPath(
      thumbPath,
      new Paint()..color = Color.fromRGBO(167, 142, 50, 1.0),
    );
    canvas.drawPath(thumbPath2, new Paint()..color = Colors.blueGrey);
    canvas.drawPath(
      oval,
      new Paint()..color = Color.fromRGBO(167, 142, 50, 1.0),
    );
  }
}

class _CustomValueIndicatorShape extends SliderComponentShape {
  static const double _indicatorSize = 6.0;
  static const double _disabledIndicatorSize = 5.0;
  static const double _slideUpHeight = 65.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return new Size.fromRadius(
        isEnabled ? _indicatorSize : _disabledIndicatorSize);
  }

  static final Tween<double> sizeTween = new Tween<double>(
    begin: _disabledIndicatorSize,
    end: _indicatorSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final Tween<double> slideUpTween = new Tween<double>(
      begin: 0.0,
      end: _slideUpHeight,
    );
    final Offset slideUpOffset =
        new Offset(0.0, -slideUpTween.evaluate(activationAnimation));

    final Path thumbPath = _card(
      55.0,
      35.0,
      thumbCenter + slideUpOffset,
    );

    final Path thumbPath2 = _card(
      40.0,
      35.0,
      thumbCenter + slideUpOffset,
    );

    final Offset ovalOffset = new Offset(0.0, 21.0);

    final Path oval = _oval(thumbCenter + slideUpOffset + ovalOffset, 3.0);

    canvas.drawPath(
      thumbPath,
      new Paint()..color = Color.fromRGBO(167, 142, 50, 1.0),
    );
    canvas.drawPath(thumbPath2, new Paint()..color = Colors.blueGrey);
    canvas.drawPath(
      oval,
      new Paint()..color = Color.fromRGBO(167, 142, 50, 1.0),
    );

    labelPainter.paint(
        canvas,
        thumbCenter +
            slideUpOffset +
            new Offset(-labelPainter.width / 2.0, -labelPainter.height + 10.0));
  }
}

Path _card(double height, double width, Offset thumbCenter) {
  final Path thumbPath = new Path();

  final double cardHeight = height;
  final double cardWidth = width;
  final double cardHalfSide = cardWidth / 2.0;

  thumbPath.moveTo(
      thumbCenter.dx - cardHalfSide, thumbCenter.dy + (cardHeight / 2.0));
  thumbPath.lineTo(
      thumbCenter.dx - cardHalfSide, thumbCenter.dy - (cardHeight / 2.0));
  thumbPath.lineTo(
      thumbCenter.dx + cardHalfSide, thumbCenter.dy - (cardHeight / 2.0));
  thumbPath.lineTo(
      thumbCenter.dx + cardHalfSide, thumbCenter.dy + (cardHeight / 2.0));
  thumbPath.close();
  return thumbPath;
}

Path _oval(Offset thumbCenter, double radius) {
  final Path thumbPath = new Path();

  thumbPath.moveTo(thumbCenter.dx, thumbCenter.dy);
  thumbPath.addOval(Rect.fromCircle(center: thumbCenter, radius: radius));

  return thumbPath;
}
