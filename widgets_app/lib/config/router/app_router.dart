import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: '/buttons',
    name: ButtonsScreen.name,
    builder: (context, state) => ButtonsScreen(),
  ),
  GoRoute(
    path: '/cards',
    name: CardsScreen.name,
    builder: (context, state) => CardsScreen(),
  ),
]);
