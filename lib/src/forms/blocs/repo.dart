import 'firestore_provider.dart';

class Repo {
  final _firestoreProvider = FirestoreProvider();
  Future<void> uploadAgent(List<Map<String, String>> data) async {
    await _firestoreProvider.uploadAgent(data);
  }
}
