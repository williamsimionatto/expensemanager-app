import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.amountErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          key: const ValueKey('amountInput'),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            labelText: 'Amount',
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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: presenter.validateAmount,
        );
      },
    );
  }
}
