import 'package:flutter/material.dart';
import 'package:track_my_show/router/routenames.dart';
import 'package:track_my_show/services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  final AuthService auth;
  CustomDrawer({this.auth});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 5, left: 5, right: 5),
                child: Text(
                  "Track\nMy\nShow",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                  ),
                ),
              ),
              AppBarWidget(
                title: 'Movies',
                icon: Icons.movie,
                routeF: () {
                  Navigator.of(context).pushNamed(movieScreen);
                },
              ),
              AppBarWidget(
                title: 'Shows',
                icon: Icons.show_chart,
                routeF: () {
                  Navigator.of(context).pushNamed(showScreen);
                },
              ),
              AppBarWidget(
                title: 'List',
                icon: Icons.list,
                routeF: () {
                  Navigator.of(context).pushNamed(listScreen);
                },
              ),
              AppBarWidget(
                title: 'Logout',
                icon: Icons.login,
                routeF: () async {
                  await auth.signOutNormal().then((_) {
                    print("Done");
                    Navigator.pushReplacementNamed(context, loginScreen);
                  }).catchError((error) {
                    print(error);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function routeF;
  const AppBarWidget(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.routeF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      // color: Colors.blue,
      child: InkWell(
          splashColor: Colors.grey,
          onTap: routeF,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.red,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'comfortaa',
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
    );
  }
}
