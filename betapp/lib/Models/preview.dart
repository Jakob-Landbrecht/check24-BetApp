import 'package:betapp/Models/community.dart';
import 'package:betapp/Models/leaderboardEntry.dart';

class Preview{
  final List<LeaderBoardEntry> leaderboard;
  final Community community;

  Preview({required this.leaderboard, required this.community});
}