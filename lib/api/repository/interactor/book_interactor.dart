import 'package:built_collection/built_collection.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/api/model/response_book_model.dart';
import 'package:mylibrary/api/repository/service/book_service.dart';

class BookInteractor {

  final service = BookService.create();

  Future<ResponseBookModel> getBooks(String search, String page) async {
    final response = await service.getBooks(search, page);
    return response.body!;
  }

}