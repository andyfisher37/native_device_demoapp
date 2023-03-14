import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_demoapp/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String ptitle, XFile pimage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pimage,
        title: ptitle,
        location: PlaceLocation(null, null, null));
    _items.add(newPlace);
    notifyListeners();
  }
}
