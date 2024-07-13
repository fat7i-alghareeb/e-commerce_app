import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/utils/router/router_paths.dart';

import 'shared/cubits/cubit/user_info_cubit.dart';
import 'shared/cubits/cubit/user_info_state.dart';
import 'shared/models/product.dart';
import 'shared/models/user.dart';
import 'utils/router/app_router.dart';
import 'utils/service_locator.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserAdapter());
  //Hive.registerAdapter(ReviewAdapter());
  await Hive.openBox<User>("user_box");
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

  @override
  Widget build(BuildContext context) {
    //Hive.box<User>("user_box").clear();
    bool userSelectedTheme = BlocProvider.of<UserInfoCubit>(context).userTheme;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: userSelectedTheme
            ? const Color(0xffffffff)
            : const Color(0xff1b2026),
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
        initialRoute: Hive.box<User>("user_box").isEmpty
            ? KRouter.logInPage
            : KRouter.mainNavigator,
        onGenerateRoute: _appRouter.generateRoute,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: userSelectedTheme ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}
