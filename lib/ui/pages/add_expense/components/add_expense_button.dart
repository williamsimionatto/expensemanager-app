import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);

    return StreamBuilder<bool?>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).primaryColor;
                } else if (states.contains(MaterialState.disabled)) {
                  return Theme.of(context).primaryColor.withOpacity(0.5);
                } else {
                  return Theme.of(context).primaryColor;
                }
              },
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(double.maxFinite, 50),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          onPressed: snapshot.data == true ? presenter.add : null,
          child: const Text(
            'Add',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
