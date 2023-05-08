import 'package:flutter/material.dart';

import 'silver.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          snap: false,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Hello",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ) //TextStyle
                  ), //Text
              background: Image.network(
                "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
                fit: BoxFit.cover,
              ) //Images.network
              ), //FlexibleSpaceBar
          expandedHeight: 230,
          backgroundColor: Colors.greenAccent[400],
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IconButton
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.comment),
              tooltip: 'Comment Icon',
              onPressed: () {},
            ), //IconButton
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Setting Icon',
              onPressed: () {},
            ),
          ],
        ),

        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       return Text("Here i am");
        //     },
        //     childCount: 51,
        //   ),
        // )
      ],
    ));
  }
}
