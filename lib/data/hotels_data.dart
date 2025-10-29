import 'dart:convert';
import 'dart:math';

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
    final shuffled = hotels..shuffle();
    return shuffled.map((e) => Hotels.fromJson(e)).toList();
  }
}

class EgLandMark {
  static Future<List<LandMark>> getLandMark() async {
    final response = await rootBundle.loadString(
      "assets/data/egypt_landmarks_detailed.json",
    );
    final decoded = jsonDecode(response);
    final List landMark = decoded;
    final shuffled = landMark..shuffle();
    return shuffled.map((e) => LandMark.fromJson(e)).toList();
  }
}
