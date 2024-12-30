import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/main_page.dart';

class CurrentLocationMap extends StatefulWidget {
  const CurrentLocationMap({super.key});

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  final MapController _mapController = MapController();
  LatLng? currentLocation;
  String? address;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _checkLocationServicesAndPermissions();
  }

  Future<void> _checkLocationServicesAndPermissions() async {
    setState(() => errorMessage = null); // Clear any previous error
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        errorMessage =
            "Location services are disabled. Please enable them to use this feature.";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          errorMessage =
              "Location permission is denied. Please allow location access to use this feature.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        errorMessage =
            "Location permission is permanently denied. Please enable it in settings.";
      });
      return;
    }

    setState(() {
      errorMessage = null; // Clear error if all checks pass
    });

    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() => isLoading = true);
    try {
      Position position = await Geolocator.getCurrentPosition();
      LatLng positionLatLng = LatLng(position.latitude, position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String formattedAddress = placemarks.isNotEmpty
          ? "${placemarks[0].administrativeArea}, ${placemarks[0].country}"
          : "Unknown Location";

      setState(() {
        currentLocation = positionLatLng;
        address = formattedAddress;
      });
      Get.find<LocationController>().updateLocation(formattedAddress);
      _mapController.move(positionLatLng, 15);
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialZoom: 13.0,
              initialCenter: LatLng(51.5, -0.09),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              if (currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: currentLocation!,
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
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (errorMessage != null)
            Center(
              child: Container(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                padding: const EdgeInsets.all(16.0),
                child: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        color: MainPage.orangeColor,
                      ),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MainPage.orangeColor, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      IconButton(
                          onPressed: _checkLocationServicesAndPermissions,
                          icon: Icon(
                            Icons.loop,
                            color: MainPage.orangeColor,
                          )),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
