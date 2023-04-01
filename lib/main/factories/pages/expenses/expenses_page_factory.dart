import 'package:flutter/material.dart';

import 'package:expensemanagerapp/main/factories/pages/expenses/expenses.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

Widget makeExpensesPage() => ExpensesPage(makeGetxExpensesPresenter());
