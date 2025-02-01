import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final String userEmail =
        FirebaseAuth.instance.currentUser!.email!.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Bagian Atas dengan Gambar
              Stack(
                children: [
                  Image.asset(
                    'assets/images/background.jpg', // Ganti dengan path gambar yang sesuai
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () async {
                        await AuthService().signout(context: context);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Bagian Konten Bawah
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF5C1CD8), // Warna ungu sesuai gambar
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hello there 👋',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Text(
                            userEmail,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Welcome to RAWR's Project",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Team member:",
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 2, // 2 orang per baris
                                  crossAxisSpacing: 5,
                                  shrinkWrap: true,
                                  children: [
                                    _teamMember("Syalli Polanunu", "220101061",
                                        "assets/images/syalli.jpg"),
                                    _teamMember(
                                        "Ghefira Novita Putri",
                                        "220101035",
                                        "assets/images/ghefira.jpg"),
                                    _teamMember("Intan Dewiasari Kaimudin",
                                        "220101041", "assets/images/intan.jpg"),
                                    _teamMember(
                                        "Melda Olivia Lesbatta",
                                        "220101053",
                                        "assets/images/melda.jpeg"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Spasi sebelum footer
                      // Footer "Made with Flutter by RAWR"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Made with ",
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Image.network(
                            'https://iconape.com/wp-content/files/yb/61798/png/flutter-logo.png',
                            width: 20,
                            height: 20,
                          ),
                          Text(
                            " by RAWR",
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 10), // Spasi tambahan di bawah footer
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamMember(String name, String id, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40, // Ukuran gambar anggota
          backgroundImage: AssetImage(imagePath),
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          id,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
