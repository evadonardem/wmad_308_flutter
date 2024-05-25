import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const endpoint = 'https://jsonplaceholder.typicode.com/users';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    final rawData = response.body;
    final List jsonDecodeData = jsonDecode(rawData);
    final users = jsonDecodeData.map((e) => User.fromJson(e)).toList();

    print('Raw Data: $rawData');
    print('JSON Decoded: $jsonDecodeData');
    print('Users: $users');

    return users;
  } else {
    throw Exception('Failed to load users');
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
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
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

  void palabasinNaSya() {
    isLoggedIn = false;
    loggedInUser = null;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Simple State Management',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 47, 15, 163)),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MyHomePage(title: 'Welcome'),
      ),
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
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.isLoggedIn) {
      final String userDetail = "Inya ngay ${appState.loggedInUser!.name}!";

      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(userDetail),
              TextButton(
                onPressed: () {
                  appState.palabasinNaSya();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30.0, // Adjust the font size as needed
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const Center(child: Text('Lambert Legaspi')),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar),
              label: 'Bar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Color.fromARGB(255, 42, 15, 163),
          unselectedItemColor: Color.fromARGB(255, 163, 15, 101),
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
        child: LambertLoginPage(),
      ),
    );
  }
}

class LambertLoginPage extends StatefulWidget {
  const LambertLoginPage({
    super.key,
  });

  @override
  State<LambertLoginPage> createState() => _LambertLoginPageState();
}

class _LambertLoginPageState extends State<LambertLoginPage> {
  late String lambertUsernameEntered;
  late String lambertPasswordEntered;
  late Future<List<User>> lambertFutureUsers;

  @override
  void initState() {
    super.initState();
    lambertPasswordEntered = "";
    lambertUsernameEntered = "";
    lambertFutureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 17, 10, 109),
        fontWeight: FontWeight.bold,
      ),
      minimumSize: const Size(300.0, 50.0),
      backgroundColor: (Color.fromARGB(255, 72, 199, 221)),
    );

    print('Entered username: $lambertUsernameEntered');
    print('Entered password: $lambertPasswordEntered');

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
                  Text('Futo-Futo App'),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 2.0,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ikargam Username mo Boi',
                    ),
                    onChanged: (String lambertUsername) {
                      print("This is the username: $lambertUsername");
                      setState(() {
                        lambertUsernameEntered = lambertUsername;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inya Password mo Boi',
                    ),
                    onChanged: (String lambertPassword) {
                      print("This is the password: $lambertPassword");
                      setState(() {
                        lambertPasswordEntered = lambertPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      lambertFutureUsers.whenComplete(() {
                        print('Users successfully loaded...');
                      }).then((users) {
                        final bool isValidUser = users
                            .where((user) =>
                                (user.username == lambertUsernameEntered ||
                                    user.email == lambertUsernameEntered))
                            .isNotEmpty;
                        print('User found?: $isValidUser');
                        if (isValidUser) {
                          final User authenticatedUser = users
                              .where((user) =>
                                  (user.username == lambertUsernameEntered ||
                                      user.email == lambertUsernameEntered))
                              .first;
                          print('This is the username $authenticatedUser');
                          appState.papasukin(authenticatedUser);
                        }
                      });
                      print("Checking Credentials");
                    },
                    child: FutureBuilder(
                        future: lambertFutureUsers,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return const Text('Login');
                          }
                          return const CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Login Page by Lambert Legaspi'),
        ],
      ),
    );
  }
}
