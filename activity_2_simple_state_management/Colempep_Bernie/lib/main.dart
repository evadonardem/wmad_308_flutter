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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
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
        child: BernieLoginPage(counter: _counter),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // 
    );
  }
}

class BernieLoginPage extends StatefulWidget {
  const BernieLoginPage({
    super.key,
    required int counter,
  }) : _counter = counter;
  final int _counter;
  @override
  State<BernieLoginPage> createState() => _BernieLoginPageState();
}

class _BernieLoginPageState extends State<BernieLoginPage> {
  late String bernieUsernameEntered;
  late String berniePasswordEntered;
@override
  void initState() {
    super.initState();
    bernieUsernameEntered = "";
    berniePasswordEntered = "";
  }

  @override
  Widget build(BuildContext context) {
     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
        print("Entered username: $bernieUsernameEntered ");
        print("Entered password: $berniePasswordEntered ");

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
                Text('LOGIN MUNA BAGO SA LAGUSAN'),
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
                    labelText: "PAMANANG PANGALAN"
                  ),
                  onChanged: (String bernieUsername) {
                    print('This is the username $bernieUsername');
                    setState(() {
                      bernieUsernameEntered = bernieUsername;
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
                    labelText: "ANG IYONG SECRETO"
                   ),
                     onChanged: (String berniePassword) {
                      setState(() {
                        
                    print('This is the username $berniePassword');
                    berniePasswordEntered = berniePassword;
                    });
                  }
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                  print("OKAY");
                },
                 child: Text('PUMASOK SA LAGUSAN'),
                 ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('My Sample Login Page By Colempep Bernie')
      ],
      )
    );
  }
}

