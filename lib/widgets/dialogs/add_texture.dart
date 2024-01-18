import 'dart:convert';

import 'package:chess_system_frontend/controller/texture_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import '../../utils/size_config.dart';

Future<void> buildTextureAddDialog(
    BuildContext context,
    FilePickerResult? result,
    TextEditingController nameController,
    Key formKey) {
  SizeConfig().init(context);
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Tekstūros pridėjimas'),
        content: SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 20,
            height: SizeConfig.blockSizeVertical! * 20,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]'))
                    ],
                    controller: nameController,
                    decoration: const InputDecoration(
                        counterText: "", labelText: 'Tekstūros pavadinimas'),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'svg', 'jpeg'],
                    );
                  },
                  child: const Text("Pasirinkti failą"),
                ),
              ],
            )),
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Pridėti',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                if (result != null && result!.files.isNotEmpty && nameController.text.isNotEmpty) {
                  bool didSend = await addTexture(
                      base64Encode(result!.files.first.bytes as List<int>),
                      nameController.text);
                  if (didSend) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Tekstūra pridėta sėkmingai")));
                          nameController.clear();
                    } else {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Serverio klaida.")));
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Nepasirinktas failas, arba trūksta failo pavadinimo.")));
                }
              }),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Grįžti'),
            onPressed: () {
              Navigator.of(context).pop();
              nameController.clear();
            },
          ),
        ],
      );
    },
  );
}
