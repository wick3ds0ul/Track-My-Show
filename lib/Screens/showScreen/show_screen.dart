import 'package:flutter/material.dart';
import 'package:track_my_show/models/ShowModels/popular_shows_model.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/services/shows_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'package:track_my_show/widgets/show_item.dart';

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
    // TODO: implement initState
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
              drawer: CustomDrawer(auth: _auth),
              appBar: AppBar(
                title: Text(
                  'Shows',
                  style:
                      TextStyle(fontFamily: 'Comfortaa', color: Colors.black),
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
                PopularTabContent(popularShows: popularShows),
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

class TabBarWidget extends StatelessWidget {
  final String name;
  TabBarWidget({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 2.5,
          )
        ],
      ),
      // width: MediaQuery.of(context).size.width / 2.5,
      constraints: BoxConstraints(minWidth: 80),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: FittedBox(
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
    );
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
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<PopularShowModel>>(
              future: popularShows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemBuilder: (ctx, id) {
                      return ShowItem(
                        snapshot: snapshot.data[id],
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
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
