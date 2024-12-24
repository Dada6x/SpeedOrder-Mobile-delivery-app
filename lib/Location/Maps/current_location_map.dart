import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import for reverse geocoding
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/main_page.dart';

class Currentlocationmap extends StatefulWidget {
  const Currentlocationmap({super.key});

  @override
  State<Currentlocationmap> createState() => _MapScreenState();
}

class _MapScreenState extends State<Currentlocationmap> {
  final MapController _mapController = MapController();

  LatLng? selectedPosition;
  String? selectedAddress;
  bool _isGettingLocation = false;

  @override
  void initState() {
    super.initState();
    showCurrentLocation();
  }

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

  void showCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String supaddress = "${place.administrativeArea}, ${place.country}";
        setState(() {
          selectedAddress = supaddress;
        });

        // Send the address to the LocationController
        Get.find<LocationController>().updateLocation(supaddress);
      }

      _mapController.move(currentLatLng, 15);
      setState(() {
        selectedPosition = currentLatLng;
      });
    } catch (e) {
      print("Error fetching current location: $e");
    } finally {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainPage.orangeColor,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialZoom: 13.0,
              initialCenter: const LatLng(51.5, -0.09),
              onTap: (tapPosition, point) {},
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
                        Icons.location_on_sharp,
                        color: Colors.red,
                        size: 45,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isGettingLocation)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
