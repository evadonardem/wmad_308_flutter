import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 248, 191, 1)),
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
        child: EbenezerLoginPage(counter: _counter),
      ),
    );
  }
}

class EbenezerLoginPage extends StatefulWidget {
  const EbenezerLoginPage({
    super.key,
    required int counter,
  }) : _counter = counter;
  final int _counter;
  @override
  State<EbenezerLoginPage> createState() => _EbenezerLoginPageState();
}

class _EbenezerLoginPageState extends State<EbenezerLoginPage> {
  late String ebenezerUsernameEntered;
  late String ebenezerPasswordEntered;
@override
  void initState() {
    super.initState();
    ebenezerUsernameEntered = "";
    ebenezerPasswordEntered = "";
  }

  @override
  Widget build(BuildContext context) {
     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
        print("Entered username: $ebenezerUsernameEntered ");
        print("Entered password: $ebenezerPasswordEntered ");

    return Padding(
      padding: const EdgeInsets.all(70),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(70),
            child: Column(
              children: [
                Text('Agin Agin nga Application'),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                   decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username"
                  ),
                  onChanged: (String ebenezerUsername) {
                    print('This is the username $ebenezerUsername');
                    setState(() {
                      ebenezerUsernameEntered = ebenezerUsername;
                    });
                  }
                ),
                SizedBox(
                  height:10,
                ),
                TextField(
                  obscureText: true,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                   ),
                     onChanged: (String ebenezerPassword) {
                      setState(() {
                    print('This is the username $ebenezerPassword');
                    ebenezerPasswordEntered = ebenezerPassword;
                    });
                  }
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                  print("Let's Go!");
                },
                 child: Text('Login'),
                 ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('My Sample Login Page By Ebenezer Kikilao')
      ],
      )
    );
  }
}