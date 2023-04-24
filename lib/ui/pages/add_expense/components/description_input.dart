import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.descriptionErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          key: const ValueKey('descriptionInput'),
          decoration: InputDecoration(
            labelText: 'Description',
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
          keyboardType: TextInputType.name,
          onChanged: presenter.validateDescription,
        );
      },
    );
  }
}
