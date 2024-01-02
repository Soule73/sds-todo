import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime) {
  // d : jour du mois (1-31)
  // MMM : nom abrégé du mois (Jan, Feb, etc.)
  // yyyy : année à quatre chiffres (2023, 2024, etc.)
  // HH : heure
  // munite
  DateFormat format = DateFormat("d MMM yyyy à HH:mm");

  // Formater l'objet DateTime avec l'objet DateFormat
  String formattedDate = format.format(dateTime);

  return formattedDate;
}

int compareTwoDates(DateTime d1, DateTime d2) => d2.compareTo(d1);

int secondsBeetWeenToDays(DateTime d1, DateTime d2) {
  // Calculer la durée entre les deux dates avec la méthode difference
  Duration duree = d2.difference(d1);

  if (duree.inSeconds > 0) {
    // retourner le nombre des secondes dans la durée
    return duree.inSeconds;
  }
  return 0;
}

//
// progress%=(total secondes entre startAt-now/total secondes entre startAt-endAt)
//
double progressTodo(DateTime d1, DateTime d2) {
  if (compareTwoDates(d1, d2) > 0 && compareTwoDates(d1, DateTime.now()) >= 0) {
    int days = secondsBeetWeenToDays(d1, d2);
    int daysFromNow = secondsBeetWeenToDays(d1, DateTime.now());

    double progress = double.parse((daysFromNow / days).toStringAsFixed(2));

    return progress;
  }
  return 0.0;
}
