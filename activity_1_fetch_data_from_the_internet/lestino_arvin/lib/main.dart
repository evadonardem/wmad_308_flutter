import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Fetching data from the internet(begin)
const endpoint = "https://jsonplaceholder.typicode.com/albums";

Future<Iterable<Album>> fetchAlbums() async{
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
      //print('Arvin this will display ALL albums:');
      final rawData = response.body;
      final List jsonDecodeData = jsonDecode(rawData); 
      final albums = jsonDecodeData.map((e) => Album.fromJson(e));

      //print('Raw Data: $rawData');

      return albums;
  } else {
   
    throw Exception('Failed to load album');
  }

} 

Future<Album> fetchAlbum(int albumId) async{
  final response = await http.get(Uri.parse("$endpoint/$albumId"));
  if (response.statusCode == 200) {
    print('Arvin this will display the 12th album:');
    final rawData = response.body;
      final jsonDecodeData = jsonDecode(rawData);
      final album = Album.fromJson(jsonDecodeData);

      print('Raw Data: $rawData');
      print('JSON Decode: $jsonDecodeData');
      print('Album Object: $album');
    
      print(album.id);
      print(album.title);

      return album;

  } else {
   
    throw Exception('Failed to load album');
  }
} 
//Fetching data from the internet(end)

//Create dart object to represent an Album
class Album {
  final int id;
  final int userId;
  final String title;

  const Album({
    required this.userId,
    required this.id,
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),

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
  late Future<Album> album;
  var napilingLugar = 0;

 

  @override
  void initState()
  {
    super.initState();
    album = fetchAlbum(12);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(napilingLugar){
      case 0: 
        page = AlbumsPage();
      case 1: 
        page = PhotosPage();
      default:
        throw UnimplementedError('Walang ganyanan...');
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
                  /* backgroundColor: Color.alphaBlend(foreground, background), */
                  extended: true,
                  elevation: 5,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.photo_album), 
                      label: Text('Photo Albums')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.photo), 
                      label: Text('Photo')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.info), 
                      label: Text('About')
                    ),
                  ], 
                  selectedIndex: napilingLugar,
                  onDestinationSelected: (int index){
                    if(index != 2){
                      setState(() {
                        napilingLugar = index;
                      });
                    }else{
                      showAboutDialog(
                        context: context,
                        applicationName: 'Photo Album App',
                        applicationVersion: 'May 2024 | Arvin Lestino'
                        );
                    }
                    
                  },
                  ),
                Expanded(child: page,)
              ],)
        ),
      
       // This trailing comma makes auto-formatting nicer for build methods.
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
  void initState()
  {
    super.initState();
    albums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: albums,
        builder: (context,snapshot){
          if(snapshot.hasData){
            
           final albumsCard = snapshot.requireData.map((album) => Card(
            child: ListTile(
              title: Text(album.title),
              subtitle: Text('Photo album'),
            )
          ));
          return ListView(
            children: albumsCard.toList(),
          );
          }
          return CircularProgressIndicator();
        }
      )
    );
  }
}

class PhotosPage extends StatelessWidget {
  const PhotosPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Photos PAge'),
      );
  }
}