import 'package:flutter/material.dart';
import 'tabPages/random_map.dart';
import 'tabPages/supported_countries_map.dart';
import '../widgets/nav_drawer.dart';

class WorldMapPage extends StatefulWidget {
  const WorldMapPage({Key? key}) : super(key: key);

  @override
  State<WorldMapPage> createState() => _WorldMapPageState();
}

class _WorldMapPageState extends State<WorldMapPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text('Countries World Map',
                style: TextStyle(color: Colors.blue)),
            backgroundColor: Colors.transparent,
            // backgroundColor: Color.fromARGB(255, 81, 164, 205),
            elevation: 0,
            bottom: TabBar(controller: controller, tabs: [
              ListTile(title: Center(child: Text('Supported countries'))),
              ListTile(title: Center(child: Text('Random colors'))),
              // ListTile(title: Center(child: Text('Africa'))),
            ])),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                SupportedCountriesMap(),
                RandomWorldMapGenerator(),
                // AfricaContinent()
              ]),
        ));
  }
}
