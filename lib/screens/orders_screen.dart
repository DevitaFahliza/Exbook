import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_detail_screen.dart'; // Import layar detail pesanan

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isPesananSelected = true;
  Future<List<Map<String, dynamic>>>? _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _loadOrders();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _ordersFuture = _loadOrders();
    });
  }

  Future<List<Map<String, dynamic>>> _loadOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? ordersStringList = prefs.getStringList('orders') ?? [];
    return ordersStringList.map((orderString) {
      return Map<String, dynamic>.from(json.decode(orderString));
    }).toList();
  }

  List<Map<String, dynamic>> _filterOrders(List<Map<String, dynamic>> orders, bool isPesananSelected) {
    return isPesananSelected
        ? orders.where((order) => order['status'] != 'Selesai').toList()
        : orders.where((order) => order['status'] == 'Selesai').toList();
  }

  void _markAsCompleted(int index, List<Map<String, dynamic>> orders) async {
    orders[index]['status'] = 'Selesai';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedOrdersStringList = orders.map((order) => json.encode(order)).toList();
    prefs.setStringList('orders', updatedOrdersStringList);
    setState(() {
      _ordersFuture = _loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pesanan Saya')),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Center(child: Text('Pesanan')),
                  selected: _isPesananSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      _isPesananSelected = selected;
                    });
                  },
                  backgroundColor: _isPesananSelected ? Color(0xFFFF5722) : Colors.white,
                  selectedColor: _isPesananSelected ? Color(0xFFFF5722) : Colors.white,
                  selectedShadowColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: _isPesananSelected ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ChoiceChip(
                  label: Center(child: Text('Riwayat')),
                  selected: !_isPesananSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      _isPesananSelected = !selected;
                    });
                  },
                  backgroundColor: !_isPesananSelected ? Color(0xFFFF5722) : Colors.white,
                  selectedColor: !_isPesananSelected ? Color(0xFFFF5722) : Colors.white,
                  selectedShadowColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: !_isPesananSelected ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _ordersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final orders = snapshot.data!;
                  final filteredOrders = _filterOrders(orders, _isPesananSelected);

                  return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];

                      return OrderCard(
                        name: order['address'] ?? 'Alamat tidak tersedia',
                        status: order['status'] ?? '',
                        address: order['address'] ?? '',
                        title: order['title'] ?? 'Judul tidak tersedia',
                        author: order['author'] ?? 'Penulis tidak tersedia',
                        price: order['price'] ?? 0,
                        shipping: order['shipping'] ?? 0,
                        total: order['total'] ?? 0,
                        imageUrl: order['imageUrl'] ?? 'https://via.placeholder.com/100',
                        onDetailTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(order: order),
                            ),
                          );
                          setState(() {
                            _ordersFuture = _loadOrders();
                          });
                        },
                        onCompleteTap: () {
                          _markAsCompleted(index, orders);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name;
  final String status;
  final String address;
  final String title;
  final String author;
  final int price;
  final int shipping;
  final int total;
  final String imageUrl;
  final VoidCallback onDetailTap;
  final VoidCallback onCompleteTap;

  OrderCard({
    required this.name,
    required this.status,
    required this.address,
    required this.title,
    required this.author,
    required this.price,
    required this.shipping,
    required this.total,
    required this.imageUrl,
    required this.onDetailTap,
    required this.onCompleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              color: Color(0xFFFF5722),
              child: ListTile(
                leading: Icon(Icons.location_pin, color: Colors.white),
                title: Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
                trailing: Text(status, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.network(
                      imageUrl,
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$title - $author',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal Produk',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                              Text(
                                'Rp $price',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal Pengiriman',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                              Text(
                                'Rp $shipping',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pesanan',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Text(
                                'Rp $total',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: onDetailTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF5722),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Detail Pesanan', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 5),
                    if (status != 'Selesai') // Tampilkan tombol "Pesanan Selesai" hanya jika status pesanan belum 'Selesai'
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: onCompleteTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text('Pesanan Selesai', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
