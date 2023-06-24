import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


class TakePictureModel extends ChangeNotifier {
  List<String> _pictures = [];

  List<String> get pictures => _pictures;

  void setPictures(List<String> pictures) {
    _pictures = pictures;
    notifyListeners();
  }
}