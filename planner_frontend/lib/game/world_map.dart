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
    // controller = TabController(length: 2, initialIndex: 0, vsync: this);
    // super.initState();
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.deepPurple,
            title: Text('Countries World Map',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white)),
            elevation: 0,
            bottom: TabBar(
              controller: controller,
              indicatorColor: Colors.purpleAccent,
              // tabs: [
              //   ListTile(
              //       title: Center(
              //           child: Text('Supported countries',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .titleMedium
              //                   ?.copyWith(color: Colors.white)))),
              //   ListTile(
              //       selectedColor: Colors.purpleAccent,
              //       title: Center(
              //           child: Text('Random colors',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .titleMedium
              //                   ?.copyWith(color: Colors.white)))),
              //   // ListTile(title: Center(child: Text('Africa'))),
              // ]
              tabs: [
                Tab(
                  child: Container(
                    color: controller.index == 0
                        ? Colors.blueAccent
                        : Colors.deepPurple,
                    child: Center(
                      child: Text(
                        'Supported countries',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    color: controller.index == 1
                        ? Colors.blueAccent
                        : Colors.deepPurple,
                    child: Center(
                      child: Text(
                        'Random colors',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                SupportedCountriesMap(),
                RandomWorldMapGenerator(),
              ]),
        ));
  }
}
