import 'shared/cubits/cubit/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'shared/cubits/cubit/user_info_cubit.dart';
import 'shared/models/user.dart';
import 'utils/themes.dart';
import 'shared/models/product.dart';
import 'utils/router/app_router.dart';
import 'utils/service_locator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<Product>("product_box");
  await Hive.openBox<User>("user_box");
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => UserInfoCubit(),
      child: const MyApp(),
    ),
  );

  SystemChrome.setSystemUIChangeCallback(
      (systemOverlaysAreVisible) => Future.delayed(
            const Duration(seconds: 4),
            () => SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: [SystemUiOverlay.top],
            ),
          ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
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

  @override
  Widget build(BuildContext context) {
    //Hive.box<User>("user_box").clear();
    bool userSelectedTheme = BlocProvider.of<UserInfoCubit>(context).userTheme;

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
        onGenerateRoute: _appRouter.generateRoute,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: userSelectedTheme ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}
