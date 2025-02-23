import 'package:intl/intl.dart';

class DateHelper {
 static DateTime stringToDate(String dateString){
    return DateTime.parse(dateString); 
  }

  static String dateTimeToString(DateTime dateTime){
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
    
  }

}