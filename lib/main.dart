// import 'package:english_words/english_words.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Radio App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "Stopped";

  void getNext() {
    if (current == "Stopped") {
      current = "Playing";
      final player = AudioCache();
      player.play("images/music.mp3");

    }
    else {
      current = "Stopped";
    }

    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('Radio State: '),
          Text(appState.current),
          appState.current == "Stopped"? Image.asset('images/cassette_black.png',):Image.asset('images/cassette_black.gif',),
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
              //AudioPlayer().play(AssetSource('audio/my_audio.mp3'));
              appState.getNext();
            },
            child: appState.current == "Stopped"? const Icon(Icons.play_arrow):Text('Stop'), 
          ),
        ],
      ),
    );
  }
}