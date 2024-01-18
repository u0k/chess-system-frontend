import 'package:chess_system_frontend/widgets/dialogs/edit_currency.dart';
import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../model/user.dart';
import '../utils/size_config.dart';

class CardUserList extends StatefulWidget {
  const CardUserList({super.key});

  @override
  State<CardUserList> createState() => _CardUserListState();
}

class _CardUserListState extends State<CardUserList> {
  late Future<List<User>> userList;
  bool isLoading = false;
  bool didPay = false;
  bool isParticipate = false;
  bool didFinish = false;
  final TextEditingController currencyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userList = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 40,
      height: SizeConfig.blockSizeVertical! * 40,
      margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
      child: Card(
          child: FutureBuilder<List<User>>(
        future: userList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 1),
                        child: Text(
                          "Vartotojų sąrašas",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeSIZE! * 1),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // ListTile(
                          //   leading: Icon(Icons.donut_large),
                          //   title: Text(snapshot.data![index].name +
                          //       " " +
                          //       snapshot.data![index].surname),
                          // ),
                          ExpansionTile(
                            leading: const Icon(Icons.sports_motorsports),
                            title: Row(
                              children: [
                                Text("${snapshot.data![index].username}"),
                              ],
                            ),
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.blockSizeSIZE! * 0.5),
                                  child: Column(children: [
                                    const Divider(),
                                    Row(
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            "Redaguoti valiutą",
                                            style:
                                                TextStyle(color: Colors.amber),
                                          ),
                                          onPressed: () async {
                                            currencyController.text = snapshot
                                                .data![index].currency
                                                .toString();
                                            int? usrId =
                                                snapshot.data![index].id;
                                            buildCurrencyDialog(context,
                                                    currencyController, usrId)
                                                .then((_) => setState(
                                                      () {
                                                        userList = fetchUsers();
                                                      },
                                                    ));
                                            // if (didPay == false) {
                                            //   bool paid = await confirmPayment(
                                            //       snapshot.data![index].id);
                                            //   setState(() {
                                            //     didPay = paid;
                                            //     eventUsers = fetchUsers();
                                            //   });
                                            // } else {
                                            //   bool paid = await cancelPayment(
                                            //       snapshot.data![index].id);
                                            //   setState(() {
                                            //     didPay = paid;
                                            //     eventUsers = fetchUsers();
                                            //   });
                                            // }
                                          },
                                        ),
                                        const VerticalDivider(),
                                      ],
                                    ),
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [CircularProgressIndicator()],
            );
          }
        },
      )),
    );
  }
}
