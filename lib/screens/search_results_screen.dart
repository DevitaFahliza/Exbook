import 'package:flutter/material.dart';
import 'package:exbook/models/book.dart';
import 'package:exbook/services/book_service.dart';
import 'book_detail_screen.dart'; // Import layar detail buku

class SearchResultsScreen extends StatefulWidget {
  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    futureBooks = fetchBooks(query: ''); // Memuat buku kosong pada awalnya
  }

  void _onSearchChanged() {
    setState(() {
      futureBooks = fetchBooks(query: searchController.text); // Memuat buku berdasarkan pencarian saat ini
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Membersihkan controller pada saat dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari Buku...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          ),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Book>>(
          future: futureBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Produk tidak ada'));
            } else {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return BookItem(book: snapshot.data![index]);
                },
              );
            }
          },
        ),
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
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    // Logika tambahan untuk menyimpan status favorit ke database bisa ditambahkan di sini.
  }

  @override
  Widget build(BuildContext context) {
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
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    widget.book.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.contain,
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
