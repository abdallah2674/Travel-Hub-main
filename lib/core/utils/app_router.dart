import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/data/cubits/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'package:travel_hub/data/cubits/hotels_cubit/hotels_cubit.dart';
import 'package:travel_hub/data/cubits/land_mark_cubit/cubit/land_mark_cubit.dart';
import 'package:travel_hub/features/auth/login/presentation/views/login_screen.dart';
import 'package:travel_hub/features/home/home_screen.dart';
import 'package:travel_hub/features/hotels/booking/book_screen.dart';
import 'package:travel_hub/features/hotels/hotels_screen_details.dart';
import 'package:travel_hub/features/hotels/hotels_screen.dart';
import 'package:travel_hub/features/land_mark/land_mark_details_screen.dart';
import 'package:travel_hub/features/land_mark/land_mark_screen.dart';
import 'package:travel_hub/features/splash/splash_screen.dart';
import 'package:travel_hub/models/hotels_model.dart';
import 'package:travel_hub/models/land_mark_model.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kRegisterOneView = '/registerOneView';
  static const kRegisterTwoView = '/registerTwoView';
  static const kRegisterThreeView = '/registerThreeView';
  //Home Feature
  static const kHomeView = '/home';

  //Hotels Feature
  static const kHotelsView = '/hotels';
  static const kBookView = '/book';
  static const kHotelsDetailsView = '/details';

  //Land Mark Feature
  static const kLandMarkView = '/landMark';
  static const kLandMarkDetailsView = '/marksDetails';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      // GoRoute(
      //path: kRegisterOneView,
      // builder: (context, state) => const RegisterOneView(),
      //  ),

      //Home Feature
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: kHotelsView,
        builder: (context, state) => BlocProvider(
          create: (context) => HotelsCubit()..loadHotels(),
          child: const HotelsScreen(),
        ),
      ),
      GoRoute(
        path: kHotelsDetailsView,
        builder: (context, state) {
          final hotels = state.extra as Hotels;
          return HotelsScreenDetails(hotels);
        },
      ),
      GoRoute(
        path: kLandMarkView,
        builder: (context, state) => BlocProvider(
          create: (context) => LandMarkCubit()..loadLandMark(),
          child: const LandMarkScreen(),
        ),
      ),
      GoRoute(
        path: kLandMarkDetailsView,
        builder: (context, state) {
          final landMark = state.extra as LandMark;
          return BlocProvider(
            create: (context) => CarouselSliderCubit(),
            child: LandMarkDetailsScreen(landMark),
          );
        },
      ),
      GoRoute(path: kBookView, builder: (context, state) => const BookScreen()),
    ],
  );
}
