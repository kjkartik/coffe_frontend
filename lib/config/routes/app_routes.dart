import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:coffee_app_bloc/view/auth/login.dart';
import 'package:coffee_app_bloc/view/itemDetail/item_detail_view.dart';
import 'package:coffee_app_bloc/view/onBoarding/onBaording.dart';
import 'package:coffee_app_bloc/view/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../view/admin/login/login_view.dart';
import '../../view/bottombar/bottom_bar.dart';
import '../../view/cart/cart_view.dart';
import '../../view/home/home_view.dart';

class AppRoutes {
  static Route<dynamic> generatesRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutesName.splash:
        return _animatedRoute(const SplashView());

      case AppRoutesName.onBoarding:
        return _animatedRoute(const OnBoardingView());
      case AppRoutesName.homeView:
        return _animatedRoute(const HomeView());
      case AppRoutesName.bottomBar:
        return _animatedRoute(const BottomBar());
        case AppRoutesName.itemDetailView:
        return _animatedRoute(  ItemDetailView(data: args,));
        case AppRoutesName.cartView:
        return _animatedRoute(  CartView());
        case AppRoutesName.login:
        return _animatedRoute(  LoginScreen());
      case AppRoutesName.adminLogin:
        return _animatedRoute( AdminLoginScreen() );



      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No Routes Defined"),
            ),
          ),
        );
    }
  }

  // Helper function to apply custom animations
  static PageRouteBuilder _animatedRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Slide in from bottom
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
