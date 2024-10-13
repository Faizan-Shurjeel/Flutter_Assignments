// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// // Score Provider
// class ScoreProvider with ChangeNotifier {
//   String _teamName = '';
//   int _score = 0;

//   String get teamName => _teamName;
//   int get score => _score;

//   void updateScore(String name) {
//     _teamName = name;
//     // Simulate fetching the score
//     _score = (name.length * 10) % 100; // Mock score based on team name length
//     notifyListeners();
//   }

//   void resetScore() {
//     _teamName = '';
//     _score = 0;
//     notifyListeners();
//   }
// }

// // Theme Provider
// class ThemeProvider with ChangeNotifier {
//   Brightness _brightness = Brightness.light;

//   Brightness get brightness => _brightness;

//   void toggleBrightness() {
//     _brightness =
//         _brightness == Brightness.light ? Brightness.dark : Brightness.light;
//     notifyListeners();
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ScoreProvider()),
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: Consumer<ThemeProvider>(
//         builder: (context, themeProvider, child) {
//           return CupertinoApp(
//             title: 'Baseball Score Check',
//             theme: CupertinoThemeData(
//               brightness: themeProvider.brightness,
//               primaryColor: CupertinoColors.activeBlue,
//               textTheme: const CupertinoTextThemeData(
//                 textStyle: TextStyle(
//                   fontFamily: 'SF Pro Text',
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//             home: ScoreCheckPage(),
//           );
//         },
//       ),
//     );
//   }
// }

// class ScoreCheckPage extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();

//   ScoreCheckPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode =
//         Provider.of<ThemeProvider>(context).brightness == Brightness.dark;

//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: const Text('Baseball Score Check'),
//         trailing: CupertinoSwitch(
//           value: isDarkMode,
//           onChanged: (value) {
//             Provider.of<ThemeProvider>(context, listen: false)
//                 .toggleBrightness();
//           },
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CupertinoTextField(
//                 controller: _controller,
//                 placeholder: 'Enter Team Name',
//                 style: TextStyle(
//                   color: isDarkMode
//                       ? CupertinoColors.white
//                       : CupertinoColors.black,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   border: Border.all(
//                     color: isDarkMode
//                         ? CupertinoColors.white
//                         : CupertinoColors.black,
//                     width: 2.3,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CupertinoButton.filled(
//                 child: const Text('Check Score'),
//                 onPressed: () {
//                   final teamName = _controller.text;
//                   if (teamName.isNotEmpty) {
//                     Provider.of<ScoreProvider>(context, listen: false)
//                         .updateScore(teamName);
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               CupertinoButton(
//                 child: const Text('Reset Score'),
//                 onPressed: () {
//                   Provider.of<ScoreProvider>(context, listen: false)
//                       .resetScore();
//                   _controller.clear();
//                 },
//               ),
//               const SizedBox(height: 20),
//               Consumer<ScoreProvider>(
//                 builder: (context, scoreProvider, child) {
//                   return Text(
//                     scoreProvider.teamName.isNotEmpty
//                         ? 'Score for ${scoreProvider.teamName}: ${scoreProvider.score}'
//                         : 'Enter a team name to check the score',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: isDarkMode
//                           ? CupertinoColors.white
//                           : CupertinoColors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// Score Provider
class ScoreProvider with ChangeNotifier {
  String _teamName = '';
  int _score = 0;

  String get teamName => _teamName;
  int get score => _score;

  void updateScore(String name) {
    _teamName = name;
    _score = (name.length * 10) % 100; // Mock score based on team name length
    notifyListeners();
  }

  void resetScore() {
    _teamName = '';
    _score = 0;
    notifyListeners();
  }
}

// Theme Provider
class ThemeProvider with ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  void toggleBrightness() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoreProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return CupertinoApp(
            title: 'Baseball Score Check',
            theme: CupertinoThemeData(
              brightness: themeProvider.brightness,
              primaryColor: CupertinoColors.activeBlue,
              textTheme: const CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 16.0,
                ),
              ),
            ),
            home: ScoreCheckPage(),
          );
        },
      ),
    );
  }
}

class ScoreCheckPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ScoreCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Baseball Score Check'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.pen),
          onPressed: () {
            _showMenu(context);
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                controller: _controller,
                placeholder: 'Enter Team Name',
                style: TextStyle(
                  color: isDarkMode
                      ? CupertinoColors.white
                      : CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isDarkMode
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                    width: 2.3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                child: const Text('Check Score'),
                onPressed: () {
                  final teamName = _controller.text;
                  if (teamName.isNotEmpty) {
                    Provider.of<ScoreProvider>(context, listen: false)
                        .updateScore(teamName);
                  }
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                child: const Text('Reset Score'),
                onPressed: () {
                  Provider.of<ScoreProvider>(context, listen: false)
                      .resetScore();
                  _controller.clear();
                },
              ),
              const SizedBox(height: 20),
              Consumer<ScoreProvider>(
                builder: (context, scoreProvider, child) {
                  return Text(
                    scoreProvider.teamName.isNotEmpty
                        ? 'Score for ${scoreProvider.teamName}: ${scoreProvider.score}'
                        : 'Enter a team name to check the score',
                    style: TextStyle(
                      fontSize: 20,
                      color: isDarkMode
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Menu'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Toggle Dark Mode'),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleBrightness();
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Reset Score'),
              onPressed: () {
                Provider.of<ScoreProvider>(context, listen: false).resetScore();
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
