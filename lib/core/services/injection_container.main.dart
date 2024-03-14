part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await _initOnboarding();
  await _initAuthentication();
  await _initOrder();
  await _initAddress();
  await _initCore();
}

Future<void> _initAuthentication() async {
  final prefs = await SharedPreferences.getInstance();
  locator
    ..registerFactory(() => AuthenticationBloc(login: locator()))
    // Use cases
    ..registerLazySingleton(() => Login(locator()))
    // Repositories
    ..registerLazySingleton<AuthenticationReposiroty>(
      () => AuthenticationRepositoryImplementation(locator()),
    )
    // Data sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImplementation(locator()),
    )
    ..registerLazySingleton(() => prefs);
}

Future<void> _initOrder() async {
  locator
    ..registerLazySingleton(() => OrderBloc(getListOrders: locator()))
    // Use cases
    ..registerLazySingleton(() => GetListOrders(locator()))
    // Repositories
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImplementation(locator()),
    )
    // Data sources
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => const OrderRemoteDataSourceImplementation(),
    );
}

Future<void> _initAddress() async {
  locator
    ..registerLazySingleton(
      () => AddressBloc(
        getListAddresses: locator(),
        getListProvinces: locator(),
        getListDistricts: locator(),
        getListWards: locator(),
        createAddress: locator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => GetListAddresses(locator()))
    ..registerLazySingleton(() => GetListProvinces(locator()))
    ..registerLazySingleton(() => GetListDistricts(locator()))
    ..registerLazySingleton(() => GetListWards(locator()))
    ..registerLazySingleton(() => CreateAddress(locator()))
    // Repositories
    ..registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImplementation(locator()),
    )

    // Data sources
    ..registerLazySingleton<AddressRemoteDataSource>(
      () => const AddressRemoteDataSourceImplementation(),
    );
}

Future<void> _initOnboarding() async {}
Future<void> _initCore() async {
  final client = Client();
  locator.registerLazySingleton(() => client);
  locator.registerSingleton(ApiRequest);
}
