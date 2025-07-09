import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/investor_profile.dart';

class CloudInvestorService {
  final _collection = FirebaseFirestore.instance.collection('investors');

  Future<void> saveInvestor(InvestorProfile profile) async {
    await _collection.doc(profile.id).set(profile.toJson());
  }

  Future<List<InvestorProfile>> loadInvestors() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => InvestorProfile.fromJson(doc.data())).toList();
  }

  Future<void> deleteInvestor(String id) async {
    await _collection.doc(id).delete();
  }

  Future<InvestorProfile?> getInvestorById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return InvestorProfile.fromJson(doc.data()!);
    }
    return null;
  }
}
