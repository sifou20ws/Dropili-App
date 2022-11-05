import 'package:dropili/Presentation/Nfc/nfc_dialoge.dart';
import 'package:dropili/Presentation/home/collectionPage/collection_page.dart';
import 'package:dropili/Presentation/home/navigation_bar/navigation_bar_widget.dart';
import 'package:dropili/Presentation/home/qr_page/qr_page.dart';
import 'package:dropili/Presentation/home/ProfilePage/screens/profileScreen_page.dart';
import 'package:dropili/Presentation/home/drawerPage/drawerPage.dart';
import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NavigationBloc _navigationBloc;

  final _pageController = PageController();
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _navigationBloc = NavigationBloc();

    _pages = [
      ProfilePageWidget(),
      Container(),
      QrPage(),
      CollectionPage(),
    ];
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
          } else {
            _pageController.animateToPage(state.index,
                duration: Duration(milliseconds: 550), curve: Curves.ease);
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
              // body: state.currentPage == Pages.profile
              //     ? _pages[0]
              //     : state.currentPage == Pages.qr
              //         ? _pages[1]
              //         : _pages[2],
              body: PageView(
                controller: _pageController,
                children: _pages,
                physics: NeverScrollableScrollPhysics(),
              ),
              drawer: DrawerPage(),
              bottomNavigationBar: NavigatioBarWidget(),
            );
          },
        ),
      ),
    );
  }
}
