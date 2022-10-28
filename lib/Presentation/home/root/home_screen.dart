import 'package:dropili/Presentation/Nfc/nfc_dialoge.dart';
import 'package:dropili/Presentation/home/navigation_bar/navigation_bar_widget.dart';
import 'package:dropili/Presentation/home/qr_page/qr_page.dart';
import 'package:dropili/Presentation/home/ProfilePage/screens/profileScreen_page.dart';
import 'package:dropili/Presentation/home/drawerPage/drawerPage.dart';
import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/Presentation/home/something/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:dropili/di/get_it.dart' as getIt;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NavigationBloc _navigationBloc;
  @override
  void initState() {
    super.initState();
    _navigationBloc = getIt.getItInstace<NavigationBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _navigationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _navigationBloc,
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) async {
          if (state.currentPage == Pages.scanner) {
            context.read<NavigationBloc>().add(NavigationEvent(0));
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              enableDrag: true,
              context: context,
              builder: (context) {
                return NfcScanWidget(
                  dataToTag: 'https://www.google.com',
                );
              },
            );
          }
        },
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                title: Center(
                  child: Image.asset(
                    'assets/dropili_Logo_PNG.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // do something
                    },
                  )
                ],
              ),
              body: state.currentPage == Pages.profile
                  ? ProfilePageWidget()
                  : state.currentPage == Pages.qr
                      ? QrPage()
                      : Container(),
              drawer: DrawerPage(),
              bottomNavigationBar: NavigatioBarWidget(),
            );
          },
        ),
      ),
    );
  }
}
