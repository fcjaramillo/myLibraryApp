import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:mylibrary/api/model/response_book_model.dart';
import 'package:mylibrary/api/repository/converter/built_value_converter.dart';

part 'book_service.chopper.dart';

@ChopperApi()
abstract class BookService extends ChopperService {

  @Get(path: '/search.json?q={search}')
  Future<Response<ResponseBookModel>> getBooks(
      @Path() String search,
      );

  static BookService create() {
    final client = ChopperClient(
      baseUrl: 'http://openlibrary.org',
      services: [
        _$BookService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$BookService(client);
  }
}