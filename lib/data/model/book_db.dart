import 'package:hive/hive.dart';

part 'book_db.g.dart';

@HiveType(typeId: 0)
class BookDb {

  @HiveField(0)
  bool hasFulltext;

  @HiveField(1)
  int editionCount;

  @HiveField(2)
  String title;

  @HiveField(3)
  List<String> authorName;

  @HiveField(4)
  int firstPublishYear;

  @HiveField(5)
  String key;

  @HiveField(6)
  List<String> ia;

  @HiveField(7)
  List<String> authorKey;

  BookDb({
    required this.hasFulltext,
    required this.editionCount,
    required this.title,
    required this.authorName,
    required this.firstPublishYear,
    required this.key,
    required this.ia,
    required this.authorKey,
  });

}