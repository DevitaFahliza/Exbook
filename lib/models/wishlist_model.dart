import 'package:flutter/material.dart';
import 'package:exbook/models/book.dart';

class WishlistModel extends ChangeNotifier {
  final List<Book> _wishlist = [];

  List<Book> get wishlist => _wishlist;

  void addBook(Book book) {
    if (!_wishlist.contains(book)) {
      _wishlist.add(book);
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    _wishlist.remove(book);
    notifyListeners();
  }

  bool isBookInWishlist(Book book) {
    return _wishlist.contains(book);
  }
}
