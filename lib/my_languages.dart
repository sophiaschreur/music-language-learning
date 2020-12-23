import 'package:flutter/material.dart';
import 'main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theme_provider/theme_provider.dart';

List<String> languagesList = [
  'us',
  'es',
  'ru',
  'de',
  'fr',
  'tr',
  'it',
  'pt',
  'kr',
  'gr',
  'ar',
  'rs',
  'fi',
  'ro',
  'se',
  'ir',
  'pl',
  'hr',
  'il',
  'bg',
  'hu',
  'al',
  'ua',
  'dk',
  'cz',
  'ba',
  'no',
  'ct',
  'nl',
  'in',
  'kuk',
  'kus',
  'az',
  'uz',
  'id',
  'lv',
  'la',
  'ee',
  'sk',
  'cv',
  'np',
  'kz',
  'mk',
  'ph',
  'si',
  'lt',
  'is',
  'vt',
  'th',
  'am',
  'sw',
  'pj',
  'by',
  'my',
  'tt'
];


Map<String, String> languagesMap = {
      'al': 'Albanian',
      'ar': 'Arabic',
      'az': 'Azerbaijani',
      'ba': 'Bosnian',
      'bg': 'Bulgarian',
      'by': 'Belarusian',
      'cz': 'Czech',
      'de': 'German',
      'dk': 'Danish',
      'ee': 'Estonian',
      'es': 'Spanish',
      'fi': 'Finnish',
      'gr': 'Greek',
      'hr': 'Croatian',
      'hu': 'Hungarian',
      'id': 'Indonesian',
      'il': 'Hebrew',
      'in': 'Hindi',
      'ir': 'Persian',
      'it': 'Italian',
      'kr': 'Korean',
      'kz': 'Kazakh',
      'la': 'Latin',
      'lt': 'Lithuanian',
      'lv': 'Latvian',
      'mk': 'Macedonian',
      'my': 'Malay',
      'nl': 'Dutch',
      'no': 'Norwegian',
      'ph': 'Filipino',
      'pl': 'Polish',
      'pt': 'Portuguese',
      'ro': 'Romanian',
      'rs': 'Serbian',
      'ru': 'Russian',
      'se': 'Swedish',
      'si': 'Slovenian',
      'sk': 'Slovak',
      'th': 'Thai',
      'tr': 'Turkish',
      'ua': 'Ukrainian',
      'us': 'English',
      'uz': 'Uzbek',
      'fr': 'French',
      'ct': 'Catalan',
      'am': 'Armenian',
      'cv': 'Cape Verdean',
      'is': 'Icelandic',
      'kuk': 'Kurdish',
      'kus': 'Kurdish Sorani',
      'np': 'Neapolitan',
      'pj': 'Punjabi',
      'sw': 'Swahili',
      'tt': 'Tatar',
      'vt': 'Vietnamese',
    };

class MyLanguages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    
    List<Widget> languagesWidgets = [];

    for (var k in languagesList) {
      languagesWidgets.add(
        Container(
          height: (screenHeight - 123) / 3 / 4,
          width: (screenHeight - 123) / 3 * 1.66666666,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 0.35 * (screenHeight - 123) / 3,
                width: 0.35 * (screenHeight - 123) / 3 * 1.66666666,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/' + k + '.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeProvider.themeOf(context).data.accentColor,
                ),
              ),
              Container(
                child: Text(
                  languagesMap[k],
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeProvider.themeOf(context).data.accentColor,
        ),
        padding: const EdgeInsets.all(0),
        height: (screenHeight - 123) / 3 / 1.5,
        width: screenWidth,
        child: CarouselSlider(
            items: languagesWidgets,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                whichPage = index;
              },
              initialPage: whichPage,
              height: (screenHeight - 123) / 3,
              viewportFraction: 0.5,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )));
  }
}





