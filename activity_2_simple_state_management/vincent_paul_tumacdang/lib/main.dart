import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'landingpage.dart'; // Import landingpage.dart file

void main() {
  runApp(const MyApp());
}

// Endpoint
const endpoint = 'https://jsonplaceholder.typicode.com/albums';

// Album class
class Album {
  final int id;
  final int userId;
  final String title;

  const Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

// Function to fetch all albums
Future<Iterable<Album>> fetchAlbums() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    final rawData = response.body;
    final List<dynamic> jsonDecodeData = jsonDecode(rawData);
    final albums = jsonDecodeData.map((e) => Album.fromJson(e));
    return albums;
  } else {
    throw Exception('Failed to load album');
  }
}

// Function to fetch a single album by ID
Future<Album> fetchAlbum(int albumId) async {
  final response = await http.get(Uri.parse("$endpoint/$albumId"));

  if (response.statusCode == 200) {
    final rawData = response.body;
    final jsonDecoderData = jsonDecode(rawData);
    final album = Album.fromJson(jsonDecoderData);

    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

// MyApp class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 255, 200)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'State_Management_Vincent_Paul_Tumacdang'),
    );
  }
}

// MyHomePage class
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// _MyHomePageState class
class _MyHomePageState extends State<MyHomePage> {
  String nekuUsername = '';
  String nekuPassword = '';

  void _login() {
    // Perform login logic here
    if (nekuUsername == 'nekumaru' && nekuPassword == 'password') {
      Navigator.push( // Navigate to LandingPage upon successful login
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    } else {
      // Show alert for wrong username or password
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Wrong username or password use this,/n username: nekumaru password: password'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(''),
            Text(
              'State Management',
              style: Theme.of(context).textTheme.headline4,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text('APHLEEQISHON'),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      onChanged: (String username) {
                        setState(() {
                          nekuUsername = username;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                      onChanged: (String password) {
                        setState(() {
                          nekuPassword = password;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text("Log In"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
const endpointa = 'https://jsonplaceholder.typicode.com/albums';
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Center(
        child: Text(
          'Vincent Paul Tumacdang',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
