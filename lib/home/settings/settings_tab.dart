import 'package:flutter/material.dart';
import 'package:to_do/theme.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30),
          child: Text(
            'Language',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: MyTheme.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                dropdownColor: MyTheme.whiteColor,
                iconSize: 35,
                iconEnabledColor: MyTheme.primaryColor,
                items: languageItems
                    .map((item) => DropdownMenuItem(
                          child: Text(
                            '$item',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.primaryColor),
                          ),
                          value: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                },
                value: selectedLanguage,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30),
          child: Text(
            'Theme',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: MyTheme.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: MyTheme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconSize: 35,
                iconEnabledColor: MyTheme.primaryColor,
                items: themeItems
                    .map((item) => DropdownMenuItem(
                          child: Text(
                            '$item',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.primaryColor),
                          ),
                          value: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMode = value;
                  });
                },
                value: selectedMode,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
