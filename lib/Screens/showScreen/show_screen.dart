import 'package:flutter/material.dart';
import 'package:track_my_show/Screens/movieScreen/ui/tabbar.dart';
import 'package:track_my_show/models/MovieModels/search_item.dart';
import 'package:track_my_show/models/ShowModels/popular_shows_model.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';
import 'package:track_my_show/services/global.dart';
import 'package:track_my_show/services/movies_api.dart';
import 'package:track_my_show/services/shows_api.dart';
import 'package:track_my_show/widgets/custom_drawer.dart';
import 'package:track_my_show/widgets/exit_modal.dart';
import 'package:track_my_show/widgets/show_item.dart';
import 'package:track_my_show/Screens/movieScreen/movieScreen.dart';

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
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Shows',
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
                  return Center(child: CircularProgressIndicator()); // loading

                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchItem>>(
      future: MoviesApi().searchItems(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Center(child: Text('Enter a valid query.'));
          } else {
            // print(snapshot.data);
            List<SearchItem> searchItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return searchItems[index].checkNullValues()
                    ? SizedBox.shrink()
                    : Card(
                        child: ListTile(
                          leading: Image.network(
                            getPosterImage(searchItems[index].imageURL),
                            fit: BoxFit.cover,
                          ),
                          title: Text('${searchItems[index].name}'),
                          subtitle: Text(
                            '${searchItems[index].overview}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                          trailing: Text(
                            '${searchItems[index].media_type}'.toUpperCase(),
                          ),
                          onTap: () {
                            print(
                                "SEARCH API with ID:${searchItems[index].id}");
                            searchItems[index].media_type == 'tv'
                                ? Navigator.of(context).pushNamed(
                                    showDetailsScreen,
                                    arguments: searchItems[index].id)
                                : Navigator.pushNamed(
                                    context, movieDetailsScreen,
                                    arguments: searchItems[index].id);
                          },
                        ),
                      );
              },
              itemCount: searchItems.length,
            );
          }
        } else {
          return Center(child: CircularProgressIndicator()); // loading
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for AppBar
    return [
      //This will clear the text
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          })
    ];
    // throw UnimplementedError(); height: MediaQuery.of(context).size.height * 0.87,
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Leading icon on the left of AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
          // Navigator.of(context).pop();
        });
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    return Container();
  }
}
