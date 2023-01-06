import 'package:beo_shop_ui/const.dart';
import 'package:beo_shop_ui/pages/explore_page.dart';
import 'package:beo_shop_ui/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = BlocProvider.of<PageProvider>(context);
    Widget body() {
      switch (pageProvider.state) {
        case 0:
          return const Center(
              child:
                  Text('Home', style: TextStyle(color: black, fontSize: 32)));
        case 1:
          return const ExplorePage();
        case 2:
          return const Center(
              child:
                  Text('Saved', style: TextStyle(color: black, fontSize: 32)));
        case 3:
          return const Center(
              child:
                  Text('Menu', style: TextStyle(color: black, fontSize: 32)));
        default:
          return const Center(
              child:
                  Text('Home', style: TextStyle(color: black, fontSize: 32)));
      }
    }

    return BlocBuilder<PageProvider, int>(
      bloc: pageProvider,
      builder: (context, state) {
        return Scaffold(
          body: body(),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.15),
                      offset: Offset.zero,
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
            child: BottomNavigationBar(
                elevation: 0,
                unselectedItemColor: black.withOpacity(0.3),
                selectedItemColor: black,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  pageProvider.setCurrentPage(value);
                },
                currentIndex: state,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined), label: 'Explore'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_outline), label: 'Saved'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Menu'),
                ]),
          ),
        );
      },
    );
  }
}
