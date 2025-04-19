import 'package:ayurveda/services/user_service.dart';
import 'package:flutter/material.dart';
import '../pages/categories.dart';
import '../pages/search.dart';
import '../pages/about.dart';
import '../pages/login.dart';
import '../pages/profile.dart';

class Bottombar extends StatefulWidget {
  final int currentIndex;

  const Bottombar({super.key, required this.currentIndex});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  late int currentindex;

  @override
  void initState() {
    super.initState();
    currentindex = widget.currentIndex;
  }

  void onItemSelected(int index) async {
    if (index == currentindex) return;

    setState(() {
      currentindex = index;
    });

    final userData = await UserService.getUserData();
    final currentUsername = userData['username'];
    final displayName = userData['displayName'] ?? currentUsername;

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Categories(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Search(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const About(),
          ),
        );
        break;
      case 3:
        if (currentUsername != null) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Profile(
                username: currentUsername!,
                displayName: displayName!,
              ),
            ),
          );
        } else {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
          if (result == true) {
            // Refresh if user logged in
            setState(() {});
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xfff7770f),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_mark),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      currentIndex: currentindex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      onTap: onItemSelected,
    );
  }
}
