// import 'package:flutter/material.dart';
// import 'package:theme_provider/theme_provider.dart';
// import 'main.dart';
// import 'icons.dart';
// import 'music.dart';
// import 'answers_colors.dart';

// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: ThemeProvider.themeOf(context).data.primaryColor,
//         body: Column(children: [
//           Container(height: screenWidth * 0.05),
//           Container(
//             height: 40,
//             width: screenWidth,
//             child: Row(children: [
//               Container(width: screenWidth * 0.05),
//               Container(
//                 padding: const EdgeInsets.all(0.0),
//                 width: 30.0,
//                 child: IconButton(
//                   padding: EdgeInsets.all(0),
//                   icon: Icon(
//                     Icons.clear,
//                     color: ThemeProvider.themeOf(context).data.cardColor,
//                   ),
//                   onPressed: () {
//                     doItOnce = true;
//                     showStreakEnd = true;
//                     if (!musicClicked) {
//                       musicClicked = true;
//                       courseClicked = false;
//                       trendingClicked = false;
//                       profileClicked = false;
//                       setState(() {});
//                     }
//                     Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (
//                             context,
//                             a1,
//                             a2,
//                           ) =>
//                               Music(),
//                           transitionDuration: Duration(seconds: 0),
//                         ));
//                     setState(() {});
//                   },
//                   iconSize: 40,
//                 ),
//               ),
//               Container(width: screenWidth * 0.05),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Premium Plans',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 25,
//                       color: ThemeProvider.themeOf(context).data.cardColor,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(width: screenWidth * 0.05),
//             ]),
//           ),
//           Container(
//             height: screenWidth * 0.05,
//           ),
//           Spacer(),
//           Row(children: [
//             Container(width: screenWidth * 0.05),
//             Text('Unlocked Features:',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 25,
//                   color: ThemeProvider.themeOf(context).data.cardColor,
//                 )),
//             Spacer(),
//           ]),
//           Container(height: 10),
//           Row(children: [
//             Spacer(),
//             Container(
//                 width: screenWidth * 0.9,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: ThemeProvider.themeOf(context).data.accentColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                     child: Text('Add your favorite music',
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 20,
//                           color: ThemeProvider.themeOf(context).data.cardColor,
//                         )))),
//             Spacer(),
//           ]),
//           Container(height: 10),
//           Row(children: [
//             Spacer(),
//             Container(
//                 width: screenWidth * 0.9,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: ThemeProvider.themeOf(context).data.accentColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                     child: Text('Full access to all of the courses',
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 20,
//                           color: ThemeProvider.themeOf(context).data.cardColor,
//                         )))),
//             Spacer(),
//           ]),
//           Container(height: 10),
//           Row(children: [
//             Spacer(),
//             Container(
//                 width: screenWidth * 0.9,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: ThemeProvider.themeOf(context).data.accentColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Column(children: [
//                     Spacer(),
//                     Text('Support our efforts to create',
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 20,
//                           color: ThemeProvider.themeOf(context).data.cardColor,
//                         )),
//                     Spacer(),
//                     Text('a playground for language learning',
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 20,
//                           color: ThemeProvider.themeOf(context).data.cardColor,
//                         )),
//                     Spacer(),
//                   ]),
//                 )),
//             Spacer(),
//           ]),
//           Spacer(),
//           Row(children: [
//             Container(width: screenWidth * 0.05),
//             Text('Choose from 2 plans:',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 25,
//                   color: ThemeProvider.themeOf(context).data.cardColor,
//                 )),
//             Spacer(),
//           ]),
//           Container(height: 10),
//           Row(children: [
//             Spacer(),
//             Container(
//                 decoration: BoxDecoration(
//                   color: ThemeProvider.themeOf(context).data.accentColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 width: screenWidth * 0.425,
//                 height: 200,
//                 child: Column(children: [
//                   Spacer(),
//                   Text('Monthly',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 20,
//                         color: Color.fromRGBO(242, 29, 97, 1),
//                       )),
//                   Container(height: screenWidth * 0.05),
//                   Text('\$9.99',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 25,
//                         color: ThemeProvider.themeOf(context).data.splashColor,
//                       )),
//                   Container(height: screenWidth * 0.05),
//                   Text('per month',
//                       style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16,
//                         color: ThemeProvider.themeOf(context).data.splashColor,
//                       )),
//                   Spacer(),
//                 ])),
//             Spacer(),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: ThemeProvider.themeOf(context).data.accentColor,
//               ),
//               height: 200,
//               width: screenWidth * 0.425,
//               child: Column(children: [
//                 Spacer(),
//                 Text('Yearly',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 20,
//                         color: Color.fromRGBO(29, 161, 242, 1))),
//                 Container(height: screenWidth * 0.05),
//                 Text('\$4.99',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 25,
//                       color: ThemeProvider.themeOf(context).data.cardColor,
//                     )),
//                 Container(height: screenWidth * 0.05),
//                 Text('per month',
//                     style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 16,
//                       color: ThemeProvider.themeOf(context).data.cardColor,
//                     )),
//                 Spacer(),
//               ]),
//             ),
//             Spacer(),
//           ]),
//           Spacer(),
//          Row(children: [Spacer(), Container(width: screenWidth * 0.9, child: Center(
//             child: Text(
//                 'Subscription will be automatically renewed unless cancelled.',
//                 maxLines: 2,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 16,
//                   color: ThemeProvider.themeOf(context).data.splashColor,
//                 )),
//           ),),Spacer(),]),
//           Spacer(),
//           Container(
//             height: screenWidth * 0.05,
//           ),
//         ]));
//   }
// }
// // Mastering 50 songs will get you to B1 / B2 level
