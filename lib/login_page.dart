import 'package:flutter/material.dart';
import 'package:progmob/home_page.dart';
import 'package:progmob/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Selamat Datang',
            style: TextStyle(
              // Mengganti 'Textyle' dengan 'TextStyle'
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Image.asset(
            'assets/login.png',
            width: 200,
          ),
          const SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color: Colors
                            .black), // Mengganti 'Textyle' dengan 'TextStyle'
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.black), // Pastikan 'Colors' diimpor
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors
                            .black), // Mengganti 'Textyle' dengan 'TextStyle'
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(), // Navigasi ke HomePage
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 237,
                          223), // Menggunakan 'const' jika konstan
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                          color: Colors
                              .white), // Mengganti 'Textyle' dengan 'TextStyle'
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegisterPage(), // Navigasi ke RegisterPage
                      ),
                    );
                  },
                  child: const Text(
                    'Belum Mempunyai Akun? Daftar',
                    style: TextStyle(
                        color: Colors
                            .black), // Mengganti 'Textyle' dengan 'TextStyle'
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
