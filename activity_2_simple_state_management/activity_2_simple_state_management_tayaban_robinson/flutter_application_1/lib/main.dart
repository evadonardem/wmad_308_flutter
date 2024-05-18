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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 105, 77, 77)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page Flutter Demo Home Page'),
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
        child: RobinsonLoginPage(counter: _counter),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // 
    );
  }
}

class RobinsonLoginPage extends StatefulWidget {
  const RobinsonLoginPage({
    super.key,
    required int counter,
  }) : _counter = counter;
  final int _counter;
  @override
  State<RobinsonLoginPage> createState() => _RobinsonLoginPageState();
}

class _RobinsonLoginPageState extends State<RobinsonLoginPage> {
  late String RobinsonUsernameEntered;
  late String RobinsonPasswordEntered;
@override
  void initState() {
    super.initState();
    RobinsonUsernameEntered = "";
    RobinsonPasswordEntered = "";
  }

  @override
  Widget build(BuildContext context) {
     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
        print("Entered username: $RobinsonUsernameEntered ");
        print("Entered password: $RobinsonPasswordEntered ");

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
                Text('LOG IN KA MUNA BOSSING'),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                   decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "UsernameHere"
                  ),
                  onChanged: (String RobinsonUsername) {
                    print('This is the username $RobinsonUsername');
                    setState(() {
                      RobinsonUsernameEntered = RobinsonUsername;
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
                    labelText: "PasswordHere"
                   ),
                     onChanged: (String RobinsonPassword) {
                      setState(() {
                    print('This is the username $RobinsonPassword');
                    RobinsonPasswordEntered = RobinsonPassword;
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
                 child: Text('Enter mo Dituy'),
                 ),
                  ElevatedButton(
                  style: style,
                  onPressed: () {
                  print("OKAY");
                },
                 child: Text('DITA NGATO'),
                 ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('Sir hangang dito nalang kaya ko i surrender HAHA salamt sa lahat')
      ],
      )
    );
  }
}
