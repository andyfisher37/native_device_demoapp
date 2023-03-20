import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_demoapp/models/place.dart';
import 'package:native_device_demoapp/providers/great_places.dart';
import 'package:native_device_demoapp/widgets/image_input.dart';
import 'package:native_device_demoapp/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // Text edit controller for title
  final _titleController = TextEditingController();

  XFile? _pickedImage;
  late PlaceLocation _pickedLocation;

  // Select image function
  void _selectImage(XFile pickedImage) {
    _pickedImage = pickedImage;
  }

  // Select place from map
  void _selectPlace(double latitude, double longitude) {
    _pickedLocation =
        PlaceLocation(latitude: latitude, longitude: longitude, address: '');
  }

  // Save place function
  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      // no data for place...
      print('no data for place...');
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title text'),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 10),
                  ImageInput(_selectImage),
                  const SizedBox(height: 10),
                  LocationInput(_selectPlace),
                ],
              ),
            ),
          )),
          // Add place buton
          OutlinedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
