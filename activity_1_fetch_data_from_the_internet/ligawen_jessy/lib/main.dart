import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// Endpoint
const endpoint = 'https://jsonplaceholder.typicode.com/albums';

// Beginning
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

    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final int userId;
  final String title;

  const Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.fromJson(json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
          Album(
            userId: userId,
            id: id,
            title: title,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 217, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fetch_data_from_the_internet_JESS.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Iterable<Album>> albums;
  late Future<Album> album;

  @override
  void initState() {
    super.initState();
    albums = fetchAlbums();
    album = fetchAlbum(12);
  }

  void _navigateToAlbums(BuildContext context) {
    // Navigate to Albums page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlbumsPage()),
    );
  }

  void _navigateToPhotos(BuildContext context) {
    // Navigate to Photos page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotosPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name_JESSY_BOY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.album),
              title: Text('Albums'),
              onTap: () {
                _navigateToAlbums(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Photos'),
              onTap: () {
                _navigateToPhotos(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Fetch_Data_Ligawen_Jessy_Glenn'),
      ),
    );
  }
}

class AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Albums Page Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                // Perform action
              },
              child: Text('Button'),
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Photos Page Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                // Perform action
              },
              child: Text('Button'),
            ),
          ),
        ],
      ),
    );
  }
}