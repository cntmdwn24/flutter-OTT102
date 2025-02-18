import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ott102/domain/use_cases/profile_use_case.dart';
import 'package:ott102/main.dart';
import '../../common/color.dart';
import '../providers/create_profile_provider.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();

  final CreateProfileProvider provider =
      CreateProfileProvider(ProfileUseCase(sharedPrefRepository));
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.provider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    widget.provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child:
                        Icon(Icons.arrow_back, color: Colors.white, size: 36),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'profile'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                  color: widget.provider.profileColor),
              child: Text(
                widget.provider.firstCharOfProfileName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: grayColor),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: widget.provider.setProfileName,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (widget.provider.profileName.isNotEmpty) {
                        await widget.provider.saveProfile();
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              content: Text('enter_a_profile_name'.tr()),
                            ),
                          );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text(
                        'save'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFF7AE06),
                            Color(0xFFF77602),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
