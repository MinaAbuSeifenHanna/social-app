  String formatPostTime(DateTime postTime) {
    Duration timeDifference = DateTime.now().difference(postTime);

    if (timeDifference.inDays > 30) {
      // More than 30 days, display in weeks
      int weeks = (timeDifference.inDays / 7).floor();
      return '$weeks w';
    } else if (timeDifference.inDays > 0) {
      // Between 1 day and 30 days, display in days
      return '${timeDifference.inDays} d';
    } else if (timeDifference.inHours >= 1) {
      // Between 1 hour and 24 hours, display in hours
      return '${timeDifference.inHours} h';
    } else if (timeDifference.inMinutes >= 1) {
      // Between 1 minute and 59 minutes, display in minutes
      return '${timeDifference.inMinutes} m';
    } else {
      // Less than 1 minute, display as "Just now"
      return 'Just now';
    }
  }
