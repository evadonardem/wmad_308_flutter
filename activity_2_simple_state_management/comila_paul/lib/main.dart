import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

//Fetch data from the internet (begin)
const endpoint = 'https://jsonplaceholder.typicode.com/users';

Future fetchUsers() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    final rawData = response.body;
    final List jsonDecodeData = jsonDecode(rawData);
    final users = jsonDecodeData.map((e) => User.fromJson(e));

    print('Raw Data: $rawData');
    print('JSON Decoded: $jsonDecodeData');
    print('Users: $users');

    return users;
  } else {
    throw Exception('Failed to load Users');
  }
}

//Create dart object to represent an Album
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
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'username': String username,
        'email': String email,
        'phone': String phone,
        'website': String website,
      } =>
        User(
          id: id,
          name: name,
          username: username,
          email: email,
          phone: phone,
          website: website,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class MyAppState extends ChangeNotifier {
  bool isLoggedIn = false;
  User? loggedInUser;

  void papasukin(User user) {
    isLoggedIn = true;
    loggedInUser = user;
    notifyListeners();
  }

  void palabasinNaSya(){
    isLoggedIn = false;
    loggedInUser = null;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Flutter Simple State Management',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 50, 66)),
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: const MyHomePage(title: 'Welcome'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.isLoggedIn) {
      final String userDetail = "Welcome ${appState.loggedInUser!.name} !";

      return Scaffold(
        appBar: AppBar(
          title: Text(userDetail),
        ),
        body: const Center(child: Text('Paul Comila')),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'School',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Color.fromARGB(255, 0, 77, 80),
          unselectedItemColor: Color.fromARGB(179, 0, 77, 80),
          onTap: (index) {
            print(index);
            if (index == 3) {
              appState.palabasinNaSya();
            }
          },
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: PaulLoginPage(),
      ),
    );
  }
}

class PaulLoginPage extends StatefulWidget {
  const PaulLoginPage({
    super.key,
  });

  @override
  State<PaulLoginPage> createState() => _PaulLoginPageState();
}

class _PaulLoginPageState extends State<PaulLoginPage> {
  late String paulUsernameEntered;
  late String paulPasswordEntered;
  late Future paulFutureUsers;

  @override
  void initState() {
    super.initState();
    paulPasswordEntered = "";
    paulUsernameEntered = "";
    paulFutureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 0, 158, 161),
        fontWeight: FontWeight.bold,
      ),
      minimumSize: const Size(300.0, 50.0),
      backgroundColor: (Color.fromARGB(255, 102, 227, 225)),
    );

    print('Entered username: $paulUsernameEntered');
    print('Entered password: $paulPasswordEntered');

    return Padding(
      padding: const EdgeInsets.all(90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text('Welcome to the World'),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 2.0,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                      onChanged: (String paulUsername) {
                        print("Eto yung username nya...$paulUsername");
                        setState(() {
                          paulUsernameEntered = paulUsername;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      onChanged: (String paulPassword) {
                        print("Eto yung password nya...$paulPassword");
                        setState(() {
                          paulPasswordEntered = paulPassword);
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        paulFutureUsers.whenComplete(() {
                          print('List of Users loaded');
                        }).then((users) {
                          print('Username to be checked: $paulUsernameEntered');
                          print('Password to be checked: $paulPasswordEntered');
                          print('List of Users: $users');
                          final bool isValidUser = users
                              .where((user) =>
                                  (user.username == paulUsernameEntered ||
                                      user.email == paulUsernameEntered))
                              .isNotEmpty;
                          print('Does this user exists: $isValidUser');
                          if (isValidUser) {
                            final User authenticatedUser = users
                                .where((user) =>
                                    (user.username == paulUsernameEntered ||
                                        user.email == paulUsernameEntered))
                                .first;
                            print('This is the username $authenticatedUser');
                            appState.papasukin(authenticatedUser);
                          }
                        });
                        print("Checking Credentials");
                      },
                      child: FutureBuilder(
                          future: paulFutureUsers,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return const Text('Login');
                            }
                            return const CircularProgressIndicator();
                          }),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 10),
          Text('My sample login page by Paul Comila'),
        ],
      ),
    );
  }
}