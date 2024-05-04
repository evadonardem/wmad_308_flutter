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
  int _selectedIndex = 0;

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
      body: Center(
        child: Row(
          children: [
            NavigationRail(
              backgroundColor: Colors.blue,
              extended: true,
              elevation: 5,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.photo_album),
                  label: Text("Photo Albums"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.notifications),
                  label: Text("Notification"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info),
                  label: Text("About"),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  if (index == 1) {
                    _showNotificationDialog();
                  } else if (index == 2) {
                    _showAboutDialog();
                  }
                });
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromARGB(255, 0, 255, 13), Colors.cyan],
                  ),
                ),
                child: Center(
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 1:
        // Display containers with words for Notification
        return ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('America Ya'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('halo'),
            ),
            
          ],
        );
      default:
        // Default content
        return Text('Fetch_Data_Tumacdang_Vincent_Paul');
    }
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Notification"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Messages:"),
              Text("Message1"),
              Text("Message2"),
              Text("Message3"),
              Text("Message4"),
              Text("Message5"),
              Text("Message6"),
              Text("Message7"),
              Text("Message8"),
              Text("Message9"),
              // Add more words as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("About"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Your about content goes here..."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
