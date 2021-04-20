// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$BookService extends BookService {
  _$BookService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BookService;

  @override
  Future<Response<ResponseBookModel>> getBooks(String search) {
    final $url = '/search.json?q=$search';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ResponseBookModel, ResponseBookModel>($request);
  }
}
