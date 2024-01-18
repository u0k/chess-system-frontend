import 'package:flutter/material.dart';


class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      scrolledUnderElevation: 0.0,
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.token,
            //color: const Color(0xffd1d0c5),
            size: 40,
          ),
          Text("ChessAnarchy",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'LexendDeca',
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
