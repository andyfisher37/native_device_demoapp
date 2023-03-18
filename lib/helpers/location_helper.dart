import 'dart:convert';
import 'package:osm_nominatim/osm_nominatim.dart';

class LocationHelper {
  // Generate URL for static image map of current
  // user geolocation with Yandex
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://static-maps.yandex.ru/1.x/?lang=ru_RU&ll=$longitude,$latitude&size=450,450&z=15&l=map&pt=$longitude,$latitude,pm2dol';
  }

  // Function for get place addres with OSM geocoder
  Future<String> getPlaceAddress(double lat, double lon) async {
    final Place result = await Nominatim.reverseSearch(
      lat: lat,
      lon: lon,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    final String address = json.decode(result.displayName);
    print(address);
    return address;
  }
}
