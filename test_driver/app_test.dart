import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Ingredients App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    final progressTextFinder = find.byValueKey("progress_info");
    final mealGridItemFinder = find.byValueKey("meal_grid_item_0");
    final detailAppBarFinder = find.byValueKey("detail_appbar_title");

    test('app is running', () async {
      await driver.waitForAbsent(progressTextFinder);

      await driver.tap(mealGridItemFinder);

      await driver.waitForAbsent(mealGridItemFinder);

      expect(await driver.getText(detailAppBarFinder), "Detail Bahan");
    });
  });
}