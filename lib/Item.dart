class Item {
  final int cost;
  final String name;
  final Type type;
  final String text;
  final String image;
  final Rarity rarity;

  const Item(
      this.cost, this.name, this.type, this.text, this.image, this.rarity);
}

enum Type {
  Consumable,
  Weapon,
  Armor,
  Accessory,
}

enum Rarity {
  Basic,
  Common,
  Uncommon,
  Rare,
}
