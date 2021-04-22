import 'package:flutter_test/flutter_test.dart';
import 'package:mylibrary/api/model/book_model.dart';

import 'package:mylibrary/configure/lib_route.dart';

import 'package:mockito/mockito.dart';
import 'package:mylibrary/pages/detail/detail_view_model.dart';

class MockLibRoute with Mock implements LibRoute{
}

class MockBook with Mock implements BookModel{
}


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _route = MockLibRoute();
  DetailViewModel subject() => DetailViewModel(_route);

  group('Texts DetailViewModel', () {

    final viewModel = subject();
    final _book = MockBook();

    test("Verify that init onInit isLoading is true", () async {
      expect(viewModel.status.isLoading, true);
    });

    test("Verify that finisht onInit isLoading is false", () async {
      viewModel.onInit(_book, true);
      expect(viewModel.status.isLoading, false);
    });
    
    test("Verify that the favorite tap is valid", () async {
      viewModel.onTapFavorite();
      expect(viewModel.status.favoriteBook, true);
    });

  });
}