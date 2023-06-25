import 'package:clean_api/clean_api.dart';
import 'package:google_map_offline/direction_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const mapKey = "AIzaSyALFg25BhJL0dq4BOA2bIQ5ki10RqGnadQ";

class GoogleService {
  final api = CleanApi.instance;
  Future<Either<CleanFailure, DirectionModel>> getPolylineData(
    LatLng origin,
    LatLng destination,
  ) async {
    // GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: mapKey);

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?key=$mapKey&units=metric&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving';
    // final response = await http.get(Uri.parse(url));
    // final jsonData = jsonDecode(response.body);
    // return DirectionModel.fromMap(
    //     jsonDecode(response.body) as Map<String, dynamic>);

    final response = await api.get<DirectionModel>(
      fromData: (json) {
        return DirectionModel.fromMap(json);
      },
      endPoint: url,
    );

    return response;

    // final String url =
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';
    // try {
    //   var response = await http.get(Uri.parse(url));
    //   var jsonData = jsonDecode(response.body);
    //   if (jsonData['status'] == "OK") {
    //     var result = {
    //       'bounds_ne': jsonData['routes'][0]['bounds']['northeast'],
    //       'bounds_sw': jsonData['routes'][0]['bounds']['southwest'],
    //       'start_location': jsonData['routes'][0]['legs'][0]['start_location'],
    //       'end_location': jsonData['routes'][0]['legs'][0]['end_location'],
    //       'polyline': jsonData['routes'][0]['overview_polyline']['points'],
    //       'polyline_decoded': PolylinePoints().decodePolyline(
    //           jsonData['routes'][0]['overview_polyline']['points'])
    //     };
    //     return result;
    //   } else {
    //     var result = {
    //       'bounds_ne': "",
    //       'bounds_sw': "",
    //       'start_location': 0,
    //       'end_location': 0,
    //       'polyline': "",
    //       'polyline_decoded': "",
    //     };
    //     return result;
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());

    //   return {};
    // }
  }
}
