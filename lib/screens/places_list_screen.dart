import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_device_demoapp/providers/great_places.dart';
import 'package:native_device_demoapp/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: const Center(child: Text('No places...')),
                    builder: (ctx, gPlaces, ch) => gPlaces.items.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: gPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  File(gPlaces.items[i].image.path),
                                ),
                              ),
                              title: Text(gPlaces.items[i].title),
                              onTap: () {
                                //...detail
                              },
                            ),
                          )),
      ),
    );
  }
}
