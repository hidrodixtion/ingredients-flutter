// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients/detail.dart';

import 'package:ingredients/main.dart';
import 'package:ingredients/model/food.dart';
import 'package:ingredients/service/meal_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group("test main widget", () {
    final client = MockClient();
    final service = MealService.shared();

    setUp(() {
      service.client = client;
    });

    testWidgets('Main is shown and loading', (WidgetTester tester) async {
      var response = """
      {
        "meals": [
        {
          "strMeal": "Apple & Blackberry Crumble",
          "strMealThumb": "",
          "idMeal": "52893"
        }
        ]
      }
      """;
      when(client.get(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=seafood"))
          .thenAnswer((_) async => http.Response(response, 200));

      when(client.get(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=dessert"))
          .thenAnswer((_) async => http.Response(response, 200));

      await tester.pumpWidget(MyApp());
      expect(find.text("Memuat Daftar Makanan"), findsOneWidget);
    });
  });
}
