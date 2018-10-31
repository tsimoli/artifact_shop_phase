import 'package:artifact_shop_phase/Item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 30.0,
            width: 200.0,
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(128, 109, 38, 1.0),
                    Color.fromRGBO(167, 142, 50, 1.0),
                  ], // whitish to gray
                  tileMode: TileMode.clamp,
                ),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0))),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: Container(
              child: Text(
                "${item.name}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Radiance',
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            child: Container(
              width: 200.0,
              child: Image.asset("assets/${item.image}"),
            ),
          ),
          Positioned(
            top: 187.0,
            left: 0.0,
            width: 220.0,
            child: Image.asset("assets/text_background.jpg"),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              height: 15.0,
              width: 200.0,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(128, 109, 38, 1.0),
                      Color.fromRGBO(167, 142, 50, 1.0),
                    ], // whitish to gray
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0))),
            ),
          ),
          Positioned(
            bottom: 5.0,
            left: 0.0,
            child: Container(
              height: 20.0,
              width: 200.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(128, 109, 38, 1.0),
                      Color.fromRGBO(167, 142, 50, 1.0),
                    ], // whitish to gray
                    tileMode: TileMode.clamp,
                  )),
              child: _getRarityImage(item.rarity),
            ),
          ),
          Positioned(
            bottom: 2.0,
            right: 10.0,
            child: Container(
              width: 50.0,
              child: Image.asset("assets/cardstat-goldcost.png"),
            ),
          ),
          _buildCardCostText(item.cost),
          Positioned(
            top: 35.0,
            left: 5.0,
            child: Container(
              width: 40.0,
              child: _buildType(item.type),
            ),
          ),
          Positioned(
            top: 200.0,
            left: 18.0,
            width: 170.0,
            child: Container(
              child: Text(
                "${item.text}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontFamily: 'Radiance',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardCostText(int cost) {
    if (cost > 9) {
      return Positioned(
        bottom: 15.0,
        right: 25.0,
        width: 21.0,
        child: Text(
          "${item.cost}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18.0),
        ),
      );
    } else {
      return Positioned(
        bottom: 15.0,
        right: 20.0,
        width: 21.0,
        child: Text(
          "${item.cost}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18.0),
        ),
      );
    }
  }

  Widget _buildType(Type itemType) {
    var imageLocation = "";
    switch (itemType) {
      case Type.Accessory:
        imageLocation = "assets/accessory.png";
        break;
      case Type.Weapon:
        imageLocation = "assets/weapon.png";
        break;
      case Type.Armor:
        imageLocation = "assets/armor.png";
        break;
      case Type.Consumable:
        imageLocation = "assets/consumable.png";
        break;
      default:
        imageLocation = "assets/accessory.png";
    }
    return Image.asset(imageLocation);
  }

  Widget _getRarityImage(Rarity rarity) {
    var imageLocation = "";
    switch (rarity) {
      case Rarity.Basic:
        imageLocation = "assets/basic.png";
        break;
      case Rarity.Common:
        imageLocation = "assets/common.png";
        break;
      case Rarity.Uncommon:
        imageLocation = "assets/uncommon.png";
        break;
      case Rarity.Rare:
        imageLocation = "assets/rare.png";
        break;
      default:
        imageLocation = "assets/basic.png";
    }
    return Image.asset(imageLocation);
  }
}
