import 'package:flutter_test/flutter_test.dart';
import 'package:mylibrary/api/model/book_model.dart';

import 'package:mylibrary/configure/lib_route.dart';

import 'package:mockito/mockito.dart';
import 'package:mylibrary/data/database.dart';
import 'package:mylibrary/pages/favorite/favorite_view_model.dart';

class MockLibRoute with Mock implements LibRoute{
}

class MockDatabase with Mock implements Database{
}

class MockBook with Mock implements BookModel{
}


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _route = MockLibRoute();
  final _database = MockDatabase();
  FavoriteViewModel subject() => FavoriteViewModel(_route, _database);

  group('Texts FavoriteViewModel', () {

    final viewModel = subject();
    final _book = MockBook();

    test("Verify that init onInit isLoading is true", () async {
      expect(viewModel.status.isLoading, true);
    });

    test("Verify that finisht onInit isLoading is false", () async {
      viewModel.onInit();
      expect(viewModel.status.isLoading, false);
    });

  });
}