import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formattedTimestamp(Timestamp timestamp) {
    DateTime dateTime =
    timestamp.toDate(); // Convert Firestore Timestamp to DateTime
    return DateFormat('h:mm a').format(dateTime); // Format DateTime object
  }
}