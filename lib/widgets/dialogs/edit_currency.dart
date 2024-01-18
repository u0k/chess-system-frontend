import 'package:chess_system_frontend/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../model/user.dart';
import '../../utils/size_config.dart';

Future<void> buildCurrencyDialog(
    BuildContext context, TextEditingController currencyController, int? usrId) {
  SizeConfig().init(context);
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Valiutos redagavimas'),
        content: SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 20,
            height: SizeConfig.blockSizeVertical! * 20,
            child: Column(
              children: [
                SizedBox(
                  child: TextField(
                    controller: currencyController,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                    ],
                    decoration: const InputDecoration(
                        counterText: "",
                        labelText: 'Dabartinė vartotojo valiuta'),
                  ),
                )
              ],
            )),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Redaguoti', style: TextStyle(color: Colors.green),),
            onPressed: () async {
              User updatedCurrency = User(id: usrId, currency: int.parse(currencyController.text));
              bool didUpdate = await updateCurrency(updatedCurrency);
              if (didUpdate) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text("Valiuta pakeista sėkmingai.")));
                
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
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
