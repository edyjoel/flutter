import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => HomeScreen(),
  ),
  GoRoute(
    path: '/buttons',
    builder: (context, state) => ButtonsScreen(),
  ),
  GoRoute(
    path: '/cards',
    builder: (context, state) => CardsScreen(),
  ),
]);
