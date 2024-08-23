// import 'package:evento_event_booking/utils/appthemes.dart';
// import 'package:flutter/material.dart';
// import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';

// class CustomNavigationBar extends StatelessWidget {
// int _currentPage = 0;
// final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return DotCurvedBottomNav(
//     scrollController: _scrollController,
//     hideOnScroll: true,
//     indicatorColor: Appthemes.primaryColor,
//     backgroundColor: Appthemes.bottomNavBarColor,
//     animationDuration: const Duration(milliseconds: 300),
//     animationCurve: Curves.ease,
//     selectedIndex: _currentPage,
//     indicatorSize: 5,
//     borderRadius: 25,
//     height: 70,
//     onTap: (index) {
//     // setState(() => _currentPage = index);
//     },
//     items: [
//     Icon(
//         Icons.home,
//         color: _currentPage == 0 ? Appthemes.primaryColor : Colors.white,
//     ),
//     Icon(
//         Icons.search,
//         color: _currentPage == 1 ? Appthemes.primaryColor : Colors.white,
//     ),
//     Icon(
//         Icons.favorite,
//         color: _currentPage == 2 ? Appthemes.primaryColor : Colors.white,
//     ),
//     Icon(
//         Icons.person,
//         color: _currentPage == 3 ? Appthemes.primaryColor : Colors.white,
//     ),
//     ],
// );
//   }
// }