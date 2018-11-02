import 'package:artifact_shop_phase/Item.dart';
import 'package:artifact_shop_phase/item_combinations_creator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemCombinationListView extends StatefulWidget {
  final int coins;
  final int cards;

  ItemCombinationListView({Key key, this.coins, this.cards}) : super(key: key);

  @override
  ItemCombinationListViewState createState() {
    return new ItemCombinationListViewState();
  }
}

class ItemCombinationListViewState extends State<ItemCombinationListView> {
  List<List<Item>> possibleItemCombinations = [];
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      _getPossibleItems();
      return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          ));
    }

    if (possibleItemCombinations.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: new Text("Item combinations",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Text(
                  "No items can be bougth with this combination of coins and cards",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  )),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title:
            new Text("Item combinations: ${possibleItemCombinations.length}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                height: 50.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Coins",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.coins}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Cards",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.cards}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: possibleItemCombinations.length,
                  itemBuilder: (context, combinationIndex) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                possibleItemCombinations[combinationIndex]
                                    .length,
                            itemBuilder: (context, itemIndex) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                width: 162.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: AssetImage(
                                            "assets/${possibleItemCombinations[combinationIndex][itemIndex].name}.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 20.0,
                          color: Colors.blueGrey,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getPossibleItems() async {
    var combinations = await compute(
        ItemCombinationsCreator.getCombinations, [widget.coins, widget.cards]);

    if (this.mounted) {
      setState(() {
        possibleItemCombinations = combinations;
        loaded = true;
      });
    }
  }
}
