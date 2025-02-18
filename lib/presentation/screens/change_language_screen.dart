import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ott102/common/color.dart';
import 'package:ott102/presentation/components/widget/custom_language_button.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'change_language'.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            setState(() {});
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: languageList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomLanguageButton(
                  text: languageList[index]['text'],
                  onPressed: () {
                    context.setLocale(
                      languageList[index]['locale'],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> languageList = [
  {'text': '한국어', 'locale': Locale('ko', 'KR')},
  {'text': 'English', 'locale': Locale('en', 'US')},
  {'text': '日本語', 'locale': Locale('ja', 'JP')},
  {'text': 'Français', 'locale': Locale('fr', 'FR')},
  {'text': 'Español', 'locale': Locale('es', 'ES')},
];
