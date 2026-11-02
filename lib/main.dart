import 'package:flutter/material.dart';
import 'package:lab1_app/screens/todo_screen.dart';
import 'models/user.dart';
import 'models/bank_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Application',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const MyHomePage(title: 'My Application'),
      home: TodoScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<User> users = [
    User(name: 'Tom'),
    User(name: 'Pearl', age: 67),
    User(name: 'Marlon', age: 25, email: 'marlon@yahoo.com'),
  ];

  final List<BankAccount> accounts = [
    BankAccount(holderName: 'Tom Pearl', balance: 99999.9, bankBranch: 'Militari')
      ..initializeAccount('A-001'),

    BankAccount(holderName: 'Joji')
      ..initializeAccount('A-002'),

    BankAccount(holderName: 'Diplo', bankBranch: 'Ferentari'),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // child: ListView.builder(
        //   itemCount: users.length,
        //   itemBuilder: (context, i) {
        //     final user = users[i];

        //     return ListTile(
        //       title: Text('Name: ${user.name}'), 
        //       subtitle: Text('Age: ${user.getDisplayAge()} | Email: ${user.email ?? "Not provided"}'), 
        //     );
        //   },
        // ),
        
        child: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, i) {
            final a = accounts[i];

            return ListTile(
              title: Text(a.holderName),
              subtitle: Text('${a.getAccountDisplay()} | Branch: ${a.bankBranch ?? "N/A"}'),
            );
          }
        )
      ),

    );
  }
}
