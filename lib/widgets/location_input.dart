import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:location/location.dart';
import 'package:native_device_demoapp/helpers/location_helper.dart';
import 'package:native_device_demoapp/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // url for static image map
  String? _previewImageUrl;

  // Function for get current user location on map
  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final String location = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    setState(() {
      _previewImageUrl = location;
    });
  }

  // Function for dynamic select position on map widget MapScreen
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<GeoPoint>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(isSelecting: true),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    //..
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text(
                  'No select location',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select location'),
            ),
          ],
        )
      ],
    );
  }
}
