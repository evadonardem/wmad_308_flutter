import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
//fetching data from the internet <start>

const endpoint = 'https://jsonplaceholder.typicode.com/albums';

Future<Iterable<Album>> fetchAlbums() async{
  final response = await http.get(Uri.parse(endpoint));
  
    if (response.statusCode == 200){
      //print ("data nung lahat ng album");

      final rawData = response.body;
      final List<dynamic> jsonDecodeData = jsonDecode(rawData); //List<dynamic> --> array of anything
      final albums = jsonDecodeData.map((e) => Album.fromJson(e));
      
      //print ('Raw:$rawData');
     // print('JSON Decoded through List: $jsonDecodeData');
      //print ('Albums: $albums');

      return albums;
    } else {
      throw Exception('Failed to load album');
    }
}

Future<Album> fetchAlbum(int albumId) async {
  final response = await http.get(Uri.parse("$endpoint/$albumId"));

    if (response.statusCode == 200){
     // print ("data nung isang album");

      final rawData = response.body;
      final jsonDecodeData = jsonDecode(rawData);
      final album = Album.fromJson(jsonDecodeData);

      //print ('Raw:$rawData');
      //print ('JSON Decoded: $jsonDecodeData');
     // print ('Album Object : $album');

      print (album.title);
//fromJson -- gumagawa ng 
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
}
//fetching data from the internet <end>

//create dart obj to represent an Album

class Album {
  final int id;
  final int userId;
  final String title;

//constructor
  const Album ({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.fromJson(json){
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
      title: 'Fetch data from the internet Brailyn Sharie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fetch data from the internet Brailyn Sharie'),
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

  var selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
  
  Widget page;
   switch (selectedDestination){
    case 0:
      page = AlbumsPage();
    case 1:
      page = PhotosPage();
    default: 
      throw UnimplementedError("Not Found");
  } 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:Row (
          children: [
          NavigationRail(
            backgroundColor: Colors.teal,
            extended: true,
            elevation: 10,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.photo_album), 
                label: Text("Photo Albums"),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.photo), 
                label: Text("Photo"),
              ),
                
              NavigationRailDestination(
                icon: Icon(Icons.info), 
                label: Text("About"), 
              ),
            ],
            selectedIndex: selectedDestination,
            onDestinationSelected: (int index) {
              if (index !=2){
                setState(() {
                selectedDestination = index;
              });
              } else{
                showAboutDialog(
                  context: context,
                  applicationName: 'Photo Album App',
                  applicationVersion: 'May 2024| Brailyn Sharie Gabin',
                );
              }
            },
            ),
            Expanded(
              child: page,
            )
          ],
        ),
      ),
      );
  }
}

class AlbumsPage extends StatefulWidget{
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
        builder: (context,snapshot){
        if (snapshot.hasData){
          //print (snapshot.requireData);
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
      },
    ),
    );
  }
}

class PhotosPage extends StatelessWidget{
  const PhotosPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Photos Page here'),
    );
  }
}









//Brailyn Sharie B Gabin (2022-01-0084)