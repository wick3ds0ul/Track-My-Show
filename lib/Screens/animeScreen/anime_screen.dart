import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/animeScreen/anime_item.dart';
import 'package:track_my_show/services/anime_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/services/shows_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'package:track_my_show/widgets/show_item.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/Screens/movieScreen/ui/tabbar.dart';
import 'package:track_my_show/Screens/movieScreen/ui/tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimeScreen extends StatefulWidget {
  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  final AuthService _auth = AuthService();
  Future trendingAnime;

  AnimeApi _api;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _api = AnimeApi();
    trendingAnime = _api.getTrendingAnime();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: DefaultTabController(
            length: 1,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.search),
                onPressed: () {
                  // showSearch(context: context, delegate: DataSearch());
                },
              ),
              drawer: CustomDrawer(auth: _auth),
              appBar: AppBar(
                toolbarHeight: 60,
                title: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Anime',
                    style:
                        TextStyle(fontFamily: 'Comfortaa', color: Colors.black),
                  ),
                ),
                backgroundColor: Color(0xFFFFFFFF),
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu_open_rounded),
                    color: Colors.black,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }),
                bottom: TabBar(
                  indicatorColor: Color(0xFFFF2929),
                  isScrollable: true,
                  tabs: [
                    TabBarWidget(
                      name: "Featured",
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                TrendingTabContent(trendinganime: trendingAnime),
              ]),
              backgroundColor: Color(0xFFFFFFFF),
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExitModlal();
            }) ??
        false;
  }
}

class TrendingTabContent extends StatelessWidget {
  final Future trendinganime;
  const TrendingTabContent({
    Key key,
    @required this.trendinganime,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.87,
            child: FutureBuilder(
              future: trendinganime,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemBuilder: (ctx, index) {
                      return AnimeItem(
                        animeModel: snapshot.data[index],
                      );
                    },
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 4 / 5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                  );
                  return Text("Got Data");
                } else {
                  return Center(child: Text("Something went wrong")); // loading

                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
