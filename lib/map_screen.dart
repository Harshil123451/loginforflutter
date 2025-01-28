import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  LatLng _currentPosition = const LatLng(0, 0);
  bool _isLoading = true;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      // First check and request permission
      final permissionStatus = await _location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        final newStatus = await _location.requestPermission();
        if (newStatus != PermissionStatus.granted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission is required')),
          );
          return;
        }
      }

      // Then check if service is enabled
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final isEnabled = await _location.requestService();
        if (!isEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location service is required')),
          );
          return;
        }
      }

      // Configure location settings
      await _location.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 1000,
      );

      await _getCurrentLocation();
    } catch (e) {
      debugPrint('Error initializing location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing location: $e')),
        );
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _location.getLocation();
      
      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception('Location data is incomplete');
      }

      setState(() {
        _currentPosition = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        _markers = [
          Marker(
            point: _currentPosition,
            builder: (context) => const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ];
        _isLoading = false;
      });

      _mapController.move(_currentPosition, 15);

      // Set up location change subscription
      _location.onLocationChanged.listen((LocationData newLocation) {
        if (!mounted) return;
        if (newLocation.latitude != null && newLocation.longitude != null) {
          setState(() {
            _currentPosition = LatLng(
              newLocation.latitude!,
              newLocation.longitude!,
            );
            _markers = [
              Marker(
                point: _currentPosition,
                builder: (context) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ];
          });
        }
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get location')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).map),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentPosition,
                zoom: 15,
                maxZoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
} 