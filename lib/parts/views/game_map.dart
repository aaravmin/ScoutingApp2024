import 'package:flutter/material.dart';
import 'package:scouting_app_2024/parts/views_delegate.dart';

class GameMapView extends StatelessWidget implements AppPageViewExporter {
  const GameMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Labelled Game Field',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/crescendo/labelled_map.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Game Item Descriptions',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: <String>[
                'Starting Zone',
                'Speaker',
                'Source Area',
                'Amp Zone',
                'Stage',
                'Notes',
                'High Notes',
              ].map((String title) => _buildButton(context, title)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title) {
    return Container(
      constraints: BoxConstraints(maxWidth: 100),
      child: OutlinedButton(
        onPressed: () => _showDetails(context, title),
        child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, String title) {
    final Map<String, String> details = {
      'Starting Zone': 'Where robots start at the beginning of the match before the autonomous period.',
      'Stage': 'During the match, robots can score additional points by parking in their Stage Zone, getting Onstage via a chain, or scoring a Note in a Trap. Points vary for being Onstage with or without the Spotlight per robot (3 points without Spotlight, 4 points with Spotlight during Teleop phase), and a note scored in a trap on stage are 5 points. Harmony is achieved when more than one robot is Onstage via the same chain, giving 2 ranking points.',
      'Source Area': 'Where Notes are introduced into the field for robots to collect.',
      'Amp Zone': 'Robots score Notes in the Amp during Auto and Teleop for 2 points each. Every two notes scored in the amp the human players can either amplify the points associated with Notes scored in their Speaker by 3 points for 10 seconds or engage in coopertition with opponents if done in the first 45 seconds of the match for a cooperation bonus which can give ranking points.',
      'Speaker': 'Notes are scored in the Speaker with different points awarded based on whether they are Amplified or not (2 points for a regular Speaker Note, 5 points for an Amplified Speaker Note during Teleop).',
      'High Notes': 'When a High Note is scored on a Microphone when one robot or more is on stage, it Spotlights Robots Onstage, granting one additional point per high note scored (max of 3).',
      'Notes': 'The primary game piece scored in the Speaker and Amp for points. If a Note is placed in a Trap, it gives a maximum of one per Trap, awarding 5 points during Teleop.',
    };

    final Map<String, IconData> icons = {
      'Starting Zone': Icons.flag,
      'Stage': Icons.theater_comedy,
      'Source Area': Icons.source,
      'Amp Zone': Icons.volume_up,
      'Speaker': Icons.speaker,
      'High Notes': Icons.arrow_upward,
      'Notes': Icons.music_note,
    };

    final String? detail = details[title];
    final IconData? icon = icons[title];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Icon(icon ?? Icons.help_outline, size: 26),
                  SizedBox(width: 10),
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    detail ?? 'Details for "$title" are not available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  ({
    Widget child,
    ({Icon activeIcon, Icon icon, String label, String tooltip}) item
  }) exportAppPageView() {
    return (
      child: this,
      item: (
        activeIcon: const Icon(Icons.map_rounded),
        icon: const Icon(Icons.map_outlined),
        label: "Game Map",
        tooltip: "View the Game Map"
      )
    );
  }
}
