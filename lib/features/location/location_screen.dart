import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nogironlar_ilovasi/features/widgets/main_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../service/l10n/app_localizations.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final Completer<GoogleMapController> _controller;
  late final TextEditingController positionController;
  Position? _currentPosition;
  final List<Marker> _markers = <Marker>[];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _getCurrentLocation() async {
    _currentPosition = await _determinePosition();
    positionController.text =
        "${_currentPosition?.latitude}, ${_currentPosition?.longitude}";
    _markers.add(Marker(
      markerId: const MarkerId("current"),
      position: LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      ),
      infoWindow: const InfoWindow(title: 'Current Position'),
    ));
    if (mounted) setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void navigateToCurrentLocation() {
    _determinePosition().then((value) async {
      _markers.add(Marker(
        markerId: const MarkerId("current"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(
          title: 'Current Position',
        ),
      ));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 11,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<void> goSomewhere(lat, lng) async {
    final GoogleMapController controller = await _controller.future;
    final double lastZoom = await controller.getZoomLevel();
    positionController.text = "$lat, $lng";
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: lastZoom,
      ),
    ));
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("current"),
        position: LatLng(lat, lng),
        draggable: true,
      ));
    });
  }

  void shareLocation(double lat, double lng) {
    Share.share('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
  }

  @override
  void initState() {
    _controller = Completer();
    positionController = TextEditingController();
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final lang = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: _currentPosition != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      lang.location,
                      style: const TextStyle(
                        fontSize: 34,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height / 3 + 60,
                    child: GoogleMap(
                      onTap: (argument) => goSomewhere(
                        argument.latitude,
                        argument.longitude,
                      ),
                      trafficEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        zoom: 11,
                      ),
                      markers: Set<Marker>.of(_markers),
                      mapType: MapType.normal,
                      padding: const EdgeInsets.only(bottom: 80),
                    ),
                  ),
                  const Spacer(),
                  MainButton(
                    lang.currentLocation,
                    onPressed: navigateToCurrentLocation,
                  ),
                  const Spacer(),
                  MainButton(
                    lang.share,
                    vertPadding: 20,
                    onPressed: () => shareLocation(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                  ),
                  const Spacer(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
