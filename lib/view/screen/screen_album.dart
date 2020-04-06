import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_music/data/song_data.dart';
import 'package:flutter_app_music/generated/i18n.dart';
import 'package:flutter_app_music/view/widget/mp_circle_avatar.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlbumState();
  }
}

class AlbumState extends StatefulWidget {
  @override
  _AlbumStateState createState() => _AlbumStateState();
}

class _AlbumStateState extends State<AlbumState> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final List<MaterialColor> _colors = Colors.primaries;
  List<Song> listAblum = new List<Song>();
  var listIdAlbum = [];
  SongData songData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    songData.audioPlayer.stop();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    _isLoading = true;

    var songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print("Failed to get songs: '${e.message}'.");
    }
    if (!mounted) return;

    setState(() {
      songData = new SongData((songs));
      for (var data in songData.songs) {
        listIdAlbum.add(data.albumId);
      }
      listIdAlbum = listIdAlbum.toSet().toList();
      for (var i = 0; i < songData.songs.length; i++) {
        if (listIdAlbum.length != 0) {
          if (songData.songs[i].albumId == listIdAlbum[0]) {
            listAblum.add(songData.songs[i]);
            listIdAlbum.removeAt(0);
          }
        }
      }
      print("Count $listIdAlbum");
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (content, index) {
            var s = listAblum[index];
            final MaterialColor color = _colors[index % _colors.length];
            var artFile = s.albumArt == null
                ? null
                : new File.fromUri(Uri.parse(s.albumArt));

            return ListTile(
              dense: false,
              leading: new Hero(
                  tag: s.title, child: avatar(artFile, s.title, color)),
              title: Text(s.album),
              subtitle: Text("${s.artist}",
                  style: Theme.of(context).textTheme.caption),
              onTap: () {
                print(s.albumId);
              },
            );
          },
          itemCount: listAblum != null ? listAblum.length : 0),
    );
  }
}
