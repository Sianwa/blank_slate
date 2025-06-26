import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter _mainRouter;

  AppRouter(){
    _mainRouter = GoRouter(
        initialLocation: "", //<---------------------TODO: Provide the apps starting point
        redirect: (ctx, state) {
          return null;
        },
        routes: [
          //TODO: List out your apps routes. For example....
          /**
           *  GoRoute(
              name: signIn,
              path: signInPath,
              pageBuilder: (context, state) => CustomTransitionPage(
              child: const SignInScreen(),
              transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) =>
              FadeTransition(opacity: animation,child: child),
              )),


              //route with params

              GoRoute(
              name: signIn,
              path: signInPath,
              pageBuilder: (context, state) => CustomTransitionPage(
              child: TransactionSummary(transactionType:state.uri.queryParameters['transactionType']!)
              transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) =>
              FadeTransition(opacity: animation,child: child),
              )),
           */
        ]
    );
  }
  GoRouter get mainRouter => _mainRouter;
}
/// Helper method that helps you:
/// know where the user is.
/// know whether you want to determine if the user is already on a specific page before navigating.
extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.path.toString();
    return location;
  }
}