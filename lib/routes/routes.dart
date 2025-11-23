import 'package:bandora_app/logic/bindings/initial_binding.dart';
import 'package:bandora_app/view/screen/Auth/signup_screen.dart';
import 'package:bandora_app/view/screen/bandora_product_screen.dart';
import 'package:bandora_app/view/screen/splash/language_onboarding.dart';
import 'package:bandora_app/view/screen/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../logic/bindings/cart_binding.dart';
import '../logic/bindings/main_binding.dart';
import '../view/brand_product_screen.dart';
import '../view/screen/Auth/signin_screen.dart';
import '../view/screen/checkout_details_screen.dart';
import '../view/screen/featured_product.dart';
import '../view/screen/main/cart_screen.dart';
import '../view/screen/main_screen.dart';
import '../view/screen/offer_product_screen.dart';
import '../view/screen/product_screen.dart';
import '../view/screen/prouct_details_screen.dart';
import '../view/screen/setting/add_location_screen.dart';
import '../view/screen/setting/connect_us_screen.dart';
import '../view/screen/setting/message_screen.dart';

class AppRoutes {
  //initialRoute
  static const splash = Routes.splashScreen;
  //getPages
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: InitialBindings(),
    ),
    // GetPage(
    //   name: Routes.languageOnboarding,
    //   page: () => LanguageOnboarding(),
    // ),
    GetPage(
      name: Routes.signupScreen,
      page: () => SignupScreen(),
    ),
    // GetPage(
    //   name: Routes.VerificationScreen,
    //   page: () => VerificationScreen(),
    // ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.productScreen,
      page: () => const ProductScreen(),
    ),
    GetPage(
      name: Routes.connectUsScreen,
      page: () => ConnectUsScreen(),
    ),
    GetPage(
      name: Routes.messageScreen,
      page: () => MessageScreen(),
    ),

    GetPage(
      name: Routes.bandoraProductScreen,
      page: () => BandoraProductScreen(),
    ),
    GetPage(
      name: Routes.offerProductScreen,
      page: () => OfferProductScreen(),
    ),
    GetPage(
      name: Routes.featuredProductScreen,
      page: () => FeaturedProductScreen(),
    ),
    GetPage(
      name: Routes.productDetailsScreen,
      page: () => ProductDetailsScreen(),
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => CartScreen(),
      binding: CartBinding(),
    ),

    GetPage(
      name: Routes.addLocationScreen,
      page: () => AddLocationScreen(),
    ),
    GetPage(
      name: Routes.brandProductScreen,
      page: () => BrandProductScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.checkOutDetailsScreen,
      page: () => CheckOutDetailsScreen(),
    ),
  ];
}

class Routes {
  static const splashScreen = '/SplashScreen';
  static const languageOnboarding = '/LanguageOnboarding';
  static const signupScreen = '/SignupScreen';
  static const verificationScreen = '/VerificationScreen';
  static const mainScreen = '/MainScreen';
  static const productScreen = '/ProductScreen';
  static const connectUsScreen = '/ConnectUsScreen';
  static const messageScreen = '/MessageScreen';
  static const bandoraProductScreen = '/BandoraProductScreen';
  static const offerProductScreen = '/OfferProductScreen';
  static const featuredProductScreen = '/FeaturedProductScreen';
  static const productDetailsScreen = '/ProductDetailsScreen';
  static const cartScreen = '/CartScreen';
  static const addLocationScreen = '/AddLocationScreen';
  static const brandProductScreen = '/BrandProductScreen';
  static const signInScreen = '/SignInScreen';
  static const checkOutDetailsScreen = '/CheckOutDetailsScreen';
}
