extension DateExtension on DateTime{
  String convertToDDMMAAAA() {
    String dayString = day.toString();

    String monthString = month.toString();

    if(day < 10){
      dayString = day.toString().padLeft(2 , '0');
    }

    if(month < 10) {
      monthString = month.toString().padLeft(2 , '0');

    }
    return '$dayString/$monthString/$year';
  }
}