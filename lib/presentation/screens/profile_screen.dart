import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ott102/presentation/providers/main_provider.dart';
import 'package:ott102/presentation/providers/select_profile_provider.dart';
import 'package:ott102/presentation/screens/change_language_screen.dart';
import 'package:ott102/presentation/screens/edit_profile_screen.dart';
import '../../common/color.dart';
import 'create_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectProfileProvider.addListener(updateScreen);
      selectProfileProvider.loadProfiles();
    });
  }

  @override
  void dispose() {
    selectProfileProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'profile'.tr(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectProfileProvider.profiles.isEmpty
                  ? Center(
                      child: Text('there_is_no_profile'.tr(),
                          style: TextStyle(color: Colors.white)))
                  : Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: selectProfileProvider.profiles.map((profile) {
                          String profileInitial =
                              (profile.profileName.isNotEmpty)
                                  ? profile.profileName[0]
                                  : '';

                          return GestureDetector(
                            onTap: () {
                              mainProvider.setSelectedProfile(profile);
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: profile.id ==
                                        mainProvider.selectedProfile.id
                                    ? Border.all(
                                        width: 1.5, color: Colors.white)
                                    : null,
                                color: profile.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                profileInitial,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CreateProfileScreen()),
                    );
                    selectProfileProvider.loadProfiles();
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 60,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'add_profile'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'general_settings'.tr(),
                style: TextStyle(
                  color: Color(0xffF76E02),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _profileList(
                'edit_profile'.tr(),
                () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ));
                },
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList(
                'change_language'.tr(),
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeLanguageScreen(),
                    ),
                  );
                },
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('connect_a_new_device'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('app_permission_settings'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('logout'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('agree_to_terms_of_use'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('privacy_policy'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('guide_to_using_open_source'.tr(), () {}),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              _profileList('other_inquiries'.tr(), () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileList(String title, VoidCallback onTap) {
    return Container(
      width: 380,
      height: 35,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
