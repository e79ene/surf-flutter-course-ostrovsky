import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/bloc/favorite_list_bloc.dart';
import 'package:places/data/bloc/visited_list_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/theme_interactor.dart';
import 'package:places/data/redux/my_state.dart';
import 'package:places/data/redux/my_store.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/store/place_store.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaceRepository>(
          create: (_) => PlaceRepository(),
        ),
        BlocProvider(
          create: (_) => FavoriteListBloc(),
        ),
        BlocProvider(
          create: (_) => VisitedListBloc(),
        ),
        Provider<PlaceStore>(
          create: (context) => PlaceStore(context.read<PlaceRepository>()),
        ),
        ChangeNotifierProvider<PlaceInteractor>(
          create: (context) => PlaceInteractor(context.read<PlaceRepository>()),
        ),
        Provider<MyReduxStore>(
          create: (context) => MyReduxStore(
            context.read<PlaceRepository>(),
            context.read<PlaceStore>(),
          ),
        ),
        ChangeNotifierProvider<ThemeInteractor>(
          create: (_) => ThemeInteractor(),
        ),
      ],
      child: Consumer2<ThemeInteractor, MyReduxStore>(
        builder: (_, themeInteractor, myReduxStore, child) =>
            StoreProvider<MyState>(
          store: myReduxStore,
          child: MaterialApp(
            title: 'Интересные места',
            theme: themeInteractor.theme,
            home: child,
          ),
        ),
        child: col([
          row([search]),
        ]),
      ),
    );
  }

  static Widget dark(child) => Theme(data: Themes.dark, child: child);
  static Widget row(Iterable<Widget> children) =>
      Row(children: [for (final c in children) Expanded(child: c)]);
  static Widget col(Iterable<Widget> children) =>
      Column(children: [for (final c in children) Expanded(child: c)]);

  final add = AddSightScreen(),
      filters = FiltersScreen(),
      list = SightListScreen(),
      onboarding = OnboardingScreen(),
      search = SightSearchScreen(),
      settings = SettingsScreen(),
      splash = SplashScreen(),
      visiting = VisitingScreen();

  // Эти переменные используются для отладки тем и верстки.
  // А когда не используются, то пусть линтер не ругается.
  // ignore: unused_local_variable
  final dontWarn = [dark, row, col];
}
