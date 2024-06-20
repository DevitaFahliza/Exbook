import 'package:flutter/material.dart';
import '../models/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class KelompokProfileScreen extends StatelessWidget {
  final Profile profile;

  const KelompokProfileScreen({Key? key, required this.profile})
      : super(key: key);

  Future<void> _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Kelompok'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(profile.fotoUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      profile.nama,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      profile.NPM,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      profile.Prodi,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildDataRow('TTL', profile.TTL),
              _buildDataRow('Alamat', profile.Alamat),
              _buildDataRow('Nomor HP', profile.NoHP),
              _buildDataRow('Email', profile.Email,
                  onTap: () => _launchEmail(profile.Email)),
              _buildDataRow('GitHub', profile.GitHub,
                  onTap: () => _launchWebsite(profile.GitHub)),
              _buildDataRow('LinkedIn', profile.LinkedIn,
                  onTap: () => _launchWebsite(profile.LinkedIn)),
              SizedBox(height: 20),
              _buildSectionTitle('Pendidikan'),
              _buildPendidikanList(
                  profile.Pendidikan, profile.Jurusan, profile.logoIns),
              SizedBox(height: 20),
              _buildSectionTitle('Pengalaman'),
              _buildPengalamanList(profile.Posisi, profile.NamaPT,
                  profile.waktuKerja, profile.LogoPT),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {Function? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTap != null ? () => onTap() : null,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: onTap != null ? Colors.blue : Colors.black,
                  decoration: onTap != null
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildPendidikanList(List<String> pendidikanList,
      List<String> jurusanList, List<String> logoInsList) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: pendidikanList.asMap().entries.map((entry) {
          int index = entry.key;
          String pendidikan = entry.value;
          String jurusan = jurusanList[index];
          String logoIns = logoInsList[index];

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(logoIns),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pendidikan,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          jurusan,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index != pendidikanList.length - 1)
                Column(
                  children: [
                    SizedBox(
                        height: 10), // Menambahkan jarak antara setiap item
                    Divider(
                      color: Color(0xFFD8D8D8),
                      height: 1,
                    ),
                    SizedBox(height: 10), // Menambahkan jarak setelah divider
                  ],
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPengalamanList(List<String> posisiList, List<String> namaPTList,
      List<String> waktuKerjaList, List<String> logoPTList) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: posisiList.asMap().entries.map((entry) {
          int index = entry.key;
          String posisi = entry.value;
          String namaPT = namaPTList[index];
          String waktuKerja = waktuKerjaList[index];
          String logoPT = logoPTList[index];

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(logoPT),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posisi,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          namaPT,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          waktuKerja,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (index != posisiList.length - 1)
                Divider(
                  color: Color(0xFFD8D8D8),
                  height: 1,
                ),
              SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}