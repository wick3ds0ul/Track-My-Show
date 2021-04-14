import 'package:flutter/material.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  final countries = [
    'Pakistan',
    'France',
    'Spain',
    'KSA',
    'Brasil',
    'Australia',
    'UAE',
    'USA',
    'UK',
    'India',
    'Afghanistan',
    'Bangladsh',
    'Egypt',
    'Pakistan',
    'France',
    'Spain',
    'KSA',
    'Brasil',
    'Australia',
    'UAE',
    'USA',
    'UK',
    'India',
    'Afghanistan',
    'Bangladsh',
    'Egypt'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: countries.length,
            itemBuilder: (ctx, i) {
              return ListTile(
                title: Text(countries[i]),
                onTap: () {},
                leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'Null',
                        ),
                      ),
                    )),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text('Delete'),
                ),
              );
            },
            separatorBuilder: (ctx, i) {
              return Divider();
            },
          ),
        ),
      ),
    );
  }
}
