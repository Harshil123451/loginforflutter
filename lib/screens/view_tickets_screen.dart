import 'package:flutter/material.dart';
import '../models/ticket.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';

class ViewTicketsScreen extends StatefulWidget {
  const ViewTicketsScreen({Key? key}) : super(key: key);

  @override
  State<ViewTicketsScreen> createState() => _ViewTicketsScreenState();
}

class _ViewTicketsScreenState extends State<ViewTicketsScreen> {
  List<Ticket> _tickets = [];
  List<Ticket> _filteredTickets = [];
  bool _isLoading = true;
  String? _selectedType;

  final List<String> _ticketTypes = [
    'All Tickets',
    'Bug Report',
    'Feature Request',
    'Technical Issue',
    'General Inquiry',
    'Emergency',
  ];

  final List<String> _statusOptions = [
    'Open',
    'In Progress',
    'Resolved',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  void _filterTickets(String? type) {
    setState(() {
      _selectedType = type;
      if (type == null || type == 'All Tickets') {
        _filteredTickets = _tickets;
      } else {
        _filteredTickets = _tickets.where((ticket) => ticket.type == type).toList();
      }
    });
  }

  Widget _buildTypeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _selectedType ?? 'All Tickets',
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: const Icon(Icons.filter_list),
        ),
        items: _ticketTypes.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: _filterTickets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewTickets),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildTypeFilter(),
                Expanded(
                  child: _filteredTickets.isEmpty
                      ? _buildEmptyState()
                      : _buildTicketsList(),
                ),
              ],
            ),
    );
  }

  Future<void> _loadTickets() async {
    // TODO: Replace with actual data loading
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _tickets = [
        Ticket(
          id: '1',
          title: 'Sample Ticket',
          message: 'This is a sample ticket message',
          type: 'General Inquiry',
          createdAt: DateTime.now(),
          latitude: 0,
          longitude: 0,
        ),
        Ticket(
          id: '2',
          title: 'Bug Report',
          message: 'Found a critical bug',
          type: 'Bug Report',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          latitude: 0,
          longitude: 0,
        ),
        Ticket(
          id: '3',
          title: 'Emergency Issue',
          message: 'Urgent attention needed',
          type: 'Emergency',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          latitude: 0,
          longitude: 0,
        ),
      ];
      _filteredTickets = _tickets;
      _isLoading = false;
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).noTicketsYet,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).createTicket,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/create-ticket'),
            child: const Text('Create Ticket'),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = _filteredTickets[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              children: [
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                _buildStatusChip(ticket.status),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ticket.type,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(ticket.message),
                const SizedBox(height: 8),
                Text(
                  'Created: ${_formatDate(ticket.createdAt)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            onTap: () => _showTicketDetails(ticket),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'open':
        color = Colors.blue;
        break;
      case 'in progress':
        color = Colors.orange;
        break;
      case 'resolved':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _launchGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _showTicketDetails(Ticket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            ticket.type,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(ticket.status),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Created on ${_formatDate(ticket.createdAt)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              _buildTicketActions(ticket),
              const Divider(height: 32),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(ticket.message),
              const SizedBox(height: 24),
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lat: ${ticket.latitude.toStringAsFixed(6)}\nLng: ${ticket.longitude.toStringAsFixed(6)}',
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          center: LatLng(ticket.latitude, ticket.longitude),
                          zoom: 15,
                          maxZoom: 18,
                          interactiveFlags: InteractiveFlag.none,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(ticket.latitude, ticket.longitude),
                                builder: (context) => const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _launchGoogleMaps(
                              ticket.latitude,
                              ticket.longitude,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.map, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Open in Maps',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketActions(Ticket ticket) {
    final bool isAssignedToMe = ticket.assignedTo == 'currentUserId'; // Replace with actual user ID
    final bool canTakeTicket = ticket.status == 'Open' && ticket.assignedTo == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: canTakeTicket ? () => _assignTicket(ticket) : null,
                icon: const Icon(Icons.assignment_ind),
                label: Text(isAssignedToMe ? 'Assigned to You' : 'Take Ticket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAssignedToMe ? Colors.green : null,
                ),
              ),
            ),
            if (isAssignedToMe) ...[
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (String newStatus) => _updateTicketStatus(ticket, newStatus),
                itemBuilder: (BuildContext context) {
                  return _statusOptions.map((String status) {
                    return PopupMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Update Status',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        if (isAssignedToMe) ...[
          const SizedBox(height: 16),
          Text(
            'Current Status: ${ticket.status}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  void _assignTicket(Ticket ticket) async {
    // TODO: Replace with actual user ID and backend call
    setState(() {
      ticket.assignTo('currentUserId');
    });
    Navigator.pop(context); // Close bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket assigned to you')),
    );
  }

  void _updateTicketStatus(Ticket ticket, String newStatus) {
    // TODO: Add backend call
    setState(() {
      ticket.updateStatus(newStatus);
    });
    Navigator.pop(context); // Close bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket status updated to $newStatus')),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
} 