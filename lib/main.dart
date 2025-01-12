import 'package:coffee_app_bloc/blocs/auth_bloc.dart';
import 'package:coffee_app_bloc/config/routes/app_routes.dart';
import 'package:coffee_app_bloc/repostory/authRepo/auth_http_api_repository.dart';
import 'package:coffee_app_bloc/repostory/getItem/item_http_api_repository.dart';
import 'package:coffee_app_bloc/view/admin/login/login_view.dart';
import 'package:coffee_app_bloc/view/admin/upload_item.dart';
import 'package:coffee_app_bloc/view/fav/favourite.dart';
import 'package:coffee_app_bloc/view/notification/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/get_items.dart';
import 'config/routes/routes_name.dart';


void main() {
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthHttpApiRepository())),
        BlocProvider(create: (_) => ItemBloc(GetItemHttpApiRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Coffee',
      // home:AdminLoginScreen() ,
       initialRoute: AppRoutesName.splash,
        onGenerateRoute: AppRoutes.generatesRoutes,
      ),
    );
  }
}
