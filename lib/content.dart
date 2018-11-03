import 'dart:async';
import 'dart:ui';

import 'package:artifact_shop_phase/card_slider.dart';
import 'package:artifact_shop_phase/coin_slider.dart';
import 'package:artifact_shop_phase/item_combinations_list_view.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  ContentState createState() {
    return new ContentState();
  }
}

class ContentState extends State<Content> {
  StreamController<double> coinUpdateStream;
  StreamController<double> cardUpdateStream;

  static double coinValue = 3.0;
  static double cardValue = 1.0;

  ContentState() {
    coinUpdateStream = StreamController<double>();
    cardUpdateStream = StreamController<double>();
    coinUpdateStream.stream.listen((double coinUpdate) {
      setState(() {
        coinValue = coinUpdate;
      });
    });

    cardUpdateStream.stream.listen((double cardUpdate) {
      setState(() {
        cardValue = cardUpdate;
      });
    });
  }

  @override
  void dispose() {
    coinUpdateStream.close();
    cardUpdateStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                "Artifact shopping phase",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.amber[900],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Switch(
                    value:
                        (DynamicTheme.of(context).brightness as Brightness) ==
                            Brightness.dark,
                    onChanged: (bool value) {
                      if (value) {
                        DynamicTheme.of(context).setBrightness(Brightness.dark);
                      } else
                        DynamicTheme.of(context)
                            .setBrightness(Brightness.light);
                    },
                  ),
                  Icon(Icons.brightness_medium),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 80.0),
                child: Card(
                  color: Colors.blueGrey,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Find out the item combinations that your opponent can buy in shop phase",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Coins used",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "${coinValue.round()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              CoinSlider(coinUpdateStream: coinUpdateStream),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Cards added",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "${cardValue.round()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              CardSlider(cardUpdateStream: cardUpdateStream),
              Divider(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemCombinationListView(
                                coins: coinValue.round(),
                                cards: cardValue.round(),
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "Show combinations",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
