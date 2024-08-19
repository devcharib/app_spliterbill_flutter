import 'package:flutter/material.dart';
import 'package:flutter_app_splitthebill/models/person.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  List<Person> persons = [];

  void addPerson(String name) {
    persons.add(Person(name: name));
    notifyListeners();
  }

  //uma pessoa somente.
  void addValueToPerson(Person person, double value) {
    person.money += value;
    notifyListeners();
  }

  double sumSelectedValues(List<Person> selectedPersons) {
    return selectedPersons.fold(0.0, (sum, person) => sum + person.money);
  }

  void deleteSelectedPersons(List<Person> selectedPersons) {
    persons.removeWhere((person) => selectedPersons.contains(person));
    notifyListeners();
  }

  void increaseValueOfSelectedPersons(
      List<Person> selectedPersons, double amount) {
    for (var person in selectedPersons) {
      person.money += amount;
    }
    notifyListeners();
  }

  void decreaseValueOfSelectedPersons(
      List<Person> selectedPersons, double amount) {
    for (var person in selectedPersons) {
      person.money -= amount;
    }
    notifyListeners();
  }

  void resetValueOfSelectedPersons(List<Person> selectedPersons) {
    for (var person in selectedPersons) {
      person.money = 0.0;
    }
    notifyListeners();
  }

  void spliValueOfSelectedPersons(List<Person> selectedPersons, double value) {
    final split = value / selectedPersons.length;
    for (var person in selectedPersons) {
      person.money += split;
    }
    notifyListeners();
  }

  double sumList() {
    print(persons);
    return persons.fold(0.0, (sum, person) => sum + person.money);
  }

  String moneyPrint(double value) {
    final NumberFormat moneyPrint = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return moneyPrint.format(value);
  }

  void scaffoldMessage(String text, int sec, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: sec),
      ),
    );
  }
}
