import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chess_system_frontend/model/texture.dart';
import 'package:chess_system_frontend/widgets/dialogs/add_texture.dart';
import 'package:chess_system_frontend/widgets/dialogs/delete_texture_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../controller/texture_controller.dart';
import '../utils/size_config.dart';

class CardTextureList extends StatefulWidget {
  const CardTextureList({super.key});

  @override
  State<CardTextureList> createState() => _CardTextureListState();
}

class _CardTextureListState extends State<CardTextureList> {
  late Future<List<Texture_>> textureList;
  bool isLoading = false;
  bool didPay = false;
  bool isParticipate = false;
  bool didFinish = false;
  FilePickerResult? result;
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    textureList = fetchTextures();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 40,
      height: SizeConfig.blockSizeVertical! * 40,
      margin: EdgeInsets.all(SizeConfig.blockSizeSIZE! * 2),
      child: Card(
          child: FutureBuilder<List<Texture_>>(
        future: textureList,
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
                          "Tekstūrų sąrašas",
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
                          ExpansionTile(
                            title: Row(
                              children: [
                                snapshot.data![index].imageData![0] == 'P'
                                    ? SvgPicture.memory(
                                        base64Decode(
                                            snapshot.data![index].imageData!),
                                        width: 50,
                                        height: 50,
                                      )
                                    : Image.memory(
                                        base64Decode(
                                            snapshot.data![index].imageData!),
                                        width: 50,
                                        height: 50,
                                      ),
                                Text(snapshot.data![index].name!),
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
                                            "Ištrinti tekstūrą",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () async {
                                            int? textureId =
                                                snapshot.data![index].id;
                                            buildTextureRemovalDialog(
                                                    context, textureId)
                                                .then((_) => setState(
                                                      () {
                                                        textureList =
                                                            fetchTextures();
                                                      },
                                                    ));
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
                  const Divider(),
                  TextButton(
                    child: const Text("Pridėti tekstūrą"),
                    onPressed: () {
                      buildTextureAddDialog(
                              context, result, nameController, _formKey)
                          .then((_) => setState(
                                () {
                                  textureList = fetchTextures();
                                },
                              ));
                    },
                  )
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
