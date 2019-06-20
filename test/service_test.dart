import 'package:ingredients/model/food.dart';
import 'package:ingredients/model/food_detail.dart';
import 'package:ingredients/service/meal_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('fetch list', () {
    final client = MockClient();
    final service = MealService.shared();

    setUp(() {
      service.client = client;
    });

    test('returns List of food when http call completes', () async {
      var response = """
      {
        "meals": [
        {
          "strMeal": "Apple & Blackberry Crumble",
          "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
          "idMeal": "52893"
        }
        ]
      }
      """;

      const category = "seafood";
      when(client.get(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"))
          .thenAnswer((_) async => http.Response(response, 200));
      
      expect(await service.getCategory(category), isA<List<Food>>());
    });

    test('return meal detail', () async {
      var response = """
      {
        "meals": [
        {
          "strMeal": "Apple & Blackberry Crumble",
          "strArea": "Japanese",
          "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
          "strInstructions": "Preheat oven to 350° F."
        }
        ]
      }
      """;

      const id = "01";
      when(client.get(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"))
          .thenAnswer((_) async => http.Response(response, 200));

      expect(await service.getDetail(id), isA<FoodDetail>());
    });
  });
}