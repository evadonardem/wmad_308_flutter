import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Fetch data from the internet (begin)
const endpoint = 'https://jsonplaceholder.typicode.com/albums';

  Future<Iterable<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      // print('Jhaynher eto ung data ng lahat nang albums:');
      final rawData = response.body;
      final List jsonDecodeData = jsonDecode(rawData);
      final albums =jsonDecodeData.map((e) => Album.fromJson(e));

      //print('Raw Data: $rawData');
      //print('JSON Decoded through List: $jsonDecodeData');
      //print('Albums: $albums');
      return albums;
    } else {
      throw Exception('Failed to load Albums');
    }
  }

  Future fetchAlbum(int albumId)  async {
    final response =  await http.get(Uri.parse("$endpoint/$albumId"));
    if (response.statusCode == 200) {
      //print('Jhaynher eto ung data ng isang album:');
      final rawData = response.body;
      final jsonDecodeData = jsonDecode(rawData);
      final album = Album.fromJson(jsonDecodeData);

      print('Raw Data: $rawData');
      print('JSON Decoded: $jsonDecodeData');
      print('Album Object: $album');

      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Album');
    }
  }

// Fetching data from the internet (end)

//Create dart object to represent an Album
class Album {
  final int id;
  final int userId;
  final String title;

const Album ({
  required this.id,
  required this.userId,
  required this.title,
});

factory Album.fromJson(Map<String, dynamic> json) {
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
      title: 'Fetch data from the internet Jhaynher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 124, 70, 138)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fetch Data from the Internet Jhaynher'),
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
  var napilingLugar = 0;

    
  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (napilingLugar){
    case 0:
      page =AlbumsPage();
    case 1:
      page =PhotosPage();
    case 2:
      page =Placeholder();
    default: 
      throw  UnimplementedError('Walang Ganyan...');
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
              elevation: 10,
              backgroundColor: Color.fromARGB(255, 187, 167, 197),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.photo_album_outlined),
                  selectedIcon: Icon(Icons.photo_album), 
                  label: Text('Photo Albums'),
                  ),
                  NavigationRailDestination(
                  icon: Icon(Icons.photo_outlined), 
                  selectedIcon: Icon(Icons.photo_album), 
                  label: Text('Photo'),
                  ),
                  NavigationRailDestination(
                  icon: Icon(Icons.info), 
                  label: Text('Info'),
                  )
              ], 
              selectedIndex: napilingLugar,
              onDestinationSelected: (int index) {
                if (index != 2){
                  setState(() {
                  napilingLugar = index;
                });
                } else {
                  showAboutDialog(context: context,
                  applicationName: 'Photo Album App',
                  applicationVersion: 'May 2024 | Jhaynher Felix' );
                }
              }
              ),
          Expanded(child: page,)
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
          child: FutureBuilder(future: albums, builder: (context, snapshot) {
            if (snapshot.hasData){
              print(snapshot.requireData);

              final albumsCard = snapshot.requireData.map((album) => Card(
                child: ListTile (title: Text(album.title), subtitle: Text('Photo Album'),),
              ));
              return ListView(children: albumsCard.toList());
            }
            return CircularProgressIndicator();
            },),
        );
      }
}

   class PhotosPage extends StatelessWidget {
      const PhotosPage({super.key});

      @override
      Widget build(BuildContext context) {
        return Center(
        child: Text('Dito ung photos page...'),
        );
      }
  }
