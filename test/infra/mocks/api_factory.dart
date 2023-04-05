import 'package:faker/faker.dart';

class ApiFactory {
  static Map makeInvalidList() => {'invalid_key': 'invalid_value'};

  static Map makeExpense() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'description': faker.lorem.sentence(),
        'amount': faker.randomGenerator.decimal(),
        'date': faker.date.dateTime().toIso8601String(),
      };

  static List<Map> makeExpensesList() => [makeExpense(), makeExpense()];

  static Map makePeriod() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'name': faker.lorem.sentence(),
        'startDate': faker.date.dateTime().toIso8601String(),
        'endDate': faker.date.dateTime().toIso8601String(),
        'budget': faker.randomGenerator.decimal(),
      };

  static List<Map> makePeriodsList() => [makePeriod(), makePeriod()];
}
