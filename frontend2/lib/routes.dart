import 'package:frontend2/main.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder:(context, state) => const MyApp()),
    //GoRoute(path: 'data', builder(context, state) =>)
  ]

);