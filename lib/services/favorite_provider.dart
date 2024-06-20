import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exbook/models/book.dart';

class FavoriteProvider with ChangeNotifier {
  List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;

  FavoriteProvider() {
    loadFavoriteBooks();
  }

  void toggleFavoriteStatus(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${book.id}_favorite';
    final isFavorite = prefs.getBool(key) ?? false;

    if (isFavorite) {
      _favoriteBooks.removeWhere((item) => item.id == book.id);
      await prefs.remove(key);
    } else {
      _favoriteBooks.add(book);
      await prefs.setBool(key, true);
    }

    notifyListeners();
  }

  void loadFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final List<Book> loadedBooks = [];
    for (final key in keys) {
      if (key.endsWith('_favorite') && prefs.getBool(key) == true) {
        final bookId = int.parse(key.split('_')[0]);
        final book = await fetchBookById(bookId);
        if (book != null) {
          loadedBooks.add(book);
        }
      }
    }

    _favoriteBooks = loadedBooks;
    notifyListeners();
  }

  Future<Book?> fetchBookById(int id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/books'));
      if (response.statusCode == 200) {
        final List<dynamic> booksJson = json.decode(response.body);
        final List<Book> allBooks = booksJson.map((json) => Book.fromJson(json)).toList();
        // Perbaikan untuk mengembalikan null jika buku tidak ditemukan
        for (var book in allBooks) {
          if (book.id == id) {
            return book;
          }
        }
        return null;
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print("Error fetching book by ID: $e");
      return null;
    }
  }

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/books'));
      if (response.statusCode == 200) {
        final List<dynamic> booksJson = json.decode(response.body);
        return booksJson.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }
}
