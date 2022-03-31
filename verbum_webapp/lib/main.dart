import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:verbum_webapp/game.dart';
import 'package:verbum_webapp/game/game.provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final darkNotifier = ValueNotifier<bool>(false);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _isDarkModeFromPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            darkNotifier.value = snapshot.data!;
          }
          return ValueListenableBuilder<bool>(
            valueListenable: darkNotifier,
            builder: (BuildContext context, bool isDarkMode, Widget? child) {
              return MaterialApp(
                title: 'Verbum',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  brightness: isDarkMode ? Brightness.dark : Brightness.light,
                ),
                home: const MyHomePage(title: 'Verbum'),
              );
            },
          );
        });
  }

  Future<bool> _isDarkModeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false;
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
        actions: [
          IconButton(
            icon: Icon(darkNotifier.value ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: () async {
              setState(() => darkNotifier.value = !darkNotifier.value);
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('darkMode', darkNotifier.value);
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: const GameLauncher(),
      ),
    );
  }
}

class GameLauncher extends StatelessWidget {
  const GameLauncher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: Provider.of<GameProvider>(context, listen: false).start(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasError == false) {
            return const Game();
          }
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasError == true) {
            return const Center(
              child: Text('Oups ! Une erreur est survenue.'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 24),
                  Text("Chargement de la grille..."),
                ],
              ),
            );
          }
        });
  }
}
