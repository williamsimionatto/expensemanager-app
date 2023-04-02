import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';

class ParamsFactory {
  static AddExpenseParams makeAddExpenseParams() => AddExpenseParams(
        description: faker.lorem.sentence(),
        amount: faker.randomGenerator.decimal(),
        date: '2021-01-01',
        categoryId: faker.randomGenerator.integer(100),
        periodId: faker.randomGenerator.integer(100),
      );
}
