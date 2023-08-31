import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

class JsonHandler {
  Future<Map<String, dynamic>?> readJson(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      return await json.decode(response);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return null;
    }
  }
}
