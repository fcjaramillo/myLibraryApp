import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:mylibrary/api/model/book_model.dart';

part 'response_book_model.g.dart';

abstract class ResponseBookModel implements Built<ResponseBookModel, ResponseBookModelBuilder> {

  int get numFound;

  int get start;

  BuiltList<BookModel> get docs;

  ResponseBookModel._();
  factory ResponseBookModel([void Function(ResponseBookModelBuilder) updates]) = _$ResponseBookModel;

  static Serializer<ResponseBookModel> get serializer => _$responseBookModelSerializer;
}
