import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progmob/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Center(child: Text('Menu Beranda')),
    Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/rumah_sakit.jpg', height: 500),
      ],
    )),
    Center(child: TextButton(onPressed: () {}, child: Text('Logout'))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 28, 237, 223),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Mobile App Kesehatan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      goUser(dio, myStorage, apiUrl);
                    },
                    child: Text('Cek User'),
                  ),
                  TextButton(
                    onPressed: () {
                      goLogout(context, dio, myStorage, apiUrl);
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _pages[
          _selectedIndex], // Menampilkan halaman sesuai dengan index yang terpilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Rumah Sakit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex:
            _selectedIndex, // Menentukan item mana yang sedang dipilih
        onTap: _onItemTapped, // Menangani perubahan item yang dipilih
      ),
    );
  }
}

void goUser(dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

void goLogout(context, dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigasi ke HomePage
      ),
    );
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
