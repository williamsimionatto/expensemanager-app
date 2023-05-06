import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../../helpers/helpers.dart';

class PeriodInput extends StatefulWidget {
  static String selectedPeriod = '';

  const PeriodInput({Key? key}) : super(key: key);

  @override
  State<PeriodInput> createState() => _PeriodInputState();
}

class _PeriodInputState extends State<PeriodInput> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.periodErrorStream,
      builder: (context, snapshot) {
        return DropdownButtonFormField<String>(
          key: const Key('periodInput'),
          decoration: InputDecoration(
            labelText: 'Period',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            errorText: snapshot.data?.description,
            border: const OutlineInputBorder(),
          ),
          isDense: true,
          value: PeriodInput.selectedPeriod.isEmpty
              ? null
              : PeriodInput.selectedPeriod,
          hint: const Text(
            'Select a period',
          ),
          onChanged: (val) {
            PeriodInput.selectedPeriod = val!;
            presenter.validatePeriod(val);
          },
          items: presenter.getPeriods().map((profile) {
            return DropdownMenuItem<String>(
              value: profile['id'].toString(),
              child: Text(profile['name']),
            );
          }).toList(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    PeriodInput.selectedPeriod = '';
    super.dispose();
  }
}
