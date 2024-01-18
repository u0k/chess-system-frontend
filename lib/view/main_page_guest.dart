import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/size_config.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
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
                child: TextButton.icon(
                  onPressed: () {
                    context.go("/register");
                  },
                  icon: const Flexible(
                    child: Icon(
                      Icons.door_sliding_outlined,
                      size: 25,
                    ),
                  ),
                  label: const Text(
                    'Registruotis',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Flexible(
                child: TextButton.icon(
                  onPressed: () {
                    context.go("/login");
                  },
                  icon: const Flexible(
                    child: Icon(
                      Icons.lock,
                      size: 25,
                    ),
                  ),
                  label: const Text(
                    'Prisijungti',
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
            mainAxisAlignment: MainAxisAlignment.center,
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
