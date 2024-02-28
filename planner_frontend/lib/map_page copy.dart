// import 'package:flutter/material.dart';
// // import 'package:flutter_map/plugin_api.dart';
// // import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
// // import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// // import 'package:latlong2/latlong.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> with OSMMixinObserver {
//   late MapController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = MapController(
//       initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//       areaLimit: BoundingBox(
//         east: 10.4922941,
//         north: 47.8084648,
//         south: 45.817995,
//         west: 5.9559113,
//       ),
//     );
//     controller.addObserver(this);
//   }

//   @override
//   Future<void> mapIsReady(bool isReady) async {
//     if (isReady) {
//       // Do any initialization after the map is ready
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("OSM Plugin Drawing Example"),
//       ),
//       body: OSMFlutter(
//         controller: controller,
//         osmOption: OSMOption(
//           userTrackingOption: const UserTrackingOption(
//             enableTracking: true,
//             unFollowUser: false,
//           ),
//           zoomOption: const ZoomOption(
//             initZoom: 8,
//             minZoomLevel: 3,
//             maxZoomLevel: 19,
//             stepZoom: 1.0,
//           ),
//           userLocationMarker: UserLocationMaker(
//             personMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.location_history_rounded,
//                 color: Colors.red,
//                 size: 48,
//               ),
//             ),
//             directionArrowMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.double_arrow,
//                 size: 48,
//               ),
//             ),
//           ),
//           roadConfiguration: const RoadOption(
//             roadColor: Colors.yellowAccent,
//           ),
//           markerOption: MarkerOption(
//             defaultMarker: const MarkerIcon(
//               icon: Icon(
//                 Icons.person_pin_circle,
//                 color: Colors.blue,
//                 size: 56,
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _drawCircle();
//         },
//         child: Icon(Icons.edit),
//       ),
//     );
//   }

//   void _drawCircle() async {
//     try {
//       // Draw a circle on the map
//       await controller.drawCircle(
//         CircleOSM(
//           key: "circle1",
//           centerPoint: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//           radius: 1000.0, // in meters
//           color: Colors.blue,
//           strokeWidth: 0.3,
//         ),
//       );
//     } catch (e) {
//       // Handle any potential errors
//       print("Error during drawing: $e");
//     }
//   }
// }
