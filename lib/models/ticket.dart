class Ticket {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime createdAt;
  final double latitude;
  final double longitude;
  String status;
  String? assignedTo;

  Ticket({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
    this.status = 'Open',
    this.assignedTo,
  });

  void assignTo(String userId) {
    assignedTo = userId;
    status = 'In Progress';
  }

  void updateStatus(String newStatus) {
    status = newStatus;
  }

  // Convert ticket to map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'assignedTo': assignedTo,
    };
  }

  // Create ticket from map
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      type: map['type'],
      createdAt: DateTime.parse(map['createdAt']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      status: map['status'],
      assignedTo: map['assignedTo'],
    );
  }
} 