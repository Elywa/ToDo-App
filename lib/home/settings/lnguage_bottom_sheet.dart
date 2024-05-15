import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do/providers/language_provider.dart';
import 'package:to_do/theme.dart';

class LnaguageBottomSheet extends StatefulWidget {
  const LnaguageBottomSheet({super.key});

  @override
  State<LnaguageBottomSheet> createState() => _LnaguageBottomSheetState();
}

class _LnaguageBottomSheetState extends State<LnaguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    return Container(
      height: 150,
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedWidget(AppLocalizations.of(context)!.english)
                : getUnSelectedWidget(
                    AppLocalizations.of(context)!.english,
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                provider.changeLanguage('ar');
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectedWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedWidget(AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  Widget getSelectedWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: MyTheme.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.check,
          size: 35,
          color: MyTheme.primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
