import 'package:flutter/material.dart';
import 'orders_screen.dart';
import 'simpan_screen.dart';
import 'profil_screen.dart';
import 'search_results_screen.dart';
import 'package:exbook/models/book.dart';
import 'package:exbook/services/book_service.dart';
import 'book_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:exbook/models/wishlist_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    OrdersScreen(),
    SimpanScreen(),
    ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //appBar: AppBar(
      //  title: Text('ExBook'),
      //),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF5722),
        unselectedItemColor: Color(0xFFCECECE),
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  TextEditingController searchController = TextEditingController();
  Future<List<Book>>? futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Hallo, Karina!', style: Theme.of(context).textTheme.headline1),
            //Text('Temukan buku yang kamu cari', style: Theme.of(context).textTheme.bodyText1),
            //SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onTap: () {
                  _navigateToSearch();
                },
                decoration: InputDecoration(
                  hintText: 'Cari Buku',
                  hintStyle: TextStyle(color: Color(0xFFCECECE)),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.search, color: Color(0xFF8E8E8E)),
                      onPressed: _navigateToSearch,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 87, 34),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.only(left: 35.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Temukan buku bekas yang anda cari dengan mudah',
                      style: TextStyle(
                        color: Color(0xFFFFF4ED),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/book.png', height: 160),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<Book>>(
              future: futureBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
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
          ],
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
