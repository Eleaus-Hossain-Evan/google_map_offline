import 'package:equatable/equatable.dart';

class DirectionModel extends Equatable {
  final List<GeocodedWaypointModel> geocoded_waypoints;
  final List<RouteModel> routes;
  final String status;
  const DirectionModel({
    required this.geocoded_waypoints,
    required this.routes,
    required this.status,
  });

  DirectionModel copyWith({
    List<GeocodedWaypointModel>? geocoded_waypoints,
    List<RouteModel>? routes,
    String? status,
  }) {
    return DirectionModel(
      geocoded_waypoints: geocoded_waypoints ?? this.geocoded_waypoints,
      routes: routes ?? this.routes,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'geocoded_waypoints': geocoded_waypoints.map((x) => x.toMap()).toList(),
      'routes': routes.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory DirectionModel.fromMap(Map<String, dynamic> map) {
    return DirectionModel(
      geocoded_waypoints: List<GeocodedWaypointModel>.from(
          map['geocoded_waypoints']
                  ?.map((x) => GeocodedWaypointModel.fromMap(x)) ??
              const []),
      routes: List<RouteModel>.from(
          map['routes']?.map((x) => RouteModel.fromMap(x)) ?? const []),
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() =>
      'DirectionModel(geocoded_waypoints: $geocoded_waypoints, routes: $routes, status: $status)';

  @override
  List<Object> get props => [geocoded_waypoints, routes, status];
}

class GeocodedWaypointModel extends Equatable {
  final String geocoder_status;
  final String place_id;
  final List<String> types;
  const GeocodedWaypointModel({
    required this.geocoder_status,
    required this.place_id,
    required this.types,
  });

  GeocodedWaypointModel copyWith({
    String? geocoder_status,
    String? place_id,
    List<String>? types,
  }) {
    return GeocodedWaypointModel(
      geocoder_status: geocoder_status ?? this.geocoder_status,
      place_id: place_id ?? this.place_id,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'geocoder_status': geocoder_status,
      'place_id': place_id,
      'types': types,
    };
  }

  factory GeocodedWaypointModel.fromMap(Map<String, dynamic> map) {
    return GeocodedWaypointModel(
      geocoder_status: map['geocoder_status'] ?? '',
      place_id: map['place_id'] ?? '',
      types: List<String>.from(map['types'] ?? const []),
    );
  }

  @override
  String toString() =>
      'Geocoded_waypoint(geocoder_status: $geocoder_status, place_id: $place_id, types: $types)';

  @override
  List<Object> get props => [geocoder_status, place_id, types];
}

class RouteModel extends Equatable {
  final Bounds bounds;
  final String copyrights;
  final List<LegModel> legs;
  final OverviewPolylineModel overview_polyline;
  final String summary;
  final List<dynamic> warnings;
  final List<dynamic> waypoint_order;
  const RouteModel({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overview_polyline,
    required this.summary,
    required this.warnings,
    required this.waypoint_order,
  });

  RouteModel copyWith({
    Bounds? bounds,
    String? copyrights,
    List<LegModel>? legs,
    OverviewPolylineModel? overview_polyline,
    String? summary,
    List<dynamic>? warnings,
    List<dynamic>? waypoint_order,
  }) {
    return RouteModel(
      bounds: bounds ?? this.bounds,
      copyrights: copyrights ?? this.copyrights,
      legs: legs ?? this.legs,
      overview_polyline: overview_polyline ?? this.overview_polyline,
      summary: summary ?? this.summary,
      warnings: warnings ?? this.warnings,
      waypoint_order: waypoint_order ?? this.waypoint_order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bounds': bounds.toMap(),
      'copyrights': copyrights,
      'legs': legs.map((x) => x.toMap()).toList(),
      'overview_polyline': overview_polyline.toMap(),
      'summary': summary,
      'warnings': warnings,
      'waypoint_order': waypoint_order,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      bounds: Bounds.fromMap(map['bounds']),
      copyrights: map['copyrights'] ?? '',
      legs: List<LegModel>.from(
          map['legs']?.map((x) => LegModel.fromMap(x)) ?? const []),
      overview_polyline:
          OverviewPolylineModel.fromMap(map['overview_polyline']),
      summary: map['summary'] ?? '',
      warnings: List<dynamic>.from(map['warnings'] ?? const []),
      waypoint_order: List<dynamic>.from(map['waypoint_order'] ?? const []),
    );
  }

  @override
  String toString() {
    return 'Route(bounds: $bounds, copyrights: $copyrights, legs: $legs, overview_polyline: $overview_polyline, summary: $summary, warnings: $warnings, waypoint_order: $waypoint_order)';
  }

  @override
  List<Object> get props {
    return [
      bounds,
      copyrights,
      legs,
      overview_polyline,
      summary,
      warnings,
      waypoint_order,
    ];
  }
}

class Bounds extends Equatable {
  final Northeast northeast;
  final Southwest southwest;
  const Bounds({
    required this.northeast,
    required this.southwest,
  });

  Bounds copyWith({
    Northeast? northeast,
    Southwest? southwest,
  }) {
    return Bounds(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'northeast': northeast.toMap(),
      'southwest': southwest.toMap(),
    };
  }

  factory Bounds.fromMap(Map<String, dynamic> map) {
    return Bounds(
      northeast: Northeast.fromMap(map['northeast']),
      southwest: Southwest.fromMap(map['southwest']),
    );
  }

  @override
  String toString() => 'Bounds(northeast: $northeast, southwest: $southwest)';

  @override
  List<Object> get props => [northeast, southwest];
}

class Northeast extends Equatable {
  final double lat;
  final double lng;
  const Northeast({
    required this.lat,
    required this.lng,
  });

  Northeast copyWith({
    double? lat,
    double? lng,
  }) {
    return Northeast(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Northeast.fromMap(Map<String, dynamic> map) {
    return Northeast(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'Northeast(lat: $lat, lng: $lng)';

  @override
  List<Object> get props => [lat, lng];
}

class Southwest extends Equatable {
  final double lat;
  final double lng;
  const Southwest({
    required this.lat,
    required this.lng,
  });

  Southwest copyWith({
    double? lat,
    double? lng,
  }) {
    return Southwest(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Southwest.fromMap(Map<String, dynamic> map) {
    return Southwest(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'Southwest(lat: $lat, lng: $lng)';

  @override
  List<Object> get props => [lat, lng];
}

class LegModel extends Equatable {
  final Distance distance;
  final DurationModel duration;
  final String end_address;
  final End_location end_location;
  final String start_address;
  final Start_location start_location;
  final List<StepModel> steps;
  final List<dynamic> traffic_speed_entry;
  final List<dynamic> via_waypoint;
  const LegModel({
    required this.distance,
    required this.duration,
    required this.end_address,
    required this.end_location,
    required this.start_address,
    required this.start_location,
    required this.steps,
    required this.traffic_speed_entry,
    required this.via_waypoint,
  });

  LegModel copyWith({
    Distance? distance,
    DurationModel? duration,
    String? end_address,
    End_location? end_location,
    String? start_address,
    Start_location? start_location,
    List<StepModel>? steps,
    List<dynamic>? traffic_speed_entry,
    List<dynamic>? via_waypoint,
  }) {
    return LegModel(
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      end_address: end_address ?? this.end_address,
      end_location: end_location ?? this.end_location,
      start_address: start_address ?? this.start_address,
      start_location: start_location ?? this.start_location,
      steps: steps ?? this.steps,
      traffic_speed_entry: traffic_speed_entry ?? this.traffic_speed_entry,
      via_waypoint: via_waypoint ?? this.via_waypoint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance.toMap(),
      'duration': duration.toMap(),
      'end_address': end_address,
      'end_location': end_location.toMap(),
      'start_address': start_address,
      'start_location': start_location.toMap(),
      'steps': steps.map((x) => x.toMap()).toList(),
      'traffic_speed_entry': traffic_speed_entry,
      'via_waypoint': via_waypoint,
    };
  }

  factory LegModel.fromMap(Map<String, dynamic> map) {
    return LegModel(
      distance: Distance.fromMap(map['distance']),
      duration: DurationModel.fromMap(map['duration']),
      end_address: map['end_address'] ?? '',
      end_location: End_location.fromMap(map['end_location']),
      start_address: map['start_address'] ?? '',
      start_location: Start_location.fromMap(map['start_location']),
      steps: List<StepModel>.from(
          map['steps']?.map((x) => StepModel.fromMap(x)) ?? const []),
      traffic_speed_entry:
          List<dynamic>.from(map['traffic_speed_entry'] ?? const []),
      via_waypoint: List<dynamic>.from(map['via_waypoint'] ?? const []),
    );
  }

  @override
  String toString() {
    return 'Leg(distance: $distance, duration: $duration, end_address: $end_address, end_location: $end_location, start_address: $start_address, start_location: $start_location, steps: $steps, traffic_speed_entry: $traffic_speed_entry, via_waypoint: $via_waypoint)';
  }

  @override
  List<Object> get props {
    return [
      distance,
      duration,
      end_address,
      end_location,
      start_address,
      start_location,
      steps,
      traffic_speed_entry,
      via_waypoint,
    ];
  }
}

class Distance extends Equatable {
  final String text;
  final int value;
  const Distance({
    required this.text,
    required this.value,
  });

  Distance copyWith({
    String? text,
    int? value,
  }) {
    return Distance(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'value': value,
    };
  }

  factory Distance.fromMap(Map<String, dynamic> map) {
    return Distance(
      text: map['text'] ?? '',
      value: map['value']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'Distance(text: $text, value: $value)';

  @override
  List<Object> get props => [text, value];
}

class DurationModel extends Equatable {
  final String text;
  final int value;
  const DurationModel({
    required this.text,
    required this.value,
  });

  DurationModel copyWith({
    String? text,
    int? value,
  }) {
    return DurationModel(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'value': value,
    };
  }

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      text: map['text'] ?? '',
      value: map['value']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'Duration(text: $text, value: $value)';

  @override
  List<Object> get props => [text, value];
}

class End_location extends Equatable {
  final double lat;
  final double lng;
  const End_location({
    required this.lat,
    required this.lng,
  });

  End_location copyWith({
    double? lat,
    double? lng,
  }) {
    return End_location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory End_location.fromMap(Map<String, dynamic> map) {
    return End_location(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'End_location(lat: $lat, lng: $lng)';

  @override
  List<Object> get props => [lat, lng];
}

class Start_location extends Equatable {
  final double lat;
  final double lng;
  const Start_location({
    required this.lat,
    required this.lng,
  });

  Start_location copyWith({
    double? lat,
    double? lng,
  }) {
    return Start_location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Start_location.fromMap(Map<String, dynamic> map) {
    return Start_location(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'Start_location(lat: $lat, lng: $lng)';

  @override
  List<Object> get props => [lat, lng];
}

class StepModel extends Equatable {
  final Distance distance;
  final DurationModel duration;
  final End_location end_location;
  final String html_instructions;
  final PolylineModel polyline;
  final Start_location start_location;
  final String travel_mode;
  const StepModel({
    required this.distance,
    required this.duration,
    required this.end_location,
    required this.html_instructions,
    required this.polyline,
    required this.start_location,
    required this.travel_mode,
  });

  StepModel copyWith({
    Distance? distance,
    DurationModel? duration,
    End_location? end_location,
    String? html_instructions,
    PolylineModel? polyline,
    Start_location? start_location,
    String? travel_mode,
  }) {
    return StepModel(
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      end_location: end_location ?? this.end_location,
      html_instructions: html_instructions ?? this.html_instructions,
      polyline: polyline ?? this.polyline,
      start_location: start_location ?? this.start_location,
      travel_mode: travel_mode ?? this.travel_mode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance.toMap(),
      'duration': duration.toMap(),
      'end_location': end_location.toMap(),
      'html_instructions': html_instructions,
      'polyline': polyline.toMap(),
      'start_location': start_location.toMap(),
      'travel_mode': travel_mode,
    };
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      distance: Distance.fromMap(map['distance']),
      duration: DurationModel.fromMap(map['duration']),
      end_location: End_location.fromMap(map['end_location']),
      html_instructions: map['html_instructions'] ?? '',
      polyline: PolylineModel.fromMap(map['polyline']),
      start_location: Start_location.fromMap(map['start_location']),
      travel_mode: map['travel_mode'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Step(distance: $distance, duration: $duration, end_location: $end_location, html_instructions: $html_instructions, polyline: $polyline, start_location: $start_location, travel_mode: $travel_mode)';
  }

  @override
  List<Object> get props {
    return [
      distance,
      duration,
      end_location,
      html_instructions,
      polyline,
      start_location,
      travel_mode,
    ];
  }
}

class PolylineModel extends Equatable {
  final String points;
  const PolylineModel({
    required this.points,
  });

  PolylineModel copyWith({
    String? points,
  }) {
    return PolylineModel(
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'points': points,
    };
  }

  factory PolylineModel.fromMap(Map<String, dynamic> map) {
    return PolylineModel(
      points: map['points'] ?? '',
    );
  }

  @override
  String toString() => 'Polyline(points: $points)';

  @override
  List<Object> get props => [points];
}

class OverviewPolylineModel extends Equatable {
  final String points;
  const OverviewPolylineModel({
    required this.points,
  });

  OverviewPolylineModel copyWith({
    String? points,
  }) {
    return OverviewPolylineModel(
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'points': points,
    };
  }

  factory OverviewPolylineModel.fromMap(Map<String, dynamic> map) {
    return OverviewPolylineModel(
      points: map['points'] ?? '',
    );
  }

  @override
  String toString() => 'Overview_polyline(points: $points)';

  @override
  List<Object> get props => [points];
}
