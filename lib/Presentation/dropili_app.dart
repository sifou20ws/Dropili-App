import 'dart:developer';

import 'package:dropili/Presentation/routing/fade_page_route_builder.dart';
import 'package:dropili/Presentation/localization/app_localization.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/Presentation/routing/routes.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DropiliApp extends StatefulWidget {
  const DropiliApp({Key? key}) : super(key: key);

  @override
  State<DropiliApp> createState() => _DropiliAppState();
}

class _DropiliAppState extends State<DropiliApp> {
  late LanguageBloc _languageBloc;
  late String intiRoute = '/';

  static const platform = const MethodChannel('http.dropili.co/channel');

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstace<LanguageBloc>();

    // log(startUri().toString());
  }

  @override
  void dispose() {
    super.dispose();
    _languageBloc.close();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _languageBloc),
        // BlocProvider.value(value: _intentBloc),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return state is LanguageLoaded
              ? MaterialApp(
                  title: 'Dropili',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      primaryColor: Colors.blue, fontFamily: 'Roboto'),
                  supportedLocales:
                      Languages.languages.map((e) => Locale(e.code)).toList(),
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  locale: state.locale,
                  builder: (context, child) {
                    return child!;
                  },
                  initialRoute: intiRoute,
                  onGenerateRoute: (settings) {
                    final routes = Routes.getRoutes(settings);
                    final WidgetBuilder builder = routes[settings.name]!;
                    return FadePageRouteBuilder(
                        builder: builder, settings: settings);
                  },
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
