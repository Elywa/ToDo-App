import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do/providers/language_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<ThemeProvider>(context);
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              themeMode.changeTheme(ThemeMode.light);
            },
            child: themeMode.myTheme == ThemeMode.light
                ? getSelectedWidget(AppLocalizations.of(context)!.light)
                : getUnSelectedWidget(
                    AppLocalizations.of(context)!.light,
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              themeMode.changeTheme(ThemeMode.dark);
            },
            child: themeMode.myTheme == ThemeMode.dark
                ? getSelectedWidget(AppLocalizations.of(context)!.dark)
                : getUnSelectedWidget(AppLocalizations.of(context)!.dark),
          ),
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
