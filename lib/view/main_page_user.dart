import 'package:chess_system_frontend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';
import '../utils/size_config.dart';

class MainPageUser extends StatefulWidget {
  const MainPageUser({super.key, required this.title});

  final String title;

  @override
  State<MainPageUser> createState() => _MainPageUserState();
}

class _MainPageUserState extends State<MainPageUser> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Icon(
                Icons.token,
                //color: const Color(0xffd1d0c5),
                size: 40, //40,
              ),
            ),
            Flexible(
              child: Text(widget.title,
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'LexendDeca',
                  )),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TextButton.icon(
                      onPressed: () async {
                        if (context.mounted) {
                          context.go("/profile");
                        }
                      },
                      icon: const Flexible(
                        child: Icon(
                          Icons.man_2_outlined,
                          size: 25,
                        ),
                      ),
                      label: Text(
                        snapshot.data!.username!,
                        style: const TextStyle(fontSize: 25),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )),
              Flexible(
                child: TextButton.icon(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    if (context.mounted) {
                      context.go("/");
                    }
                  },
                  icon: const Flexible(
                    child: Icon(
                      Icons.lock,
                      size: 25,
                    ),
                  ),
                  label: const Text(
                    'Atsijungti',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 40,
                  height: SizeConfig.blockSizeVertical! * 40,
                  child: Card(
                      margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Žaidimas prieš draugą",
                            style: TextStyle(fontSize: 25),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Pradėti",
                                  style: TextStyle(fontSize: 25)))
                        ],
                      ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 40,
                  height: SizeConfig.blockSizeVertical! * 40,
                  child: Card(
                      margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Žaidimas prieš kitą žaidėją (nereitinguotas)",
                            style: TextStyle(fontSize: 25),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Pradėti",
                                  style: TextStyle(fontSize: 25)))
                        ],
                      ))),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 40,
                  height: SizeConfig.blockSizeVertical! * 40,
                  child: Card(
                      margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Žaidimas prieš kitą žaidėją (reitinguotas)",
                            style: TextStyle(fontSize: 25),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Pradėti",
                                  style: TextStyle(fontSize: 25)))
                        ],
                      ))),
            ],
          ),
        ],
      ),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [VerticalDivider(), VerticalDivider()],
      // ),
      bottomSheet:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [
        Text("Pagrindinis", style: TextStyle(fontSize: 20)),
        Text("Komanda", style: TextStyle(fontSize: 20)),
        Text("Taisyklės", style: TextStyle(fontSize: 20)),
        Text("Reitingavimo sistema", style: TextStyle(fontSize: 20))
      ]),
    );
  }
}
