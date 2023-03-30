import 'package:faker/faker.dart';

class ApiFactory {
  static Map makeExpense() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'description': faker.lorem.sentence(),
        'amount': faker.randomGenerator.decimal(),
        'date': faker.date.dateTime().toIso8601String(),
      };

  static List<Map> makeExpensesList() => [makeExpense(), makeExpense()];
}
