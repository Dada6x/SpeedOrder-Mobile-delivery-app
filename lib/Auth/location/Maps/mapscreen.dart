import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/location/allsetup.dart';
import 'package:mamamia_uniproject/components/search_bar.dart';
import 'package:mamamia_uniproject/main_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? selectedPosition;
  String? selectedAddress;
  LatLng? _myLocation;

  // Get the current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location services are permanently denied');
    }

    return Geolocator.getCurrentPosition();
  }

  // Reverse geocoding to get address from coordinates
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          selectedAddress =
              "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          selectedAddress = "No address available";
        });
      }
    } catch (e) {
      setState(() {
        selectedAddress = "Error fetching address";
        print(e);
      });
    }
  }

  // Show current location
  void showCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15);
      setState(() {
        _myLocation = currentLatLng;
        selectedPosition = currentLatLng;
      });
      await _getAddressFromLatLng(currentLatLng);
      _showBottomSheet(context); // Show the bottom sheet
    } catch (e) {
      print("Error fetching current location: $e");
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Location",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MainPage.orangeColor),
            ),
            const SizedBox(height: 8),
            if (selectedAddress != null)
              Text(
                "Address: $selectedAddress",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 8),
            if (selectedPosition != null)
              Text(
                "Coordinates: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back"),
                ),
                TextButton(
                  onPressed: () => Get.off(const AllSetup()),
                  child: const Text("Set Location"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          showCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialZoom: 13.0,
              initialCenter: const LatLng(51.5, -0.09),
              onTap: (tapPosition, point) {
                setState(() {
                  selectedPosition = point;
                });
                _getAddressFromLatLng(point).then((_) {
                  _showBottomSheet(context); // Show bottom sheet after clicking
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              if (selectedPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: selectedPosition!,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 45,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const Align(
              alignment: Alignment(0, -0.9),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ProjectSearchBar(),
              ))
        ],
      ),
    );
  }
}
