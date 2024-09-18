import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/router/app_router.dart';
import 'utils/router/router_paths.dart';
import 'utils/service_locator.dart';
import 'utils/themes.dart';
import 'firebase_options.dart';
import 'shared/cubits/cubit/user_info_cubit.dart';
import 'shared/cubits/cubit/user_info_state.dart';
import 'shared/models/product.dart';
import 'shared/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive and open required boxes
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>("user_box");
  await Hive.openBox<Product>("product_box");

  // Setup dependencies
  setupServiceLocator();

  // Start the app
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
  late final AppRouter _appRouter = AppRouter();

  String _initialPage = KRouter.authPage; // Default to authPage

  void _setInitialPage() {
    final userBox = Hive.box<User>("user_box");
    if (userBox.isNotEmpty) {
      setState(() {
        _initialPage =
            KRouter.mainNavigator; // Change initial page if user data exists
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool userSelectedTheme = BlocProvider.of<UserInfoCubit>(context).userTheme;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: userSelectedTheme
            ? const Color(0xffffffff)
            : const Color(0xFF1D182A),
      ),
    );

    return BlocListener<UserInfoCubit, UserInfoState>(
      listener: (context, state) {
        if (state is EditThemeUserInfo) {
          userSelectedTheme =
              !BlocProvider.of<UserInfoCubit>(context).userTheme;
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
        themeMode: userSelectedTheme ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}
