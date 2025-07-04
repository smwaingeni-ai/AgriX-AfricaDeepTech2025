import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/investor_profile.dart';

class InvestorService {
  static const String _investorFile = 'investor_profiles.json';

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_investorFile';
  }

  Future<List<InvestorProfile>> loadInvestors() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        return InvestorProfile.decode(jsonStr);
      }
    } catch (_) {}
    return [];
  }

  Future<void> saveInvestors(List<InvestorProfile> profiles) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(InvestorProfile.encode(profiles));
  }

  Future<void> addInvestor(InvestorProfile investor) async {
    final existing = await loadInvestors();
    existing.add(investor);
    await saveInvestors(existing);
  }

  Future<void> removeInvestor(String id) async {
    final existing = await loadInvestors();
    existing.removeWhere((inv) => inv.id == id);
    await saveInvestors(existing);
  }

  Future<InvestorProfile?> getInvestorById(String id) async {
    final investors = await loadInvestors();
    return investors.firstWhere((i) => i.id == id, orElse: () => null);
  }
}
