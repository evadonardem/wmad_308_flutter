import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    print('Raw: $rawData');
    print('Album Object: $album');
    print('JSON Decoded: ${jsonDecode(response.body)}');

    print(album.id);
    print(album.title);

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
      home: const MyHomePage(title: 'Fetch_Data_Vincent_Paul_Tumacdang'),
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
  late Future<Iterable<Album>> albums;
  late Future<Album> album;

  @override
  void initState() {
    super.initState();
    albums = fetchAlbums();
    album = fetchAlbum(12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 0, 255, 13), Colors.cyan],
          ),
        ),
        child: Center(
          child: Text('Fetch_Data_Tumacdang_Vincent_Paul'),
        ),
      ),
    );
  }
}
