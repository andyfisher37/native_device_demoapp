import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:native_device_demoapp/helpers/location_helper.dart';
import 'package:native_device_demoapp/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initLocation;
  final bool isSelecting;

  const MapScreen(
      {super.key,
      this.initLocation = const PlaceLocation(
          latitude: 31.777627, longitude: 35.204960, address: ''),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController(
    initMapWithUserPosition: true,
  );

  GeoPoint? _pickedLocation;

  void selectLocation(GeoPoint position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select place location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        LocationHelper.getPlaceAddress(
                            _pickedLocation!.latitude,
                            _pickedLocation!.longitude);
                        Navigator.of(context).pop();
                      },
                icon: const Icon(Icons.check)),
        ],
      ),
      body: OSMFlutter(
        controller: mapController,
        trackMyPosition: false,
        initZoom: 12,
        minZoomLevel: 8,
        maxZoomLevel: 14,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        )),
        onGeoPointClicked: widget.isSelecting ? selectLocation : null,
      ),
      // YandexMap(
      //   logoAlignment: const MapAlignment(
      //       horizontal: HorizontalAlignment.left,
      //       vertical: VerticalAlignment.bottom),
      //   onMapTap:
      //   mapObjects: _pickedLocation == null ? [] : mapObjects,
      // ),
    );
  }
}
