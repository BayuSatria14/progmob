import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob/home_page.dart';
import 'package:progmob/register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final token = myStorage.read('token');
    if (token != null) {
      // Jika pengguna sudah login, arahkan ke halaman login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(), // Navigasi ke HomePage
        ),
      );
    }
  }

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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  controller: passwordController,
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
                      goLogin(context, dio, myStorage, apiUrl, emailController,
                          passwordController);
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
                            RegisterPage(), // Navigasi ke RegisterPage
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

void goLogin(context, dio, myStorage, apiUrl, emailController,
    passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);

    myStorage.write('token', response.data['data']['token']);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(), // Navigasi ke HomePage
      ),
    );
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
