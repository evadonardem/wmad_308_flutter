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
    throw Exception('Failed to load users');
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
      _ => throw const FormatException('Failed to load users.'),
    };
  }
}

class MyAppState extends ChangeNotifier {
  bool isLoggedIn = false;
  User? loggedInUser;

  void papasukin(User $user) {
    isLoggedIn = true;
    loggedInUser = $user;
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Simple State Management',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 163, 153, 15)),
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
        body: const Center(child: Text('Sam Faustino')),
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
          selectedItemColor: Color.fromARGB(255, 39, 16, 165),
          unselectedItemColor: Color.fromARGB(255, 39, 16, 165),
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
        child: SamLoginPage(),
      ),
    );
  }
}

class SamLoginPage extends StatefulWidget {
  const SamLoginPage({
    super.key,
  });

  @override
  State<SamLoginPage> createState() => _SamLoginPageState();
}

class _SamLoginPageState extends State<SamLoginPage> {
  late String samUsernameEntered;
  late String samPasswordEntered;
  late Future samFutureUsers;

  @override
  void initState() {
    super.initState();
    samPasswordEntered = "";
    samUsernameEntered = "";
    samFutureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 2, 78, 150),
        fontWeight: FontWeight.bold,
      ),
      minimumSize: const Size(300.0, 50.0),
      backgroundColor: (Color.fromARGB(255, 64, 210, 236)),
    );

    print('Entered username: $samUsernameEntered');
    print('Entered password: $samPasswordEntered');

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
                    Text('Login Here'),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 2.0,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onChanged: (String samUsername) {
                        print("This is the username: $samUsername");
                        setState(() {
                          samUsernameEntered = samUsername;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onChanged: (String samPassword) {
                        print("This is the password: $samPassword");
                        setState(() {
                          samPasswordEntered = samPassword;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        samFutureUsers.whenComplete(() {
                          print('Users successfully loaded...');
                        }).then((users) {
                          final bool isValidUser = users
                              .where((user) =>
                                  (user.username == samUsernameEntered ||
                                      user.email == samUsernameEntered))
                              .isNotEmpty;
                          print('User found?: $isValidUser');
                          if (isValidUser) {
                            final User authenticatedUser = users
                                .where((user) =>
                                    (user.username == samUsernameEntered ||
                                        user.email == samUsernameEntered))
                                .first;
                            print('This is the username $authenticatedUser');
                            appState.papasukin(authenticatedUser);
                          }
                        });
                        print("Checking Credentials");
                      },
                      child: FutureBuilder(
                          future: samFutureUsers,
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
          Text('Login Page by Sam'),
        ],
      ),
    );
  }
}
