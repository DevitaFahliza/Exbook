import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exbook/models/book.dart';
import 'orders_screen.dart'; // Import layar pesanan saya

class CheckoutScreen extends StatelessWidget {
  final Book book;

  CheckoutScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat Pengiriman',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('Karina Blu'),
                  Text('0812-3456-7890'),
                  Text(
                      'Jl. Ahmad Yani No.174, Kec. Gayungan, Surabaya, Jawa Timur 60235'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      book.imageUrl,
                      height: 100,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(book.author),
                      Text(
                        'Rp ${book.price.toString()}',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF5722)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rincian Pembayaran',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal Produk'),
                      Text('Rp ${book.price.toString()}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal Pengiriman'),
                      Text('Rp 14.000'),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Pembayaran',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Rp ${(book.price + 14000).toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            // Simpan data pesanan ke SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String>? orders = prefs.getStringList('orders') ?? [];
            Map<String, dynamic> order = {
              'title': book.title,
              'author': book.author,
              'price': book.price,
              'imageUrl': book.imageUrl,
              'address':
                  'Jl. Ahmad Yani No.174, Kec. Gayungan, Surabaya, Jawa Timur 60235',
              'shipping': 14000,
              'total': book.price + 14000,
            };
            orders.add(json.encode(order)); // Encode data sebagai JSON string
            prefs.setStringList('orders', orders);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(context).pop(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrdersScreen(),
                    ),
                  );
                });

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.all(20.0),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ikon untuk indikasi sukses
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50.0,
                      ),
                      SizedBox(height: 16.0),
                      // Teks judul
                      Text(
                        "Pesanan Berhasil di Buat!",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      // Teks isi
                      Text(
                        "Terima kasih telah melakukan pemesanan. Pesanan Anda sedang diproses.",
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // Tombol Tindakan
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF5722), // Warna tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                        child: Text(
                          'Lihat Pesanan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF5722),
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 25.0),
            textStyle: TextStyle(fontSize: 18.0),
          ),
          child: Text(
            'Beli',
            style: TextStyle(color: Colors.white), // Warna teks menjadi putih
          ),
        ),
      ),
    );
  }
}