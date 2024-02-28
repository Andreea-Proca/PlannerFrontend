import 'package:flutter/material.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('ArcGIS Map'),
  //     ),
  //     body: InAppWebView(
  //       initialUrlRequest: URLRequest(url: Uri.parse('map.html')),
  //       initialOptions: InAppWebViewGroupOptions(
  //         crossPlatform: InAppWebViewOptions(
  //           javaScriptEnabled: true,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArcGIS Map'),
      ),
      // body: const FlutterMap(
      //   options: MapOptions(
      //     initialCenter: LatLng(0, 0), // Set the initial center of the map
      //     initialZoom: 4.0, // Set the initial zoom level
      //   ),
      //   children: [
      //     // Arcgis(
      //     //   // Replace with your ArcGIS map URL and API key
      //     //   urlTemplate:
      //     //       'https://your-arcgis-map-url.com/arcgis/rest/services/YourMapService/MapServer',
      //     //   Key: 'your-api-key',
      //     // ),
      //   ],
      // ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(title: Text('ArcGIS')),
  //       body: Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             Flexible(
  //               child: FlutterMap(
  //                 options: const MapOptions(
  //                   // center: LatLng(39.7644863,-105.0199111), // line
  //                   center: LatLng(35.611909, -82.440682),
  //                   zoom: 14.0,
  //                 ),
  //                 children: [
  //                   TileLayer(
  //                     urlTemplate:
  //                         'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
  //                     subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
  //                   ),
  //                   // FeatureLayer(FeatureLayerOptions("https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
  //                   //   "polygon",
  //                   //   onTap: (dynamic attributes, LatLng location) {
  //                   //     print(attributes);
  //                   //   },
  //                   //   render: (dynamic attributes){
  //                   //     return PolygonOptions(
  //                   //         borderColor: Colors.red,
  //                   //         color: Colors.black45,
  //                   //         borderStrokeWidth: 2,
  //                   //         isFilled:true
  //                   //     );
  //                   //   },
  //                   // ),)
  //                   FeatureLayer(FeatureLayerOptions(
  //                     "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0",
  //                     "point",
  //                     render: (dynamic attributes) {
  //                       // You can render by attribute
  //                       return const PointOptions(
  //                         width: 30.0,
  //                         height: 30.0,
  //                         builder: Icon(Icons.pin_drop),
  //                       );
  //                     },
  //                     onTap: (attributes, LatLng location) {
  //                       print(attributes);
  //                     },
  //                   )),
  //                   // FeatureLayer(FeatureLayerOptions(
  //                   //   "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/ArcGIS/rest/services/Denver_Streets_Centerline/FeatureServer/0",
  //                   //   "polyline",
  //                   //   render:(dynamic attributes){
  //                   //     // You can render by attribute
  //                   //     return PolygonLineOptions(
  //                   //         borderColor: Colors.red,
  //                   //         color: Colors.red,
  //                   //         borderStrokeWidth: 2
  //                   //     );
  //                   //   },
  //                   //   onTap: (attributes, LatLng location) {
  //                   //     print(attributes);
  //                   //   },
  //                   // ))
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
