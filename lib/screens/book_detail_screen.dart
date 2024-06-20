import 'package:flutter/material.dart';
import 'package:exbook/models/book.dart';
import 'checkout_screen.dart'; // Import layar checkout

// Widget untuk menampilkan detail buku
class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Buku',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5722),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: 80.0), // Add padding at the bottom to prevent overlap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Lebar sesuai perangkat
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // Membuat gambar rounded
                        child: Image.network(
                          book.imageUrl,
                          height: 250,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        book.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'by: ${book.author}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                // Content for Detail Buku
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Halaman',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${book.pages}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tanggal Terbit',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                book.publishDate,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kondisi',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                book.condition,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kategori',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                book.category,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                // Content for Deskripsi Buku
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi Buku',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      // Menggunakan RichText untuk menampilkan teks yang justify
                      RichText(
                        textAlign: TextAlign.justify, // Justify text alignment
                        text: TextSpan(
                          text: book.description,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0,
                    offset: Offset(0, -2), // Mengatur arah bayangan ke atas
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Harga',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${book.price.toString()}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke layar checkout saat tombol ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(book: book),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF5722), // Warna tombol
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 25.0),
                          textStyle: TextStyle(fontSize: 18.0),
                        ),
                        child: Text(
                          'Beli Sekarang',
                          style: TextStyle(
                              color: Colors.white), // Warna teks menjadi putih
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}