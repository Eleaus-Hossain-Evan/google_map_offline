import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        zoomControlsEnabled: false,
        compassEnabled: true,
        layoutDirection: TextDirection.rtl,
        myLocationEnabled: true,
        circles: mapController.circles,
        markers: Set<Marker>.of(mapController.markers.values),
        polylines: Set<Polyline>.of(mapController.polylines.values),
        initialCameraPosition: mapController.kGooglePlex!,
        onMapCreated: (GoogleMapController controller) {
          if (mapController.googleMapsController.value.isCompleted) {
            mapController.googleMapsController.value = Completer();
          } else {
            mapController.googleMapsController.value.complete(controller);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
