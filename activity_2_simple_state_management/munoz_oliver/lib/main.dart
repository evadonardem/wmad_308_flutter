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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 253, 124)),
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
        child: oliverLoginPage(counter: _counter),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // 
    );
  }
}

class oliverLoginPage extends StatefulWidget {
  const oliverLoginPage({
    super.key,
    required int counter,
  }) : _counter = counter;
  final int _counter;
  @override
  State<oliverLoginPage> createState() => _oliverLoginPageState();
}

class _oliverLoginPageState extends State<oliverLoginPage> {
  late String oliverUsernameEntered;
  late String oliverPasswordEntered;
@override
  void initState() {
    super.initState();
    oliverUsernameEntered = "";
    oliverPasswordEntered = "";
  }

  @override
  Widget build(BuildContext context) {
     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
        print("Entered username: $oliverUsernameEntered ");
        print("Entered password: $oliverPasswordEntered ");

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
                Text('LOGIN na'),
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
                    labelText: "The Username Please"
                  ),
                  onChanged: (String oliverUsername) {
                    print('This is the username $oliverUsername');
                    setState(() {
                      oliverUsernameEntered = oliverUsername;
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
                    labelText: "The Password Please"
                   ),
                     onChanged: (String oliverPassword) {
                      setState(() {
                    print('This is the username $oliverPassword');
                    oliverPasswordEntered = oliverPassword;
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
                 child: Text('Oh my God'),
                 ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('My Sample Login Page By Oliver munoz')
      ],
      )
    );
  }
}
