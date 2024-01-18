import 'package:chess_system_frontend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../controller/user_controller.dart';
import '../utils/size_config.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.title});

  final String title;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<User> user;
  int _selectedIndex = 0;
  int counter = 0;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = fetchUser();
    counter = 0;
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
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: NavigationRail(
              onDestinationSelected: (int index) {
                if (mounted) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
                if (index == 0) {
                  context.go('/profile');
                }
                if (index == 1) {
                  context.go('/profile');
                }
              },
              destinations: [
                NavigationRailDestination(
                    icon: const Icon(Icons.man),
                    label: Text('Profilis',
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
          Expanded(
            flex: 9,
            child: Form(
              key: _formKey,
              child: Center(
                child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 75,
                    height: SizeConfig.blockSizeVertical! * 75,
                    child: Card(
                        margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
                        child: FutureBuilder<User>(
                            future: user,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (counter <= 0) {
                                  usernameController.text =
                                      snapshot.data!.username!;
                                  emailController.text =
                                      snapshot.data!.emailAddress!;
                                  counter++;
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            25,
                                        height:
                                            SizeConfig.blockSizeVertical! * 9,
                                        child: const Center(
                                          child: Text(
                                            "Redaguoti profilį",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            25,
                                        height:
                                            SizeConfig.blockSizeVertical! * 9,
                                        child: Center(
                                          child: TextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[0-9a-zA-Z]")),
                                            ],
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.blockSizeSIZE! *
                                                        0.7),
                                            controller: usernameController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: "Vartotojo vardas",
                                              floatingLabelStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeSIZE! *
                                                      0.7),
                                              labelStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeSIZE! *
                                                      0.7),
                                            ),
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Trūksta duomenų';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            25,
                                        height:
                                            SizeConfig.blockSizeVertical! * 9,
                                        child: Center(
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.blockSizeSIZE! *
                                                        0.7),
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: "El. paštas",
                                              floatingLabelStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeSIZE! *
                                                      0.7),
                                              labelStyle: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeSIZE! *
                                                      0.7),
                                            ),
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Trūksta duomenų';
                                              }
                                              if (!value.contains("@") ||
                                                  !value.contains(".")) {
                                                return 'Įveskite elektroninį paštą';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal! *
                                            25,
                                        height:
                                            SizeConfig.blockSizeVertical! * 9,
                                        child: Center(
                                          child: SizedBox(
                                            width: SizeConfig
                                                    .blockSizeHorizontal! *
                                                25,
                                            height:
                                                SizeConfig.blockSizeVertical! *
                                                    9,
                                            child: TextButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  User updatedUser = User(
                                                      emailAddress:
                                                          emailController.text,
                                                      username:
                                                          usernameController
                                                              .text);
                                                  bool updated =
                                                      await updateProfile(
                                                          updatedUser);
                                                  if (updated) {
                                                    if (context.mounted) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content: Text(
                                                                  "Profilis redaguotas sėkmingai")));

                                                      context.go("/dashboard");
                                                    }
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                "IŠSAUGOTI",
                                                style: TextStyle(fontSize: 30),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
