import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verbum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Verbum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
          future: getWord(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => RedLetter(letter: e)).toList() ??  [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => const BlueLetter(letter: "")).toList() ??  [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => const BlueLetter(letter: "")).toList() ??  [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => const BlueLetter(letter: "")).toList() ??  [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => const BlueLetter(letter: "")).toList() ??  [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data?.characters.map((e) => const BlueLetter(letter: "")).toList() ??  [],
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  Future<String> getWord() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getWord');
    final results = await callable();
    return results.data;
  }
}

class RedLetter extends StatelessWidget {
  final String letter;
  const RedLetter({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      decoration: const BoxDecoration(
        color: Colors.red,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white),
          left: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BlueLetter extends StatelessWidget {
  final String letter;
  const BlueLetter({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      decoration: const BoxDecoration(
        color: Colors.blue,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white),
          left: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          letter,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}