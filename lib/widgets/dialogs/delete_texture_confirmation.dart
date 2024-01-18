import 'package:chess_system_frontend/controller/texture_controller.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

Future<void> buildTextureRemovalDialog(BuildContext context, int? textureId) {
  SizeConfig().init(context);
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ar tikrai norite pašalinti šią tekstūrą?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Ištrinti',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              bool didDelete = await deleteTexture(textureId);
              if (didDelete) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Tekstūra pašalinta sėkmingai")));
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Serverio klaida.")));
              }
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Grįžti'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
