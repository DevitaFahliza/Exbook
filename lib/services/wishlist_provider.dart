import 'package:flutter/material.dart';
import 'package:exbook/models/book.dart';

class WishlistProvider with ChangeNotifier {
  final List<Book> _wishlist = [];

  List<Book> get wishlist => _wishlist;

  void addBookToWishlist(Book book) {
    _wishlist.add(book);
    notifyListeners(); // Memberitahu semua pendengar bahwa ada perubahan data
  }

  void removeBookFromWishlist(Book book) {
    _wishlist.remove(book);
    notifyListeners();
  }

  bool isBookInWishlist(Book book) {
    return _wishlist.contains(book);
  }
}
