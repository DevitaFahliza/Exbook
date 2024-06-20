class Profile {
  String nama;
  String fotoUrl;
  String NPM;
  String Prodi;
  String TTL;
  String Alamat;
  String NoHP;
  String Email;
  String GitHub;
  String LinkedIn;
  List<String> Pendidikan;
  List<String> Jurusan;
  List<String> logoIns;
  List<String> Penghargaan;
  List<String> WaktuPenghargaan;
  List<String> FotoPenghargaan;
  List<String> Posisi;
  List<String> NamaPT;
  List<String> waktuKerja;
  List<String> LogoPT;

  Profile({
    required this.nama,
    required this.fotoUrl,
    required this.NPM,
    required this.Prodi,
    required this.TTL,
    required this.Alamat,
    required this.NoHP,
    required this.Email,
    required this.GitHub,
    required this.LinkedIn,
    required this.Pendidikan,
    required this.Jurusan,
    required this.logoIns,
    required this.Penghargaan,
    required this.WaktuPenghargaan,
    required this.FotoPenghargaan,
    required this.Posisi,
    required this.NamaPT,
    required this.waktuKerja,
    required this.LogoPT,
  });

  static List<Profile> samples = [
    Profile(
      nama: 'Alfina Andriani',
      fotoUrl: 'assets/images/alfina.png',
      NPM: '22082010018',
      Prodi: 'S1 - Sistem Informasi',
      TTL: 'Sidoarjo, 29 Februari 2004',
      Alamat: 'Kramat Jegu, Taman, Sidoarjo',
      NoHP: '087762580748',
      Email: '22082010018@student.upnjatim.ac.id',
      GitHub: 'https://github.com/alfinaandriani',
      LinkedIn: 'http://linkedin.com/in/alfinaandriani04/',
      Pendidikan: [
        'UPN Veteran Jawa Timur',
        'SMK Negeri 3 Surabaya',
      ],
      Jurusan: [
        'Sistem Informasi',
        'Multimedia',
      ],
      logoIns: [
        'assets/images/UPNVJT.png',
        'assets/images/SMKN3SBY.png',
      ],
      Penghargaan: [
        'Peraih Pendanaan P2MW 2023 dan KMI EXPO 2023',
        'Juara 2 Lomba UI/UX Create-In V3.0',
        'Juara 3 Lomba UI/UX Dies Natalies Fasilkom 2023',
      ],
      WaktuPenghargaan: [
        'Nov 2023',
        'Oct 2023',
        'Aug 2023',
      ],
      FotoPenghargaan: [
        'assets/images/fina1.jpg',
        'assets/images/fina2.jpg',
        'assets/images/fina3.jpg',
      ],
      Posisi: [
        'Creative Marketing Specialist',
        'Freelance Graphic Designer',
        'Creative Graphic Designer',
        'Brand Creative Designer',
        'Graphic Designer Intern',
      ],
      NamaPT: [
        'Fazt Creative',
        'Sigma X Pro',
        'Skill Up',
        'Teman Bercerita Indonesia',
        'UPTI Makanan, Minuman dan Kemasan Disperindag Provinsi Jawa Timur',
      ],
      waktuKerja: [
        'Aug 2023 – Apr 2024',
        'Jul 2023 – Nov 2023',
        'Mar 2023 – Sep 2023',
        'May 2023 – Sep 2023',
        'Jan 2021 - Mar 2021',
      ],
      LogoPT: [
        'assets/images/faztcreative.png',
        'assets/images/sigmaxpro.png',
        'assets/images/skillup.png',
        'assets/images/tbi.png',
        'assets/images/mamin.png',
      ],
    ),
    Profile(
      nama: 'Devita Fahliza Ulfa',
      fotoUrl: 'assets/images/devita.png',
      NPM: '22082010027',
      Prodi: 'S1 - Sistem Informasi',
      TTL: 'Sidoarjo, 13 September 2003',
      Alamat: 'Wonoayu, Sidoarjo',
      NoHP: '0813-5566-3905',
      Email: '22082010027@student.upnjatim.ac.id',
      GitHub: 'https://github.com/DevitaFahliza',
      LinkedIn: 'https://www.linkedin.com/in/devita-fahliza-ulfa-6687472a9',
      Pendidikan: [
        'UPN Veteran Jawa Timur',
        'SMAN 1 Wonoayu',
      ],
      Jurusan: [
        'Sistem Informasi',
        'MIPA',
      ],
      logoIns: [
        'assets/images/UPNVJT.png',
        'assets/images/SMAN1Won.png',
      ],
      Penghargaan: [
        'aa',
        'bb',
      ],
      WaktuPenghargaan: [
        'Nov 2023',
        'Oct 2023',
      ],
      FotoPenghargaan: [
        'assets/images/dev1.jpeg',
        'assets/images/dev2.jpeg',
      ],
      Posisi: [
        'Head of Entrepreneurship Department',
        'Staff of Entrepreneurship Department',
        'Assistant Lecturer (programming language)',
        'Packaging and Quality Control',
      ],
      NamaPT: [
        'Himpunan Mahasiswa Sistem Informasi (HIMASIFO)',
        'Himpunan Mahasiswa Sistem Informasi (HIMASIFO)',
        'UPN Veteran Jawa Timur',
        'Kriya Kreasi',
      ],
      waktuKerja: [
        'Mar 2024 – Sekarang',
        'Mar 2023 – Mar 2024',
        'Jan 2024 - Mar 2024',
        '2023 - Sekarang',
      ],
      LogoPT: [
        'assets/images/HIMASIFO.png',
        'assets/images/HIMASIFO.png',
        'assets/images/UPNVJT.png',
        'assets/images/kriya.jpg',
      ],
    ),
  ];
}
