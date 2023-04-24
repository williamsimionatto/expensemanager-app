import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../../helpers/helpers.dart';

class CategoryInput extends StatefulWidget {
  static String selectedCategory = '';

  const CategoryInput({Key? key}) : super(key: key);

  @override
  State<CategoryInput> createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddExpensePresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.categoryErrorStream,
      builder: (context, snapshot) {
        return DropdownButtonFormField<String>(
          key: const Key('categoryInput'),
          decoration: InputDecoration(
            labelText: 'Category',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            errorText: snapshot.data?.description,
            border: const OutlineInputBorder(),
          ),
          isDense: true,
          value: CategoryInput.selectedCategory.isEmpty
              ? null
              : CategoryInput.selectedCategory,
          hint: const Text(
            'Select a category',
          ),
          onChanged: (val) {
            CategoryInput.selectedCategory = val!;
            presenter.validateCategory(val);
          },
          items: presenter.getCategories().map((profile) {
            return DropdownMenuItem<String>(
              value: profile['id'].toString(),
              child: Text(profile['name']),
            );
          }).toList(),
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}
