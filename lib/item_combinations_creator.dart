import 'package:artifact_shop_phase/Item.dart';
import 'package:artifact_shop_phase/items.dart';
import 'package:trotter/trotter.dart';

class ItemCombinationsCreator {
  static List<List<Item>> getCombinations(List coinsAndCards) {
    List<List<Item>> combinations = [];

    var itemCompositions = Compositions(coinsAndCards[1],
        Items.items.where((item) => item.cost <= coinsAndCards[0]).toList());

    for (var itemComposition in itemCompositions()) {
      var totalCost = 0;
      for (var item in itemComposition) {
        totalCost += (item as Item).cost;
      }
      // Some limit here to prevent long calculations
      if (combinations.length >= 50 || totalCost > (coinsAndCards[0] + 50)) {
        break;
      }

      if (totalCost == coinsAndCards[0] &&
          (coinsAndCards[1] < 3 ||
              !_containsMoreThan3OfSameItem(itemComposition.cast<Item>()))) {
        combinations.add(itemComposition.cast<Item>());
      }
    }

    return combinations;
  }

  /// Compare already added combinations to possible item combination.
  /// First sort both lists by item name. Then check if there is item with same
  /// name in same index.
  /*static bool _combinationAlreadyExists(
      List<List<Item>> combinations, List<Item> itemComposition) {
    if (combinations.length == 0) return false;

    itemComposition.sort((a, b) => a.name.compareTo(b.name));
    var combinationExists = true;

    for (var combination in combinations) {
      combination.sort((a, b) => a.name.compareTo(b.name));
      for (var i = 0; i < itemComposition.length; i++) {
        if (itemComposition[i].name != combination[i].name) {
          combinationExists = false;
          break;
        }
      }
      if (combinationExists) {
        break;
      }
    }
    return combinationExists;
  }
  */

  static bool _containsMoreThan3OfSameItem(List<Item> itemComposition) {
    for (var comparedItem in itemComposition) {
      if (itemComposition
              .where((item) => item.name == comparedItem.name)
              .toList()
              .length >
          3) {
        return true;
      }
    }
    return false;
  }
}
