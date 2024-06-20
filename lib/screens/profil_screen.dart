import 'package:flutter/material.dart';
import 'profileKel_screen.dart';
import '../models/profile.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        backgroundColor: Color(0xFFFF5722),
        foregroundColor: Color(0xFFFEFEFE),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Prevents clipping of overflow
              children: [
                Container(
                  width: deviceWidth,
                  height: 280,
                  color: Color(0xFFFF5722),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xFFFEFEFE),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/karina.jpg'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Karina Blu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200, // Adjust this value as needed
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserData(
                            context, 'Email', '   katarinabluu@gmail.com'),
                        _buildUserData(context, 'No. HP', '087712345678'),
                        _buildUserData(context, 'Alamat',
                            'Jl. Ahmad Yani No.174, Kec. Gayungan, Surabaya, Jawa Timur 60235'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100), // Adjust this value to provide spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile Kelompok',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                for (Profile profile in Profile.samples)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: DeveloperContainer(
                      profile: profile,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KelompokProfileScreen(
                              profile: profile,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserData(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperContainer extends StatelessWidget {
  final Profile profile;
  final VoidCallback onTap;

  const DeveloperContainer({
    Key? key,
    required this.profile,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                profile.fotoUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.nama,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profile.NPM,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  profile.Prodi,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}