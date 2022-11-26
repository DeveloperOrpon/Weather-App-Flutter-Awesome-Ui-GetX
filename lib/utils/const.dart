import 'package:intl/intl.dart';

const String weatherApiKey = '51280da195829b414dbe4394596ba4f0';
const String metric = 'metric';
const String imperial = 'imperial';
const String celsius = 'C';
const String fahrenheit = 'F';
const String degree = '\u00B0';

String getFormattedDate(num dt, {String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern)
        .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000));

String getFormattedDateForCard(num dt) => DateFormat.yMMMMEEEEd()
    .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000));

const cities = [
  "Bursa",
  "Cali",
  "DELHI",
  "Hong Kong",
  "Hyderabad",
  "Karachi",
  "Kolkata",
  "Lahore",
  "MEXICO CITY",
  "New York City",
  "TOKYO",
  "Mexico City",
  "Chittagong",
  'Athens',
  'Barishal',
  'Bangalore',
  'Berlin',
  'Capetown',
  'Dhaka',
  'Doha',
  'Dublin',
  'Dubai',
  'Faridpur',
  'Gopalgonj',
  'Hobigonj',
  'Istanbul',
  'Jakarta',
  'Jamalpur',
  'Keranigonj',
  'Kualalampur',
  'London',
  'Milan',
  'Moscow',
  'New York',
  'Oslo',
  'Paris',
  'Riadh',
  'Rome',
  'Sydney',
  'Tongi',
];
