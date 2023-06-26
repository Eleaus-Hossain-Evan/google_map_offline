import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_map_offline/google_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_utils/google_maps_utils.dart' as utils;
import 'package:location/location.dart';

class MapController extends GetxController {
  Timer? timer;
  final circles = RxSet<Circle>();

  var googleMapsController = Completer<GoogleMapController>().obs;
  RxMap<PolylineId, Polyline> polylines = RxMap();
  RxMap<MarkerId, Marker> markers = RxMap();

  final CameraPosition? kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  var dataList = <math.Point>[].obs;
  var polylineCoordinates = <LatLng>[].obs;
  final googleService = GoogleService();

  final pickedLocation = const LatLng(40.677939, -73.941755).obs;
  final destinationLocation = const LatLng(40.698432, -73.924038).obs;
  final latLngBounds = Rxn<LatLngBounds>();
  final encodedPolyline = "".obs;
  final distance = "".obs;
  final timeWithoutParse = "".obs;

  final polyloading = RxBool(false);

  // Location location = Location.;
  final _serviceEnabled = RxBool(false);
  final _permissionGranted = Rx(PermissionStatus.notDetermined);

  final cameraZoom = RxInt(0);

  Future initializeLocation() async {
    _serviceEnabled.value = await isGPSEnabled();
    if (!_serviceEnabled.value) {
      Get.showSnackbar(const GetSnackBar(
        message: "GPS isn't on!!",
      )).show();
      return;
    }

    _permissionGranted.value = await getPermissionStatus();

    if (_permissionGranted.value == PermissionStatus.denied ||
        _permissionGranted.value == PermissionStatus.notDetermined) {
      _permissionGranted.value = await requestPermission();

      if (_permissionGranted.value != PermissionStatus.authorizedAlways ||
          _permissionGranted.value != PermissionStatus.authorizedWhenInUse) {
        Get.showSnackbar(const GetSnackBar(
          message: "Couldn't get location permission!!",
        )).show();
        return;
      }
    }
  }

  @override
  void onInit() {
    initializeLocation().then((_) {
      if (_permissionGranted.value == PermissionStatus.authorizedAlways ||
          _permissionGranted.value == PermissionStatus.authorizedWhenInUse) {
        start();
      }
    });
    super.onInit();
  }

  Future getPolyline() async {
    final result = await googleService.getPolylineData(
      LatLng(
        pickedLocation.value.latitude,
        pickedLocation.value.longitude,
      ),
      LatLng(
        destinationLocation.value.latitude,
        destinationLocation.value.longitude,
      ),
    );

    result.fold(
      (l) => CleanFailureDialogue.show(Get.context!, failure: l),
      (data) {
        if (data.status == "ok") {
          latLngBounds.value = LatLngBounds(
            southwest: LatLng(
              data.routes[0].bounds.southwest.lat,
              data.routes[0].bounds.southwest.lng,
            ),
            northeast: LatLng(
              data.routes[0].bounds.northeast.lat,
              data.routes[0].bounds.northeast.lat,
            ),
          );
          polylineCoordinates.clear();
          dataList.clear();
          encodedPolyline.value = data.routes[0].overview_polyline.points;
          polylineCoordinates.value = PolylinePoints()
              .decodePolyline(data.routes[0].overview_polyline.points)
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList();
          dataList.value =
              List<math.Point>.from(polylineCoordinates.map((element) {
            return math.Point(element.longitude, element.latitude);
          })).toList();
          // time.value = mapConversion(data["time"].toString());
          timeWithoutParse.value = data.routes[0].legs[0].duration.text;

          distance.value = data.routes[0].legs[0].distance.text;
        } else {
          if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
            // ResponseDialogue(type: "error", h1: "Error", h2: data["data"]);
          }
        }
      },
    );
  }

  addPolyLine(RxList<LatLng> polyline) {
    polylines.addAllIf(
      polyline.isNotEmpty,
      {
        const PolylineId("polyline"): Polyline(
          polylineId: const PolylineId("polyline"),
          color: Colors.red,
          width: 5,
          points: polyline,
        ),
      },
    );
  }

  addMarker({
    required LatLng position,
    required String id,
    required double rotation,
    required BitmapDescriptor descriptor,
    required Offset anchor,
  }) {
    markers.addAll({
      MarkerId(id): Marker(
        markerId: MarkerId(id),
        position: position,
        rotation: rotation,
        icon: descriptor,
        anchor: anchor,
      ),
    });
  }

  updateCameraPositionForNavigation() async {
    googleMapsController.value.future.then(
      (controller) => controller.animateCamera(
        CameraUpdate.newLatLngBounds(latLngBounds.value!, 50),
      ),
    );
  }

  algo() async {
    var polyline = <LatLng>[].obs;

    var pickUp = await getBytesFromAsset("assets/pick.png", 80, 80);
    var dest = await getBytesFromAsset("assets/destination.png", 40, 40);
    await getLocation().then((l) async {
      var isOnPath = utils.PolyUtils.isLocationOnPathTolerance(
          math.Point(
            l.longitude!,
            l.latitude!,
          ),
          dataList,
          false,
          8);

      if (isOnPath) {
        math.Point currentPoint = math.Point(l.longitude!, l.latitude!);

        if (polylineCoordinates.length > 1) {
          var x = polylineCoordinates.indexWhere((e) {
            var dis = utils.SphericalUtils.computeDistanceBetween(
                currentPoint, math.Point(e.longitude, e.latitude));
            return (dis <= 5 && dis >= 0);
          });

          if (x == 0) {
            polylineCoordinates.removeAt(0);
          } else {
            if (x != -1) {
              polylineCoordinates.removeRange(0, x);
            }
          }
        }

        polyline.clear();
        polyline.value = [
          LatLng(l.latitude!, l.longitude!),
          ...polylineCoordinates,
        ];

        addPolyLine(polyline);
        markers.clear();

        cameraZoom.value = 18;
        Set<Circle> circles2 = {
          Circle(
            circleId: const CircleId("pickup"),
            center: LatLng(l.latitude!, l.longitude!),
            fillColor: Colors.blue.shade100.withOpacity(0.5),
            strokeColor: Colors.blue.shade100.withOpacity(0.1),
            radius: 20,
          )
        };
        circles.addAll(circles2);
        addMarker(
          position: LatLng(l.latitude!, l.longitude!),
          id: "pickup",
          rotation: l.bearing ?? 0.0,
          descriptor: BitmapDescriptor.fromBytes(pickUp),
          anchor: const Offset(0.5, 0.5),
        );
        addMarker(
          position: destinationLocation.value,
          id: "dest",
          rotation: l.bearing ?? 0.0,
          descriptor: BitmapDescriptor.fromBytes(dest),
          anchor: const Offset(0.5, 0.5),
        );

        updateCameraPositionForNavigation();
      } else {
        if (polyloading.value == false) {
          await getData();
        }
      }
    });
  }

  Future getData() async {
    try {
      polyloading(true);
      await getLocation(
        settings: LocationSettings(ignoreLastKnownPosition: true),
      ).then((l) async {
        pickedLocation.value = LatLng(l.latitude!, l.longitude!);

        destinationLocation.value = const LatLng(31.483134, 74.315002);

        await getPolyline();
      });
    } finally {
      polyloading(false);
    }
  }

  start() async {
    await getData().then((_) {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (polyloading.value == false) {
          algo();
        }
      });
    });
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width, int height) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
