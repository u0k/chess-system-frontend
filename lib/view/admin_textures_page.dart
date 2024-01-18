import 'package:chess_system_frontend/widgets/textures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/admin_controller.dart';
import '../model/admin.dart';
import '../utils/size_config.dart';

class AdminTexturesPage extends StatefulWidget {
  const AdminTexturesPage({super.key, required this.title});

  final String title;

  @override
  State<AdminTexturesPage> createState() => _AdminTexturesPageState();
}

class _AdminTexturesPageState extends State<AdminTexturesPage> {
  late Future<Admin> admin;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    admin = fetchAdmin();
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
                  child: FutureBuilder<Admin>(
                future: admin,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TextButton.icon(
                      onPressed: () async {
                        if (context.mounted) {}
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
      body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 1,
          child: NavigationRail(
            onDestinationSelected: (int index) {
              if (mounted) {
                setState(() {
                  _selectedIndex = index;
                });
              }
              if (index == 0) {context.go('/admin-dashboard');}
              if (index == 1) {context.go('/admin-dashboard/userlist');}
              if (index == 2) {context.go('/admin-dashboard/textures');}
            },
            destinations: [
              NavigationRailDestination(
                  icon: const Icon(Icons.newspaper),
                  label: Text('Informacija',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeSIZE! * 0.4))),
              NavigationRailDestination(
                  icon: const Icon(Icons.supervised_user_circle),
                  label: Text('Vartotojų sąrašas',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeSIZE! * 0.4))),
              NavigationRailDestination(
                  icon: const Icon(Icons.backpack),
                  label: Text('Tekstūros',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeSIZE! * 0.4))),
            ],
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
          ),
        ),
        const Expanded(flex: 9, child: Center(child: CardTextureList())),
      ]),
    );
  }
}
