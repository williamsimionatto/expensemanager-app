import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class EntityFactory {
  static ExpenseEntity makeExpense() => ExpenseEntity(
        id: faker.randomGenerator.integer(10, min: 1),
        description: faker.lorem.sentence(),
        amount: faker.randomGenerator.decimal(min: 1),
        date: faker.date.dateTime().toIso8601String(),
      );

  static List<ExpenseEntity> makeExpenses() => [makeExpense(), makeExpense()];

  static PeriodEntity makePeriod() => PeriodEntity(
        id: faker.randomGenerator.integer(10, min: 1),
        name: faker.lorem.sentence(),
        startDate: faker.date.dateTime().toIso8601String(),
        endDate: faker.date.dateTime().toIso8601String(),
        budget: faker.randomGenerator.decimal(min: 1),
      );

  static List<PeriodEntity> makePeriods() => [makePeriod(), makePeriod()];
}
