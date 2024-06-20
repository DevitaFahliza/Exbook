import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang putih
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'ExBook',
          style: TextStyle(
            fontSize: 40, // Sesuaikan ukuran font sesuai keinginan
            color: Color(0xFFFF5722), // Warna oranye sesuai dengan gambar
            fontWeight: FontWeight.bold, // Teks tebal
          ),
        ),
      ),
    );
  }
}
