class UserStats {
  final int completedTasks;
  final int pendingTasks;
  final double rating;
  final int totalReviews;
  final String level;

  UserStats({
    required this.completedTasks,
    required this.pendingTasks,
    required this.rating,
    required this.totalReviews,
    required this.level,
  });

  // Helper method to determine level based on completed tasks
  static String calculateLevel(int completedTasks) {
    if (completedTasks >= 50) return 'Expert';
    if (completedTasks >= 25) return 'Senior';
    if (completedTasks >= 10) return 'Intermediate';
    return 'Beginner';
  }
} 