import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:mamamia_uniproject/main_page.dart'; // For reverse geocoding

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? selectedPosition;
  String? selectedAddress; // To store the human-readable address
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
      await _getAddressFromLatLng(currentLatLng); // Fetch address
    // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar('Enter your location'),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialZoom: 13.0,
              //!starts usually at the Uk
              initialCenter: const LatLng(51.5, -0.09),
              onTap: (tapPosition, point) {
                setState(() {
                  selectedPosition = point;
                });
                _getAddressFromLatLng(
                    point); 
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
          //! Floating action button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: MainPage.orangeColor,
                onPressed: () {
                  showCurrentLocation();
                },
                child: const Icon(Icons.my_location),
              ),
            ),
          ),
          if (selectedPosition != null)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  selectedAddress ?? "Fetching address...",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
