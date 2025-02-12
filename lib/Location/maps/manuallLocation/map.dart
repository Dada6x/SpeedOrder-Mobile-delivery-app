import 'dart:convert';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/model/model.dart';
import 'package:mamamia_uniproject/Controllers/locationController_map.dart';
import 'package:mamamia_uniproject/Location/allsetup.dart';

import 'package:mamamia_uniproject/main_page.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  LatLng? selectedPosition;
  String? selectedAddress;
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  bool _isGettingLocation = false; 

  Future<Position> _determinePosition() async {
    // prmsin
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
//! getting address from geo
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        String supaddress = "${place.administrativeArea}, ${place.country}";
        setState(() {
          selectedAddress = address;
        });

        // Update the location in the GetX controller
        Get.find<LocationController>().updateLocation(supaddress);
      } else {
        setState(() {
          selectedAddress = "No address available".tr;
        });
      }
    } catch (e) {
      setState(() {
        selectedAddress = "Error fetching address".tr;
      });
    }
  }

  void showCurrentLocation() async {
    setState(() {
      _isGettingLocation = true; 
    });

    try {//take location from 
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15);
      setState(() {
        selectedPosition = currentLatLng;
      });
      await _getAddressFromLatLng(currentLatLng);
      _showBottomSheet(context);
    } catch (e) {
      print("Error fetching current location: $e");
    } finally {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selected Location".tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MainPage.orangeColor),
              ),
              const SizedBox(height: 8),
              if (selectedAddress != null)
                Text(
                  "Address:" "$selectedAddress".tr,
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
                    child: Text("Back".tr),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(const AllSetup());
                      //location request
                      Get.find<Model>().editUserLocationRequest();
                    },
                    child: Text("Set Location".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5";

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      setState(() {
        _searchResults = data;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      print("Error during search: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainPage.orangeColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                  _showBottomSheet(context);
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
                        Icons.location_on_sharp,
                        color: Colors.red,
                        size: 45,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          //! the search box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.048,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 10, right: 10, bottom: 20),
                  child: Material(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    child: TextField(
                      onChanged: (query) {
                        _searchPlaces(query);
                      },
                      decoration: InputDecoration(
                        hintText: "Where are you ?".tr,
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(FontAwesomeIcons.search),
                        prefixIconColor: Theme.of(context).colorScheme.primary,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_searchResults.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8)),
                      height: 170,
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final result = _searchResults[index];
                          return ListTile(
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(result['display_name'] ?? ''),
                            onTap: () {
                              final lat = double.parse(result['lat']);
                              final lon = double.parse(result['lon']);
                              LatLng selectedLatLng = LatLng(lat, lon);
                              _mapController.move(selectedLatLng, 15);
                              setState(() {
                                selectedPosition = selectedLatLng;
                                _searchResults = [];
                              });
                              _getAddressFromLatLng(selectedLatLng);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                if (_isSearching || _isGettingLocation) // Show loader
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
