import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animate_do/animate_do.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? memeUrl;

  Future<void> fetchMeme() async {
    final response = await http.get(Uri.parse('https://meme-api.com/gimme'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        memeUrl = data['url'];
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final String userEmail =
        FirebaseAuth.instance.currentUser?.email ?? 'user@gmail.com';

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: FadeInDown(
          child: Text(
            "Meme Generator",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.yellow, size: 30),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInLeft(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi there!",
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
                  ),
                ),
                const SizedBox(height: 50),
                BounceInDown(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Generate Meme",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: memeUrl != null
                              ? Image.network(memeUrl!,
                                  height: 300, fit: BoxFit.cover)
                              : Image.asset("assets/images/placeholder.jpeg",
                                  height: 300, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: fetchMeme,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            "Generate",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FadeInUp(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.deepPurple,
          child: const Text(
            "© 2025 Meme Generator - By RAWR",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
