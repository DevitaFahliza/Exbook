import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exbook/models/wishlist_model.dart';
import 'package:exbook/models/book.dart';
import 'book_detail_screen.dart';

class SimpanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wishlistModel = Provider.of<WishlistModel>(context);

    return wishlistModel.wishlist.isEmpty
        ? Center(child: Text('Tidak ada buku di wishlist'))
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: wishlistModel.wishlist.length,
              itemBuilder: (context, index) {
                var book = wishlistModel.wishlist[index];
                return BookItem(book: book);
              },
            ),
          );
  }
}

class BookItem extends StatefulWidget {
  final Book book;

  BookItem({required this.book});

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    var wishlistModel = Provider.of<WishlistModel>(context);
    bool isFavorite = wishlistModel.isBookInWishlist(widget.book);

    void toggleFavorite() {
      if (isFavorite) {
        wishlistModel.removeBook(widget.book);
      } else {
        wishlistModel.addBook(widget.book);
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: widget.book)),
        );
      },
      child: Stack(
        children: [
          Container(
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
                      widget.book.imageUrl,
                      height: 140,
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
                        widget.book.title.length > 20 ? '${widget.book.title.substring(0, 20)}...' : widget.book.title,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Text(
                        '\Rp. ${widget.book.price.toString()}',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
