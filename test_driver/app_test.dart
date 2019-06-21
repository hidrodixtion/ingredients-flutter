import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('app testing', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    final progressTextFinder = find.byValueKey("progress_info");
    final mealGridItemFinder = find.byValueKey("meal_grid_item_0_text");
    final menuFavorite = find.byValueKey("menu_favorite");
    final menuDessert = find.byValueKey("menu_dessert");
    final menuSearch = find.byValueKey("menu_search");
    final detailAppBarFinder = find.byValueKey("detail_appbar_title");
    final detailMealName = find.byValueKey("detail_meal_name");
    final detailFavoriteButton = find.byValueKey("detail_favorite");
    final detailSnackbarText = find.byValueKey("detail_snackbar_text");
    final backButton = find.byTooltip('Back');
    final searchField = find.byValueKey("search_field");
    final searchButton = find.byValueKey("search_button");

    String mealName = "";

    test('open a meal detail', () async {
      await driver.waitForAbsent(progressTextFinder);

      mealName = await driver.getText(mealGridItemFinder);

      await driver.tap(mealGridItemFinder);

      await driver.waitForAbsent(mealGridItemFinder);

      expect(await driver.getText(detailAppBarFinder), "Detail Bahan");

      expect(await driver.getText(detailSnackbarText), "Anda memilih: $mealName");

      expect(await driver.getText(detailMealName), mealName);
    });

    test('add a detail to favorite', () async {
      await driver.tap(detailFavoriteButton);

      await driver.tap(backButton);

      await driver.tap(menuFavorite);

      expect(await driver.getText(mealGridItemFinder), mealName);
    });

    test('search and show the result', () async {
      await driver.tap(menuDessert);

      await driver.tap(menuSearch);

      await driver.waitForAbsent(mealGridItemFinder);

      await driver.tap(searchField);
      await driver.enterText("cake");
      await driver.tap(searchButton);

      var mealName = await driver.getText(mealGridItemFinder);
      expect(mealName, isNotNull);

      await driver.tap(mealGridItemFinder);

      await driver.waitForAbsent(mealGridItemFinder);

      expect(await driver.getText(detailMealName), mealName);
    });

    tearDownAll(() async {
       driver?.close();
    });
  });
}