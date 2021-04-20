import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'book_model.g.dart';

abstract class BookModel implements Built<BookModel, BookModelBuilder> {

  @BuiltValueField(wireName: 'has_fulltext')
  bool? get hasFulltext;

  @BuiltValueField(wireName: 'edition_count')
  int? get editionCount;

  String? get title;

  @BuiltValueField(wireName: 'author_name')
  BuiltList<String> get authorName;

  @BuiltValueField(wireName: 'first_publish_year')
  int? get firstPublishYear;

  String? get key;

  BuiltList<String> get ia;

  @BuiltValueField(wireName: 'author_key')
  BuiltList<String> get authorKey;

  BookModel._();
  factory BookModel([void Function(BookModelBuilder) updates]) = _$BookModel;

  static Serializer<BookModel> get serializer => _$bookModelSerializer;
}
