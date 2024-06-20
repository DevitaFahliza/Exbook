// services/book_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exbook/models/book.dart';

Future<List<Book>> fetchBooks({String? query}) async {
  var url = Uri.parse('http://localhost:3000/api/books');

  // Jika terdapat query pencarian, tambahkan query tersebut ke URL
  if (query != null && query.isNotEmpty) {
    url = Uri.parse('http://localhost:3000/api/books?query=$query');
  }

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((book) => Book.fromJson(book)).toList();
  } else {
    throw Exception('Failed to load books');
  }
}
