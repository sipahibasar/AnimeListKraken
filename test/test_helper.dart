import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadJson(String path) async {
  final file = File(path);
  final jsonString = await file.readAsString();
  return jsonDecode(jsonString);
}

