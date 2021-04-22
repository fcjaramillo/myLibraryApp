import 'package:flutter_test/flutter_test.dart';

import 'package:mylibrary/api/repository/interactor/book_interactor.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';

import 'package:mockito/mockito.dart';
import 'package:mylibrary/pages/home/home_view_model.dart';

class MockLibRoute with Mock implements LibRoute{
}

class MockDatabase with Mock implements Database{
}

class MockBookInteractor with Mock implements BookInteractor{
}


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _route = MockLibRoute();
  final _database = MockDatabase();
  final _interactor = MockBookInteractor();
  HomeViewModel subject() => HomeViewModel(_route, _database, _interactor);

  group('Texts HomeViewModel', () {

    final viewModel = subject();

    test("Verify that the search is valid", () async {
      final response = viewModel.onValidateSearch('cien años de soledad');
      expect(response, isNull);
    });

  });
}