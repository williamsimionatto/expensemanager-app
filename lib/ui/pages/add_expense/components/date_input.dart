import 'package:expensemanagerapp/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class DateInput extends StatefulWidget {
  const DateInput({
    Key? key,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _StartDateInputState();
}

class _StartDateInputState extends State<DateInput> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  Future<void> _selectDate(
    BuildContext context,
    AddExpensePresenter presenter,
  ) async {
    DateTime? newDate = await datePicker(
      context,
      presenter.selectedPeriod!.startDate,
      presenter.selectedPeriod!.endDate,
    );

    if (newDate == null) return;

    presenter.validateDate(newDate.toIso8601String());

    setState(() {
      dateInput.text = DateFormat('dd-MM-yyyy').format(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);
    return StreamBuilder<UIError?>(
      stream: presenter.dateErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          key: const ValueKey('dateInput'),
          controller: dateInput,
          decoration: InputDecoration(
            labelText: 'Date',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            errorText: snapshot.data?.description,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
              ),
            ),
          ),
          keyboardType: TextInputType.datetime,
          onTap: () => _selectDate(context, presenter),
        );
      },
    );
  }
}
