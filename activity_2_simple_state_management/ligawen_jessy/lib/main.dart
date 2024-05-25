import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    print('Here is the data of an album:');
    final rawData = response.body;
    final jsonDecodeData = jsonDecode(rawData);
    final album = Album.fromJson(jsonDecodeData);

    print('Raw: $rawData');
    print('JSON Decoded: $jsonDecodeData');
    print('Album Object: $album');

    print(album.id);
    print(album.title);
    return album;
  } else {
    throw Exception('Failed to load album');
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
    );
  }
}

const endpoint = 'https://jsonplaceholder.typicode.com/albums/';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.deepPurple),
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
        child: LigawenLoginPage(),
      ),
    );
  }
}

class LigawenLoginPage extends StatefulWidget {
  const LigawenLoginPage({Key? key}) : super(key: key);

  @override
  State<LigawenLoginPage> createState() => _LigawenLoginPageState();
}

class _LigawenLoginPageState extends State<LigawenLoginPage> {
  late String ligawenUsernameEntered;
  late String ligawenPasswordEntered;
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    ligawenUsernameEntered = "";
    ligawenPasswordEntered = "";
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
                    onChanged: (String ligawenUsername) {
                      print('This is the username $ligawenUsername');
                      setState(() {
                        ligawenUsernameEntered = ligawenUsername;
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
                    onChanged: (String ligawenPassword) {
                      setState(() {
                        print('This is the password $ligawenPassword');
                        ligawenPasswordEntered = ligawenPassword;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      print("OKAY");
                   
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
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
          const Text('Login Page By Jessy Glenn Ligawen'),
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
              onPressed: () {
                
              },
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
        child: Text('Jessy Glenn T. Ligawen'),
      ),
    );
  }
}
