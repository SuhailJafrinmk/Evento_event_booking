import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/models/location_model.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/search_page/explore_screen.dart';
import 'package:evento_event_booking/view/home/home_screen.dart';
import 'package:evento_event_booking/view/search_page/favourite_screen.dart';
import 'package:evento_event_booking/view/search_page/dummy_screen3.dart';
import 'package:evento_event_booking/widgets/animated_border.dart';
import 'package:flutter/material.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';

//added some random comments mainnavigationwrapper
class MainNavigationWrapper extends StatefulWidget {
  @override
  _MainNavigationWrapperState createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final String name = SharedPref.instance.getUserName() ?? "Guest";
    final EventLocations? userLocation = SharedPref.instance.getUserLocation();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        centerTitle: true,
        title: Text(userLocation?.name ?? 'Location', style: theme.textTheme.displayMedium?.copyWith(color: AppColors.cardBackgroundColor) ),
        actions: [
          AnimatedBorderContainer(radius: 30, child: CircleAvatar(backgroundImage: AssetImage(AssetImages.profileAvatar),)),
          SizedBox(width: size.width * .05),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children:  [
          HomePage(userName: name,userLocation: userLocation?.name ?? 'Not available'),    
          ExploreScreen(), 
          FavouritesScreen(), 
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: DotCurvedBottomNav(
        scrollController: _scrollController,
        hideOnScroll: true,
        indicatorColor: AppColors.accentColor,
        backgroundColor: AppColors.bottomNavBarColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        selectedIndex: _currentIndex,
        indicatorSize: 5,
        borderRadius: 25,
        height: 70,
        onTap: _onTabTapped,
        items: [
          Icon(
            Icons.home,
            color: _currentIndex == 0 ? AppColors.accentColor : Colors.white,
          ),
          Icon(
            Icons.search,
            color: _currentIndex == 1 ? AppColors.accentColor : Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: _currentIndex == 2 ? AppColors.accentColor : Colors.white,
          ),
          Icon(
            Icons.person,
            color: _currentIndex == 3 ? AppColors.accentColor : Colors.white,
          ),
        ],
      ),
    );
  }
}
