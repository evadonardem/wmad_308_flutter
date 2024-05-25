import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const endpoint = 'https://jsonplaceholder.typicode.com/users';

Future<Iterable<User>> fetchUsers() async {
  final response = await http.get(Uri.parse(endpoint));

  if (response.statusCode == 200) {
    print("data nung lahat ng user");

    final rawData = response.body;
    final List<dynamic> jsonDecodeData =
        jsonDecode(rawData); //List<dynamic> --> array of anything
    final users = jsonDecodeData.map((e) => User.fromJson(e));

    print('Raw:$rawData');
    print('JSON Decoded through List: $jsonDecodeData');
    print('users: $users');

    return users;
  } else {
    throw Exception('Failed');
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

//constructor
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(json) {
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
      _ => throw const FormatException('Brailyn Failed.'),
    };
  }
}

class MyAppState extends ChangeNotifier {
  bool isLoggedIn = false;
  User? LoggedInUser;

  void papasukin(User $User) {
    isLoggedIn = true;
    LoggedInUser = $User;
    notifyListeners();
  }

  void palabasin(){
    isLoggedIn = false;
    LoggedInUser = null;
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
          title: 'Flutter Simple State Management',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Activity_2_gabin_brailyn'),
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
      final String userDetail =
          "Welcome! ${appState.LoggedInUser!.name} (${appState.LoggedInUser!.website})";
      return Scaffold(
        appBar: AppBar(
          title: Text(userDetail),
        ),
        body: const Center(
          child: Text('Brailyn Sharie Gabin'),
        ),
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
              label: 'Logout',
            ),
          ],
          currentIndex: 0,
          unselectedItemColor: Colors.red,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            print(index);
            if (index == 3) {
              appState.palabasin();
          }
          },
        ),
      );
    }
    return const Scaffold(
      body: BrailynLoginPage(),
    );
  }
}

class BrailynLoginPage extends StatefulWidget {
  const BrailynLoginPage({
    super.key,
  });

  @override
  State<BrailynLoginPage> createState() => _BrailynLoginPageState();
}

class _BrailynLoginPageState extends State<BrailynLoginPage> {
  late String brailynUsernameEntered;
  late String brailynPasswordEntered;
  late Future brailynFutureUsers;

  @override
  void initState() {
    super.initState();
    brailynUsernameEntered = "";
    brailynPasswordEntered = "";
    brailynFutureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
     var appState = context.watch<MyAppState>();

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: Size(double.infinity, 0),
    );
    print("Entered UN: $brailynUsernameEntered");
    print("Entered PW: $brailynPasswordEntered");

    return Padding(
      padding: const EdgeInsets.all(180),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text('App'),
                const SizedBox(
                  height: 0,
                ),
                const Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Anata no username wa?'),
                  onChanged: (brailynUsername) {
                    print('Username...$brailynUsername');
                    setState(() {
                      brailynUsernameEntered = brailynUsername;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Anata no password wa?'),
                  onChanged: (brailynPassword) {
                    print('Password...$brailynPassword');
                    setState(() {
                      brailynPasswordEntered = brailynPassword;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    brailynFutureUsers.whenComplete(() {
                     print('users loaded');
                     }).then((User) {
                       print('UN entered: $brailynUsernameEntered');
                       print('UN entered: $brailynPasswordEntered');
                      print('USERS: $User');

                       final bool isValidUser = User.where((user) =>
                         (user.username == brailynUsernameEntered || user.email == brailynUsernameEntered)).isNotEmpty;

                       print('$isValidUser');

                       if (isValidUser) {
                         final authenticatedUser = User.where((user) =>
                         (user.username == brailynUsernameEntered || user.email == brailynUsernameEntered)).first;

                         appState.papasukin(authenticatedUser);
                       }
                     });
                  },
                  child: FutureBuilder(
                      future: brailynFutureUsers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Text('START');
                        }
                        return const Text('Loading...');
                      }),
                ),
              ],
            ),
          )),
          // const SizedBox(
          //   height: 10,
          // ),
          // const Text('A sample login page by Brailyn Sharie'),
        ],
      ),
    );
  }
}
