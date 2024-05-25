import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<Album> fetchAlbum() async {
  const endpoint = 'https://jsonplaceholder.typicode.com/albums/';
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    final rawData = response.body;
    final jsonDecodeData = jsonDecode(rawData);
    final album = Album.fromJson(jsonDecodeData);
    return album;
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(secondary: Colors.purple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: MichaelLoginPage(),
      ),
    );
  }
}

class MichaelLoginPage extends StatefulWidget {
  const MichaelLoginPage({Key? key}) : super(key: key);

  @override
  State<MichaelLoginPage> createState() => _MichaelLoginPageState();
}

class _MichaelLoginPageState extends State<MichaelLoginPage> {
  late String michaelUsernameEntered;
  late String michaelPasswordEntered;
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    michaelUsernameEntered = "";
    michaelPasswordEntered = "";
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('LOGIN'),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                    onChanged: (String michaelUsername) {
                      setState(() {
                        michaelUsernameEntered = michaelUsername;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    onChanged: (String michaelPassword) {
                      setState(() {
                        michaelPasswordEntered = michaelPassword;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      if (michaelUsernameEntered.isNotEmpty &&
                          michaelPasswordEntered.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              username: michaelUsernameEntered,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Login Page By Michael Garcia'),
        ],
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Page'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome, $username'),
      ),
    );
  }
}