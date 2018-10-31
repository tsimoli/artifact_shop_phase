import 'dart:async';
import 'dart:ui';

import 'package:artifact_shop_phase/item_combinations_list_view.dart';
import 'package:artifact_shop_phase/card_slider.dart';
import 'package:artifact_shop_phase/coin_slider.dart';
import 'package:artifact_shop_phase/item_combinations_creator.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Coins",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Radiance',
                    ),
                  ),
                  Text(
                    "${coinValue.round()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Radiance',
                    ),
                  ),
                ],
              ),
              CoinSlider(coinUpdateStream: coinUpdateStream),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Cards",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Radiance',
                    ),
                  ),
                  Text(
                    "${cardValue.round()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Radiance',
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
                      style: TextStyle(color: Colors.white),
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
