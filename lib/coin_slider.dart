import 'dart:async';

import 'package:flutter/material.dart';

class CoinSlider extends StatefulWidget {
  final StreamController<double> coinUpdateStream;

  const CoinSlider({Key key, this.coinUpdateStream}) : super(key: key);

  @override
  _CoinSliderState createState() => _CoinSliderState();
}

class _CoinSliderState extends State<CoinSlider> {
  var _value = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SliderTheme(
          data: SliderThemeData(
              activeTrackColor: Colors.blueGrey,
              inactiveTrackColor: Colors.blueGrey,
              disabledActiveTrackColor: Colors.yellow,
              disabledInactiveTrackColor: Colors.yellow,
              activeTickMarkColor: Colors.yellow,
              inactiveTickMarkColor: Colors.yellow,
              disabledActiveTickMarkColor: Colors.yellow,
              disabledInactiveTickMarkColor: Colors.yellow,
              thumbColor: Colors.yellow,
              disabledThumbColor: Colors.yellow,
              overlayColor: Colors.transparent,
              valueIndicatorColor: Colors.red,
              thumbShape: _CustomThumbShape(),
              valueIndicatorShape: _CustomValueIndicatorShape(),
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w900)),
          child: Slider(
            value: _value,
            min: 3.0,
            max: 50.0,
            semanticFormatterCallback: (double value) =>
                value.round().toString(),
            label: '${_value.round()}',
            onChanged: (double value) {
              setState(() {
                _value = value;
                widget.coinUpdateStream.add(value);
              });
            },
          ),
        ),
      ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 4.0;
  static const double _disabledThumbSize = 3.0;

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

    final double radius = 20.0;
    final double innerRadius = 17.0;

    final Path thumbPath = _coin(thumbCenter, radius);
    final Path thumbPath2 = _coin(thumbCenter, innerRadius);
    canvas.drawPath(thumbPath, new Paint()..color = Colors.yellow);
    canvas.drawPath(
        thumbPath2, new Paint()..color = Colors.brown.withAlpha(900));
  }
}

Path _coin(Offset thumbCenter, double radius) {
  final Path thumbPath = new Path();

  thumbPath.moveTo(thumbCenter.dx, thumbCenter.dy);
  thumbPath.addOval(Rect.fromCircle(center: thumbCenter, radius: radius));

  return thumbPath;
}

class _CustomValueIndicatorShape extends SliderComponentShape {
  static const double _indicatorSize = 6.0;
  static const double _disabledIndicatorSize = 5.0;
  static const double _slideUpHeight = 50.0;

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

    final double radius = 20.0;
    final double innerRadius = 17.0;

    final Path thumbPath = _coin(thumbCenter + slideUpOffset, radius);
    final Path thumbPath2 = _coin(thumbCenter + slideUpOffset, innerRadius);
    canvas.drawPath(thumbPath, new Paint()..color = Colors.yellow);
    canvas.drawPath(
        thumbPath2, new Paint()..color = Colors.brown.withAlpha(900));

    labelPainter.paint(
        canvas,
        thumbCenter +
            slideUpOffset +
            new Offset(-labelPainter.width / 2.0, -labelPainter.height + 10.0));
  }
}
