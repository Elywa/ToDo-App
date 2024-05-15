import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/settings/lnguage_bottom_sheet.dart';
import 'package:to_do/home/settings/theme_bottom_sheet.dart';
import 'package:to_do/providers/language_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final languageItems = ['Arabic', 'English'];
  final themeItems = ['Light', 'Dark'];
  String? selectedLanguage = 'Arabic';
  String? selectedMode = 'Light';
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var appLanguage = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        // ?.copyWith(
        //         fontSize: 22,
        //         fontWeight: FontWeight.w500,
        //         color: MyTheme.primaryColor),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30, right: 16),
          child: Text(AppLocalizations.of(context)!.language,
              style: themeProvider.isDark()
                  ? Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.whiteColor)
                  : Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.blackColor)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: MyTheme.primaryColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    appLanguage.appLanguage == 'ar'
                        ? AppLocalizations.of(context)!.arabic
                        : AppLocalizations.of(context)!.english,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: MyTheme.primaryColor),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: MyTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Container(
        //     width: 350,
        //     padding: const EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       border: Border.all(color: MyTheme.primaryColor, width: 2),
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: DropdownButtonHideUnderline(
        //       child: DropdownButton(
        //         dropdownColor: MyTheme.whiteColor,
        //         iconSize: 35,
        //         iconEnabledColor: MyTheme.primaryColor,
        //         items: languageItems
        //             .map((item) => DropdownMenuItem(
        //                   child: Text(
        //                     '$item',
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .titleMedium!
        //                         .copyWith(color: MyTheme.primaryColor),
        //                   ),
        //                   value: item,
        //                 ))
        //             .toList(),
        //         onChanged: (value) {
        //           setState(() {
        //             selectedLanguage = value;
        //           });
        //         },
        //         value: selectedLanguage,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(
          height: 50,
        ),
        //============================================================
        // ?.copyWith(
        //         fontSize: 22,
        //         fontWeight: FontWeight.w500,
        //         color: MyTheme.primaryColor),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30, right: 16),
          child: Text(AppLocalizations.of(context)!.theme,
              style: themeProvider.isDark()
                  ? Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.whiteColor)
                  : Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.blackColor)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              showBottomThemeSheet();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: MyTheme.primaryColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    themeProvider.myTheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: MyTheme.primaryColor),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: MyTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Container(
        //     width: 350,
        //     padding: const EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       border: Border.all(color: MyTheme.primaryColor, width: 2),
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     child: DropdownButtonHideUnderline(
        //       child: DropdownButton(
        //         iconSize: 35,
        //         iconEnabledColor: MyTheme.primaryColor,
        //         items: themeItems
        //             .map((item) => DropdownMenuItem(
        //                   child: Text(
        //                     '$item',
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .titleMedium!
        //                         .copyWith(
        //                           color: MyTheme.primaryColor,
        //                         ),
        //                   ),
        //                   value: item,
        //                 ))
        //             .toList(),
        //         onChanged: (value) {
        //           setState(() {
        //             selectedMode = value;
        //           });

        //           if (selectedMode == 'Light') {
        //             themeProvider.changeTheme(ThemeMode.light);
        //           } else if (selectedMode == 'Dark') {
        //             themeProvider.changeTheme(ThemeMode.dark);
        //           }
        //         },
        //         value: selectedMode,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return LnaguageBottomSheet();
        });
  }

  void showBottomThemeSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
