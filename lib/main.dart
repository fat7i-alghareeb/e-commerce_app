import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/Features/authentication/data/domain/entity/user_entity.dart';
import 'utils/router/app_router.dart';
import 'utils/router/router_paths.dart';
import 'utils/service_locator.dart';
import 'utils/themes.dart';
import 'firebase_options.dart';
import 'shared/cubits/cubit/user_info_cubit.dart';
import 'shared/cubits/cubit/user_info_state.dart';
import 'shared/models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  await Hive.openBox<UserEntity>("user_box");
  await Hive.openBox<Product>("product_box");

  setupServiceLocator();

  runApp(
    BlocProvider(
      create: (context) => UserInfoCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  late String _initialPage;
  late bool isDarkTheme;
  void _setInitialValues() {
    final currentUser = FirebaseAuth.instance.currentUser;
    isDarkTheme = context.read<UserInfoCubit>().isDarkTheme;
    if (currentUser != null) {
      _initialPage = KRouter.mainNavigator;
    } else {
      _initialPage = KRouter.authPage;
    }
  }

  @override
  void initState() {
    super.initState();
    _setInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDarkTheme ? const Color(0xFF1D182A) : const Color(0xffffffff),
      ),
    );

    return BlocListener<UserInfoCubit, UserInfoState>(
      listener: (context, state) {
        if (state is EditThemeUserInfo) {
          isDarkTheme = context.read<UserInfoCubit>().isDarkTheme;
          setState(() {});
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store',
        initialRoute: _initialPage,
        onGenerateRoute: _appRouter.generateRoute,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
