import 'package:get/get.dart';
import 'package:location_agent/presentation/screens/home/home_screen.dart';
import 'package:location_agent/presentation/screens/login/login_screen.dart';
import 'package:location_agent/presentation/screens/signup/signup-step1.dart';
import 'package:location_agent/presentation/screens/signup/signup-step2.dart';
import 'package:location_agent/presentation/screens/signup/signup-step3.dart';
import 'package:location_agent/presentation/screens/signup/signup.dart';
import 'package:location_agent/refreshCheck.dart';
import 'package:location_agent/routestack.dart';
import 'package:location_agent/routestackagent.dart';
import 'package:location_agent/splashscreen.dart';
import 'package:location_agent/version.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.cupertino),
         GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/routestack',
         page: () => const RouteStack(),
        transition: Transition.cupertino),
         GetPage(
        name: '/routestackAgent',
         page: () => const RouteStackAgent(),
        transition: Transition.cupertino),
    GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep1',
        page: () => const SignupStep1(),
        transition: Transition.cupertino),
    GetPage(
        name: '/version',
        page: () => const VersionScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/refresh',
        page: () => const RefreshCheck(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep3',
        page: () => SignupStep3(backNavigation: false,),
        transition: Transition.cupertino),
    GetPage(
        name: '/signupStep2',
        page: () => const SignupStep2(),
        transition: Transition.cupertino),
    GetPage(
        name: '/signup',
        page: () => Signup(backNavigation: true,),
        transition: Transition.cupertino),

  
  ];
}
