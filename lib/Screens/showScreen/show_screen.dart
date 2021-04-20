import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/movieScreen/ui/tabbar.dart';
import 'package:track_my_show/models/ShowModels/popular_shows_model.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/services/shows_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/data_search.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'package:track_my_show/widgets/movie_item.dart';

class ShowScreen extends StatefulWidget {
  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  final AuthService _auth = AuthService();
  Future<List<PopularShowModel>> popularShows;

  ShowsApi _api;
  @override
  void initState() {
    super.initState();
    _api = ShowsApi();
    popularShows = _api.getPopularShows();
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
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
              drawer: CustomDrawer(auth: _auth),
              appBar: AppBar(
                toolbarHeight: 60,
                title: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Shows',
                    style: const TextStyle(
                        fontFamily: 'Comfortaa', color: Colors.black),
                  ),
                ),
                backgroundColor: const Color(0xFFFFFFFF),
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu_open_rounded),
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
                PopularTabContent(popularShows: popularShows),
              ]),
              backgroundColor: const Color(0xFFFFFFFF),
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

class PopularTabContent extends StatelessWidget {
  const PopularTabContent({
    Key key,
    @required this.popularShows,
  }) : super(key: key);

  final Future<List<PopularShowModel>> popularShows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.87,
            child: FutureBuilder<List<PopularShowModel>>(
              future: popularShows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemBuilder: (ctx, id) {
                      return MovieItem(
                        snapshot: snapshot.data[id],
                      );
                    },
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 4 / 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator()); // loading

                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
