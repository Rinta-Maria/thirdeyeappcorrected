import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async'; // Import dart:async to use StreamSubscription

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference _connRef;
  bool isConnected = true;
  StreamSubscription<DataSnapshot>? _connSub; // Declare the StreamSubscription

  @override
  void initState() {
    super.initState();
    _connRef = FirebaseDatabase.instance.reference().child('conn');
    _connSub = _connRef.onValue.listen((DataSnapshot snapshot) {
      setState(() {
        isConnected = snapshot.value as bool;
      });
    } as void Function(DatabaseEvent event)?) as StreamSubscription<DataSnapshot>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Color.fromARGB(255, 2, 2, 2),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFA8A7A5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 6, 6, 6),
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 6, 6, 6),
              size: 35,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/device.png"),
            SizedBox(height: 20),
            Text(
              isConnected ? 'Connected' : 'Disconnected',
              style: TextStyle(
                fontSize: 20,
                color: isConnected ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.mic,
              size: 60,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connSub?.cancel(); // Cancel the subscription when the widget is disposed
    super.dispose();
  }
}
