import 'package:flutter/cupertino.dart';

class DeleteConfirmationDialogIOS extends StatefulWidget {
  const DeleteConfirmationDialogIOS({Key? key}) : super(key: key);

  @override
  State<DeleteConfirmationDialogIOS> createState() =>
      _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState
    extends State<DeleteConfirmationDialogIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Are you sure you want to delete?'),
      content: const Text('This action cannot be undone.'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(false); // return false on cancel
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF007AFF)),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop(true); // return true on delete
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
