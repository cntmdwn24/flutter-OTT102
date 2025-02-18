import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ott102/common/color.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'to_be_released'.tr(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
