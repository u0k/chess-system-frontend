import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/user_controller.dart';
import '../model/user.dart';
import '../utils/size_config.dart';
import '../widgets/login_app_bar.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static var usrId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode emailTextNode = FocusNode();
    SizeConfig().init(context);
    return Scaffold(
      appBar: const LoginAppBar(),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 5,
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  child: Text(
                    "Registracija",
                    style: TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 1.2),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.4,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  height: SizeConfig.safeBlockVertical! * 9,
                  child: TextFormField(
                    style: TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    focusNode: emailTextNode,
                    controller: emailController,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "El. paštas",
                      floatingLabelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                      labelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Trūksta duomenų';
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return 'Įveskite elektroninį paštą';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.4,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  height: SizeConfig.safeBlockVertical! * 9,
                  child: TextFormField(
                    style: TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    controller: usernameController,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Vartotojo vardas",
                      floatingLabelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                      labelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Trūksta duomenų';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.4,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  height: SizeConfig.safeBlockVertical! * 9,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                    style: TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Slaptažodis",
                      floatingLabelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                      labelStyle:
                          TextStyle(fontSize: SizeConfig.blockSizeSIZE! * 0.7),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Trūksta duomenų';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.4,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 25,
                  height: SizeConfig.safeBlockVertical! * 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator())),
                                  barrierDismissible: false);
                              User regUser = User(
                                  emailAddress: emailController.text,
                                  password: passwordController.text,
                                  username: usernameController.text);
                              bool didRegister = await registerUser(regUser);
                              if (didRegister) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text("Užsiregistruota sėkmingai. Prisijunkite.")));
                                            context.go('/');
                                }
                                
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                          content: Text(
                                              "Serverio klaida.")));
                                }
                                //todo errors(neteisingi duomenys, network error etc)
                              }
                            }
                          } catch (error) {}
                        },
                        icon: Icon(
                          Icons.check,
                          size: SizeConfig.blockSizeSIZE! * 1.07,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
