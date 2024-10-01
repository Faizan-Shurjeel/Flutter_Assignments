import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Sports24',
      theme: _isDarkMode
          ? const CupertinoThemeData(brightness: Brightness.dark)
          : const CupertinoThemeData(brightness: Brightness.light),
      home:
          HomePage(isDarkMode: _isDarkMode, onToggleDarkMode: _toggleDarkMode),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final primaryColor =
        isDarkMode ? CupertinoColors.systemOrange : CupertinoColors.activeBlue;

    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.barBackgroundColor,
        border: null,
        middle: Text(
          'Sports24',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.search, color: primaryColor, size: 24),
              onPressed: () {},
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.bell, color: primaryColor, size: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Live Sports',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.textStyle.color,
                        ),
                      ),
                      CupertinoSlidingSegmentedControl<bool>(
                        groupValue: isDarkMode,
                        children: const {
                          true: Icon(CupertinoIcons.moon_fill),
                          false: Icon(CupertinoIcons.sun_max_fill),
                        },
                        onValueChanged: (value) => onToggleDarkMode(value!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SportIconsRow(primaryColor: primaryColor),
                  const SizedBox(height: 32),
                  SectionTitle(
                      title: 'Top Live Matches', primaryColor: primaryColor),
                  const SizedBox(height: 16),
                  LiveMatchCard(
                    team1: 'Real Madrid',
                    team2: 'Man City',
                    score1: '0',
                    score2: '0',
                    time: '22:00',
                    color: CupertinoColors.systemIndigo,
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(height: 16),
                  LiveMatchCard(
                    team1: 'Liverpool',
                    team2: 'Tottenham',
                    score1: '1',
                    score2: '0',
                    time: '22:00',
                    color: CupertinoColors.systemOrange,
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(height: 32),
                  SectionTitle(
                      title: 'Latest News', primaryColor: primaryColor),
                  const SizedBox(height: 16),
                  NewsCard(
                    title: 'Ronaldo pushing for Man City move',
                    author: 'Adam Smith',
                    imageUrl: 'https://example.com/news-image.jpg',
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(height: 32),
                  SectionTitle(
                      title: 'Upcoming Matches', primaryColor: primaryColor),
                  const SizedBox(height: 16),
                  UpcomingMatchCard(
                    team1: 'Arsenal',
                    team2: 'Chelsea',
                    league: 'Italian Serie A, 2023/24, Match 215',
                    date: 'Sunday, 24 Mar • 22:00 PM',
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Color primaryColor;

  const SectionTitle(
      {super.key, required this.title, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }
}

class SportIconsRow extends StatelessWidget {
  final Color primaryColor;

  const SportIconsRow({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SportIcon(
            icon: CupertinoIcons.sportscourt,
            label: 'Soccer',
            primaryColor: primaryColor),
        SportIcon(
            icon: CupertinoIcons.circle_grid_3x3,
            label: 'Cricket',
            primaryColor: primaryColor),
        SportIcon(
            icon: CupertinoIcons.circle_grid_3x3_fill,
            label: 'Basketball',
            primaryColor: primaryColor),
        SportIcon(
            icon: CupertinoIcons.table,
            label: 'Table Tennis',
            primaryColor: primaryColor),
      ],
    );
  }
}

class SportIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primaryColor;

  const SportIcon(
      {super.key,
      required this.icon,
      required this.label,
      required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: primaryColor, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              color: CupertinoTheme.of(context).textTheme.textStyle.color),
        ),
      ],
    );
  }
}

class LiveMatchCard extends StatelessWidget {
  final String team1;
  final String team2;
  final String score1;
  final String score2;
  final String time;
  final Color color;
  final bool isDarkMode;

  const LiveMatchCard({
    super.key,
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.time,
    required this.color,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? color.withOpacity(0.3) : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(team1, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(team2, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              Text(score1,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              Text(score2,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              const Text(
                'LIVE',
                style: TextStyle(
                    color: CupertinoColors.systemRed,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final bool isDarkMode;

  const NewsCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? CupertinoColors.darkBackgroundGray
            : CupertinoColors.extraLightBackgroundGray,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text(author,
                    style: const TextStyle(color: CupertinoColors.systemGrey)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl,
                width: 90, height: 90, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}

class UpcomingMatchCard extends StatelessWidget {
  final String team1;
  final String team2;
  final String league;
  final String date;
  final bool isDarkMode;

  const UpcomingMatchCard({
    super.key,
    required this.team1,
    required this.team2,
    required this.league,
    required this.date,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? CupertinoColors.darkBackgroundGray
            : CupertinoColors.extraLightBackgroundGray,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(team1, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text('VS',
                  style: TextStyle(color: CupertinoColors.systemGrey)),
              Text(team2, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            league,
            style: const TextStyle(
                color: CupertinoColors.systemGrey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(color: theme.primaryColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
