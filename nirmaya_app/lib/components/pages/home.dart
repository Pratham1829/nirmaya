import 'package:flutter/material.dart';
import '../../constants/texts.dart';
import '../pages/categories.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo2.png",
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  AppStrings.welcomeMessage,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text("Niramaya",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans')),
                const SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Categories(),
                      ),
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xfff7770f)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        side: BorderSide(
                          color: Color(0xfff7770f),
                        ),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(Size(140.0, 55.0)),
                  ),
                  child: const Text(
                    AppStrings.btngetStarted,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff7770f),
    );
  }
}
