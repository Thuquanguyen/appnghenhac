import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_music/data/song_data.dart';
import 'package:flutter_app_music/generated/i18n.dart';
import 'package:flutter_app_music/view/widget/mp_circle_avatar.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class ArtistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ArtistsState();
  }
}

class ArtistsState extends StatefulWidget {
  @override
  _ArtistsStateState createState() => _ArtistsStateState();
}

class _ArtistsStateState extends State<ArtistsState> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final List<MaterialColor> _colors = Colors.primaries;
  List<Song> listArtists = new List<Song>();
  var arrArtists = [];
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
        arrArtists.add(data.artist);
      }
      arrArtists = arrArtists.toSet().toList();
      print(arrArtists.length);
      for (var i = 0; i < songData.songs.length; i++) {
        if (arrArtists.length != 0) {
          if (songData.songs[i].artist == arrArtists[0]) {
            listArtists.add(songData.songs[i]);
            arrArtists.removeAt(0);
          }
        }
      }

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
            var s = listArtists[index];
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
          itemCount: listArtists != null ? listArtists.length : 0),
    );
  }
}
