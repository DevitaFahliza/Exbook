import 'package:flutter/material.dart';
import 'package:exbook/models/book.dart';
import 'package:exbook/screens/book_detail_screen.dart'; // Import file screen detail buku

class BookItem extends StatelessWidget {
  final Book book;

  BookItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  book.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title.length > 20 ? '${book.title.substring(0, 20)}...' : book.title,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    '\Rp. ${book.price.toString()}',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
