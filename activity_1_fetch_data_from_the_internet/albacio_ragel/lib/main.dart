import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// Fetching data from the internet (begin)
const endpoint = 'https://jsonplaceholder.typicode.com/albums';

Future<Iterable<Album>> fetchAlbums() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
      //print('Janel this is the data nang lahat nang albums');
      final rawData = response.body;
      final List jsonDecodeData = jsonDecode(rawData);
      final albums = jsonDecodeData.map((e) => Album.fromJson(e));

      //print('Raw Data: $rawData');
      //print('JSON Decoded through list: $jsonDecodeData');
      //print('Albums: $albums');

      return albums;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> fetchAlbum(int albumId) async {
  final response = await http.get(Uri.parse("$endpoint/$albumId"));
    if (response.statusCode == 200) {
      print('this is the data nang isang album lang-Ragel');
      final rawData = response.body;
      final jsonDecodeData = jsonDecode(rawData);
      final album = Album.fromJson(jsonDecodeData);
      
      print('Raw Data: $rawData');
      print('JSON Decoded: ${jsonDecode(response.body)};');
      print('Album Obejct: $album');

      print(album.id);
      print(album.title);
      return album;
  } else {
    throw Exception('Failed to load album');
  }
}

//Fetching data from the internet (end)
// Create dart object to represent an Album
class Album {
  final int id;
  final int userId;
  final String title;

//constructor
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
      title: 'Fetch data from the internet Ragel.',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 133, 198, 218)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fetch data from the internet Ragel.'),
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
  var chosenLugar = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (chosenLugar) {
    case 0:
      page = AlbumsPage();
    case 1:
      page = PhotosPage();
    default:
      throw UnimplementedError('None ganyan');
  }
    
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,  
        title: Text(widget.title),
      ),
      body: Center(      
        child: Row(
          children: [
         NavigationRail(
          backgroundColor: Colors.brown,
          //extended: true,
          elevation: 5,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.photo_album), 
              label: Text ('Photo ALbums'),
              ),
              NavigationRailDestination(
              icon: Icon(Icons.photo), 
              label: Text ('Photo'),
              ),
              NavigationRailDestination(
              icon: Icon(Icons.info), 
              label: Text ('Above'),
              ),
          ], 
          selectedIndex: chosenLugar,
          onDestinationSelected: (int index) {
            if (index !=2) {
              setState(() {
              chosenLugar = index;
              });   
            }else{
              showAboutDialog(
                context: context,
                applicationName: 'PHOTO ALBUM APP',
                applicationVersion: 'MAY 2024 ALBACIO_RAGEL',
              );
            }
          },
          ),
          Expanded(
            child: page,
            ),
        ],        
      ),
      ), 
    );
  }
}
class AlbumsPage extends StatefulWidget {
    const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
    late Future<Iterable<Album>> albums;

    @override
    void initState() {
      super.initState();
      albums = fetchAlbums();
  }
      @override
      Widget build(BuildContext context) {
        return Center(
          child: FutureBuilder(
            future: albums,
            builder: (context, snapshot) { 
              if (snapshot.hasData) {
                print(snapshot.requireData);

                final albumsCards = snapshot.requireData.map((album) => Card(
                  child: ListTile(
                    title: Text(album.title),
                    subtitle: Text('Photo Album'),
                  ),
                ));
                return ListView(
                  children: albumsCards.toList(),
                );
      
              }
              return CircularProgressIndicator();
            },
          ),
        );
      }
    }
class PhotosPage extends StatelessWidget {
    const PhotosPage({super.key});
    
      @override
      Widget build(BuildContext context) {
        return Center(
          child: Text('Here is the Photos Page'),
        );
      }
}