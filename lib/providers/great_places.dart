import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_demoapp/helpers/db_helper.dart';
import 'package:native_device_demoapp/helpers/location_helper.dart';
import 'package:native_device_demoapp/models/place.dart';

class GreatPlaces with ChangeNotifier {
  // Main list for save data
  List<Place> _items = [];

  // Get function for working with list of items
  List<Place> get items {
    return [..._items];
  }

  // Function for add data about place and stored it in db file on device
  Future<void> addPlace(
      String ptitle, XFile pimage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pimage,
        title: ptitle,
        location: updateLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  // Function for fetch and set data from db
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(
                  latitude: item['loc_lat'],
                  longitude: item['loc_lng'],
                  address: item['address']),
              image: XFile(item['image'])),
        )
        .toList();
    notifyListeners();
  }
}
