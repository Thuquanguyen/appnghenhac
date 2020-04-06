import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_music/generated/i18n.dart';
import 'package:flutter_app_music/view/screen/screen_album.dart';
import 'package:flutter_app_music/view/screen/screen_home.dart';
import 'package:flutter_app_music/view/screen/screen_song.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      home: HomePage(index: 0),
      routes: {
        HomePage.routerName: (_) => HomePage(index: 0),
        SongScreen.routerName: (_) => SongScreen()
      },
    );
  }
}
