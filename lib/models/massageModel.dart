import 'package:flutter/foundation.dart';

class Massage {
  final String massage;
  Massage(this.massage);

  factory Massage.fromJson(jsonData) {
    return Massage(jsonData['massage']);
  }
}
