import 'package:flutter/material.dart';

class ReloadScreen extends StatelessWidget {
  final String error;
  final Future<void> Function() reload;

  const ReloadScreen({required this.error, required this.reload, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0XFFF64348);
                  } else if (states.contains(MaterialState.disabled)) {
                    return const Color(0XFFF64348);
                  } else {
                    return const Color(0XFFF64348);
                  }
                },
              ),
            ),
            onPressed: reload,
            child: const Text('Recarregar'),
          ),
        ],
      ),
    );
  }
}
