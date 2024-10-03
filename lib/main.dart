import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/blocs/search/bloc/search_bloc.dart';
import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioClient.instance.initialize();
  SharedPref.instance.initSharedPreferences();
  await HiveHelper().initHive();
  await HiveHelper().storeFavouritesFromBackend();
  Hive.initFlutter();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthenticationBloc(),
      ),
      BlocProvider(
          create: (context) => EventBloc()..add(FetchEventLocations())),
      BlocProvider(
        create: (context) => SearchBloc(),
      ),
      BlocProvider(
        create: (context) => FavouritesBloc(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Appthemes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
