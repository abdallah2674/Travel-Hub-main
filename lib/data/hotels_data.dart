import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:travel_hub/models/hotels_model.dart';
import 'package:travel_hub/models/land_mark_model.dart';

class EgHotels {
  static Future<List<Hotels>> getEgHotels() async {
    final response = await rootBundle.loadString(
      "assets/data/egypt_hotels_clean_descriptions.json",
    );
    final decoded = jsonDecode(response);
    final List hotels = decoded["hotels"];
    return hotels.map((e) => Hotels.fromJson(e)).toList();
  }
}

class EgLandMark {
  static Future<List<LandMark>> getLandMark() async {
    final response = await rootBundle.loadString(
      "assets/data/egypt_landmarks_final.json",
    );
    final decoded = jsonDecode(response);
    final List landMark = decoded;
    return landMark.map((e) => LandMark.fromJson(e)).toList();
  }
}
