import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_music/data/song_data.dart';
import 'package:flutter_app_music/generated/i18n.dart';
import 'package:flutter_app_music/view/widget/mp_circle_avatar.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongScreen extends StatelessWidget {
  static const routerName = '/song';

  @override
  Widget build(BuildContext context) {
    return SongState();
  }
}

class SongState extends StatefulWidget {
  @override
  _SongStateState createState() => _SongStateState();
}

class _SongStateState extends State<SongState> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final List<MaterialColor> _colors = Colors.primaries;
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

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (content,index){
        var s = songData.songs[index];
        final MaterialColor color = _colors[index % _colors.length];
        var artFile = s.albumArt == null ? null : new File.fromUri(Uri.parse(s.albumArt));

        return ListTile(
          dense: false,
          leading: new Hero(tag: s.title, child: avatar(artFile, s.title, color)),
          title: Text(s.title),
          subtitle: Text("By ${s.artist} - ${s.albumId} - ${s.album}", style: Theme.of(context).textTheme.caption),
          onTap: (){
            songData.setCurrentIndex(index);
            print(s.albumId);
          },
        );
      },itemCount: songData.length != null ? songData.length : 0),
    );
  }
}
