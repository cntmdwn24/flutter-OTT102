import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ott102/presentation/providers/main_provider.dart';
import 'package:ott102/presentation/screens/comming_soon_screen.dart';
import 'package:ott102/presentation/screens/download_screen.dart';
import 'package:ott102/presentation/screens/home_screen.dart';
import 'package:ott102/presentation/screens/profile_screen.dart';
import 'package:ott102/presentation/screens/search_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainProvider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    mainProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mainProvider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CommingSoonScreen(),
          DownloadScreen(),
          SearchScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF242934), // RGB(36, 41, 52)
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.1)),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: mainProvider.currentIndex,
              onTap: (index) {
                mainProvider.onTapBottomNavigationItem(index);
              },
              backgroundColor: const Color(0xFF242934),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFFE77730),
              unselectedItemColor: Colors.white,
              selectedIconTheme: const IconThemeData(size: 28),
              unselectedIconTheme: const IconThemeData(size: 28),
              selectedLabelStyle: const TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              items: [
                _buildBottomNavBarItem(
                  icon: Icons.home_outlined,
                  label: 'home'.tr(),
                ),
                _buildBottomNavBarItem(
                  icon: Icons.playlist_play_sharp,
                  label: 'to_be_released'.tr(),
                ),
                _buildBottomNavBarItem(
                  icon: Icons.download_outlined,
                  label: 'download'.tr(),
                ),
                _buildBottomNavBarItem(
                  icon: Icons.search,
                  label: 'search'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                mainProvider.selectedProfile.backgroundColor,
                            child: Text(
                              mainProvider.selectedProfile.profileName[0] ??
                                  '?',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                  label: 'profile'.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required IconData icon,
    required String label,
  }) =>
      BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Icon(icon),
          ],
        ),
        label: label,
      );
}
