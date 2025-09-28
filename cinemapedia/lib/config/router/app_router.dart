import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  // ShellRoute(
  //     builder: (context, state, child) {
  //       return HomeScreen();
  //     },
  //     routes: [
  //       GoRoute(
  //           path: '/',
  //           builder: (context, state) {
  //             return HomeView();
  //           },
  //           routes: [
  //             GoRoute(
  //               path: 'movie/:id',
  //               name: MovieScreen.name,
  //               builder: (context, state) {
  //                 final movieId = state.pathParameters['id'] ?? 'no-id';
  //                 return MovieScreen(movieId: movieId);
  //               },
  //             )
  //           ]),
  //       GoRoute(
  //           path: '/favorites',
  //           builder: (context, state) {
  //             return const FavoritesView();
  //           }),
  //     ])

  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex =
            int.tryParse(state.pathParameters['page'] ?? '0') ?? 0;
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        )
      ]),

  GoRoute(path: '/', redirect: (context, state) => '/home/0'),
]);
