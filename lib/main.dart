import 'package:chess_system_frontend/view/main_page_admin.dart';
import 'package:chess_system_frontend/view/main_page_user.dart';
import 'package:chess_system_frontend/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'view/admin_login_page.dart';
import 'view/admin_textures_page.dart';
import 'view/admin_userlist_page.dart';
import 'view/login_page.dart';
import 'view/main_page_guest.dart';
import 'view/register_page.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(title: "ChessAnarchy"),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const MainPageUser(title: 'ChessAnarchy'),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const UserProfilePage(title: 'ChessAnarchy'),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/ca-admin',
      builder: (context, state) => const AdminLoginPage(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      builder: (context, state) => const MainPageAdmin(title: 'ChessAnarchy'),
    ),
    GoRoute(
      path: '/admin-dashboard/userlist',
      builder: (context, state) => const AdminUserListPage(title: 'ChessAnarchy'),
    ),
    GoRoute(
      path: '/admin-dashboard/textures',
      builder: (context, state) => const AdminTexturesPage(title: 'ChessAnarchy'),
    ),

  ],
  redirect: (BuildContext context, GoRouterState state) async {
    return null;
  
    // TODO: auth, jwt etc..
    // int authFuture = await checkAuth();
    // if ((authFuture == 1 &&
    //     state.location != '/eventsettings' &&
    //     state.location != '/events' &&
    //     state.location != '/eventreport' &&
    //     state.location != '/news' &&
    //     state.location != '/map' &&
    //     state.location != '/livemap' &&
    //     state.location != '/eventcreation')) {
    //   return '/dashboard';
    // } else if (authFuture == 2 && state.location != '/eventcreation') {
    //   return '/events';
    // } else if (authFuture == 3 && state.location != '/login') {
    //   return '/';
    // } else {
    //   return null;
    // }
  },
);

void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('lt', ''),
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'ChessAnarchy',
      theme: FlexThemeData.light(
        scheme: FlexScheme.bigStone,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.bigStone,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
    );
  }
}
