import 'package:device_preview/device_preview.dart';
import 'package:evento_event_booking/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:evento_event_booking/blocs/category/bloc/category_bloc.dart';
import 'package:evento_event_booking/blocs/connectivity_cubit/cubit/connectivity_checker_cubit.dart';
import 'package:evento_event_booking/blocs/event/bloc/event_bloc.dart';
import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/blocs/profile/bloc/profile_bloc.dart';
import 'package:evento_event_booking/blocs/search/bloc/search_bloc.dart';
import 'package:evento_event_booking/blocs/share/share_bloc.dart';
import 'package:evento_event_booking/blocs/ticket_booking/bloc/ticket_booking_bloc.dart';
import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/data/network/dio_configure.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/appthemes.dart';
import 'package:evento_event_booking/view/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    logError('the error occured is ${e.toString()}');
  }
  DioClient.instance.initialize();
  SharedPref.instance.initSharedPreferences();
  await HiveHelper().initHive();
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
      ),
      BlocProvider(
        create: (context) => ShareBloc(),
      ),
      BlocProvider(
        create: (context) => TicketBookingBloc(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider(
        create: (context) => ConnectivityCheckerCubit()..trackConnectivityChange(),
      )
    ],
    child: DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: Appthemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      );
  }
}

