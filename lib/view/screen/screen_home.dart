import 'package:flutter/material.dart';
import 'file:///Users/thunq-d1/Desktop/MusicApp/flutter_app_music/lib/data/data_navigationbar.dart';
import 'package:flutter_app_music/utils/colors.dart';
import 'package:flutter_app_music/utils/media_query.dart';

class HomePage extends StatefulWidget {
  static const routerName = '/home_page';
  final index;

  HomePage({@required this.index});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _initTab(BuildContext context) => listTabbar(context).map((String tab) {
        return Tab(text: tab.toUpperCase());
      }).toList();

  _initTabContent() => widget_tabbar.map((Widget widget) {
        return widget;
      }).toList();

  _tabSelected(int index) {
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: listTabbar(context).length,
        initialIndex: widget.index,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                  margin:  EdgeInsets.only(top: kHeightStatusBar(context)),
                  child: TabBar(
                      tabs: _initTab(context),
                      indicatorColor: COLOR_TABBAR_INDICATOR,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: COLOR_BORDER_SIDE_TABBAR,
                              width: 1,
                              style: BorderStyle.solid)),
                      labelColor: COLOR_LABEL_INDICATOR,
                      unselectedLabelColor: COLOR_UNSELECT_LABEL_INDICATOR,
                      onTap: _tabSelected)),
              Container(
                height: 1,
                color: COLOR_LINE,
              ),
              Flexible(
                child: TabBarView(children: _initTabContent()),
              )
            ],
          ),
        ));
  }
}
