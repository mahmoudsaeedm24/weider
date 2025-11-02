import 'package:intl/intl.dart';

String dayAndMonth(DateTime fullDateTime) {
  return DateFormat('yy-MM-dd').format(fullDateTime);

  // return fullDateTime.toString().split(' ')[0].split('-').skip(1).join('-');
  // return fullDateTime.toString().split(' ')[0];
}
