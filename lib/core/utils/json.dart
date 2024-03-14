import 'dart:async';

import 'package:flutter/services.dart';

Future<String> loadJsonAsset(
  String name,
) async {
  return rootBundle.loadString('assets/mock_data/$name.json');
}
