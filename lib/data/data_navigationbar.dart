import 'package:flutter/material.dart';
import 'package:flutter_app_music/generated/i18n.dart';
import 'package:flutter_app_music/view/screen/screen_album.dart';
import 'package:flutter_app_music/view/screen/screen_artists.dart';
import 'package:flutter_app_music/view/screen/screen_song.dart';

List<Widget> widget_tabbar = <Widget>[
  SongScreen(),
AlbumScreen(),
ArtistsScreen()
];

List<String> listTabbar(BuildContext context) => <String>[
  S.of(context).song,
  S.of(context).album,
  S.of(context).artists
];