import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/Background.png'),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Expanded(
              child: PageView(
            controller: pageController,
            physics: BouncingScrollPhysics(),
            children: [FirstPage(), SecondPage(), ThirdPage()],
            onPageChanged: (value) {
              selectedIndex.value = value;
            },
          )),
          ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, indexIndicator, child) {
                return Wrap(
                  spacing: 8,
                  children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 8,
                            width: indexIndicator == index ? 24 : 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: indexIndicator == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5)),
                          )),
                );
              }),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, indexIndicator, child) {
                      if (indexIndicator != 2) {
                        return GestureDetector(
                          onTap: () {
                            pageController.animateToPage(2,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.linearToEaseOut);
                          },
                          child: Text(
                            'Passer',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 20,
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, indexIndicator, child) {
                      if (indexIndicator != 2) {
                        return SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              final nextPage = selectedIndex.value + 1;
                              pageController.animateToPage(nextPage,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            },
                            child: Text(
                              'Suivant',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue[600],
                                  fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 40,
                      );
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 60, right: 60),
            child: Hero(
                tag: 'logo',
                child: Image(image: AssetImage('assets/dropili.png'))),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            'Bienvenue sur dropili',
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Partagez vos coordonnees, reseaux sociaux et bien plus avec dropili',
            style: TextStyle(fontSize: 17, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/linkwithin.png')),
          SizedBox(
            height: 10,
          ),
          Text(
            'Partagez en un éclair !',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Partagez vos données de maniére facile, rapide et intelligente avec dropili',
            style: TextStyle(fontSize: 17, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: , right: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120, right: 120),
            child: Image(image: AssetImage('assets/dropili.png')),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: Text(
                  'Connexion',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 123, 206)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(
                  'S\'inscrire',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 123, 206)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
              )),
        ],
        // child: PageView.builder(itemBuilder: ((context, index) => Container())),
      ),
    );
  }
}
