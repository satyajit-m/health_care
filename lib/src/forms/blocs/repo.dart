import 'firestore_provider.dart';

class Repo {
  final _firestoreProvider = FirestoreProvider();
  Future<void> uploadAgent(
      List<Map<String, String>> data, String col, String doc) async {
    await _firestoreProvider.uploadAgent(data, col, doc);
  }
}
