import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

const endpoint = 'https://jsonplaceholder.typicode.com/albums/';

Future fetchUsers() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    print('Lambert eto ung data nung lahat ng album:');
    print(response.body);
    final rawData = response.body;
    final List jsonDecodeData = jsonDecode(rawData);
    final users = jsonDecodeData.map((e) => User.fromJson(e));

    print('Raw Data: $rawData');
    print('JSON Decoded through List: $jsonDecodeData');
    print('Users: $users');
    return users;
  } else {
    throw Exception('Failed to load album');
  }
}

class User {

  static fromJson(e) {}
}


class MyAppState extends ChangeNotifier {
  bool isLoggedIn = false;
  

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 133, 124, 255)),
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
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: LambertLoginPage(counter: _counter),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

class LambertLoginPage extends StatefulWidget {
  const LambertLoginPage({
    super.key,
    required int counter,
  }) : _counter = counter;
  final int _counter;
  @override
  State<LambertLoginPage> createState() => LambertLoginPageState();
}

class LambertLoginPageState extends State<LambertLoginPage> {
  late String lambertUsernameEntered;
  late String lambertPasswordEntered;
  late Future lambertFutureUsers;
  late List lambertUsers;

  @override
  void initState() {
    super.initState();
    lambertUsernameEntered = "";
    lambertPasswordEntered = "";
    lambertFutureUsers = fetchUsers();
    lambertUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    print("Entered username: $lambertUsernameEntered ");
    print("Entered password: $lambertPasswordEntered ");

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
                    const Text('Futo-Futo App'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username mo boi"),
                        onChanged: (String lambertUsername) {
                          print('This is the username $lambertUsername');
                          setState(() {
                            lambertUsernameEntered = lambertUsername;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password mo boi"),
                        onChanged: (String lambertPassword) {
                          setState(() {
                            print('This is the username $lambertPassword');
                            lambertPasswordEntered = lambertPassword;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
      
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        lambertFutureUsers.whenComplete(() {
                          print('tapos ko nang kunin ung listahan ng users....');
                        }).then((users){
                          print("Eto ung username na dapat tignan: $lambertUsernameEntered");
                          print("Eto ung password na dapat tignan: $lambertPasswordEntered");
                          print("Tignan mo rito: $users");
                          final bool isValidUser = users.where(
                            (user) => (
                              user.username == lambertUsernameEntered ||
                              user.email == lambertUsernameEntered
                            )
                          ).isNotEmpty;
                          print("Is User do exist: $isValidUser");
                        });
                      },
                      child:FutureBuilder(
                        future: lambertFutureUsers,
                        builder: (context, snapshot) {
                           if(snapshot.hasData){
                              setState((){
                                lambertUsers = snapshot.requireData;
                              });
                              return const Text('Login');
                           }
                          return const CircularProgressIndicator();
                        }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('My Sample Login Page By Lambert Legaspi')
          ],
        ));
  }
}
