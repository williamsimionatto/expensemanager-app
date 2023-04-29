import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  const DeleteConfirmationDialog({Key? key}) : super(key: key);

  @override
  State<DeleteConfirmationDialog> createState() =>
      _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to delete?'),
      content: const Text('This action cannot be undone.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // return false on cancel
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // return true on delete
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
