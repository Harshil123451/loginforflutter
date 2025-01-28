import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../models/ticket.dart';
import 'l10n/app_localizations.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final Location _location = Location();
  final MapController _mapController = MapController();
  bool _isLoading = false;
  LatLng? _currentLocation;
  List<Marker> _markers = [];
  final List<String> _ticketTypes = [
    'Bug Report',
    'Feature Request',
    'Technical Issue',
    'General Inquiry',
    'Emergency',
  ];
  String _selectedTicketType = 'General Inquiry';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        _updateMarker(_currentLocation!);
        _mapController.move(_currentLocation!, 15);
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _currentLocation = position;
      _markers = [
        Marker(
          point: position,
          builder: (context) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).createTicket),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildTicketTypeSelector(),
              const SizedBox(height: 16),
              _buildMessageField(),
              const SizedBox(height: 16),
              _buildLocationMap(),
              const SizedBox(height: 16),
              _buildLocationInfo(),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).ticketTitle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.title),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildTicketTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedTicketType,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.category),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        items: _ticketTypes.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedTicketType = value!;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a ticket type';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).message,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.message),
      ),
      maxLines: 5,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a message';
        }
        return null;
      },
    );
  }

  Widget _buildLocationMap() {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentLocation ?? const LatLng(0, 0),
                zoom: 15,
                maxZoom: 18,
                onTap: (tapPosition, point) {
                  _updateMarker(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                mini: true,
                onPressed: _getCurrentLocation,
                child: const Icon(Icons.my_location),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).location,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (_currentLocation != null)
                  TextButton(
                    onPressed: () => _getCurrentLocation(),
                    child: Text(AppLocalizations.of(context).updateLocation),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (_currentLocation != null)
              Text(
                'Lat: ${_currentLocation!.latitude.toStringAsFixed(6)}\nLng: ${_currentLocation!.longitude.toStringAsFixed(6)}',
                style: const TextStyle(fontSize: 14),
              )
            else
              const Text('Getting location...'),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitTicket,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Submit Ticket',
              style: TextStyle(fontSize: 16),
            ),
    );
  }

  void _submitTicket() async {
    if (!_formKey.currentState!.validate()) return;
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Waiting for location...')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newTicket = Ticket(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        message: _messageController.text,
        type: _selectedTicketType,
        createdAt: DateTime.now(),
        latitude: _currentLocation!.latitude,
        longitude: _currentLocation!.longitude,
      );

      // TODO: Save ticket to storage/backend
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket created successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create ticket')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }
} 