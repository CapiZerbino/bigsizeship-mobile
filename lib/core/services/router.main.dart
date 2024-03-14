part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (_) => BlocProvider<AuthenticationBloc>(
          create: (_) => locator<AuthenticationBloc>(),
          child: const LogInScreen(),
        ),
        settings: settings,
      );

    case LogInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider<AuthenticationBloc>(
          create: (_) => locator<AuthenticationBloc>(),
          child: const LogInScreen(),
        ),
        settings: settings,
      );
    case HomeScreen.routeName:
      return _pageBuilder(
        (_) => const HomeScreen(),
        settings: settings,
      );
    case ListOrderScreen.routeName:
      return _pageBuilder(
        (_) => const ListOrderScreen(),
        settings: settings,
      );
    case OrderDetailScreen.routeName:
      return _pageBuilder(
        (_) => const OrderDetailScreen(),
        settings: settings,
      );
    case CreateOrderScreen.routeName:
      return _pageBuilder(
        (_) => const CreateOrderScreen(),
        settings: settings,
      );
    case TrackingOrderScreen.routeName:
      return _pageBuilder(
        (_) => const TrackingOrderScreen(),
        settings: settings,
      );
    case DashboardScreen.routeName:
      return _pageBuilder(
        (_) => const DashboardScreen(),
        settings: settings,
      );
    case ListReconciliationScreen.routeName:
      return _pageBuilder(
        (_) => const ListReconciliationScreen(),
        settings: settings,
      );
    case ProfileScreen.routeName:
      return _pageBuilder(
        (_) => const ProfileScreen(),
        settings: settings,
      );
    case CreateAddressScreen.routeName:
      return _pageBuilder(
        (_) => const CreateAddressScreen(),
        settings: settings,
      );
    case ListAddressesScreen.routeName:
      return _pageBuilder(
        (_) => const ListAddressesScreen(),
        settings: settings,
      );
    case SelectAddressScreen.routeName:
      return _pageBuilder(
        (_) => const SelectAddressScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
