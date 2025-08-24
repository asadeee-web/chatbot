// class FirebaseServices {
//    final _firestore = FirebaseFirestore.instance;

//   // Save a message
//   Future<void> saveMessageToFirebase(Map<String, String> message) async {
//     await _firestore.collection("chats").add({
//       "sender": message["sender"],
//       "message": message["message"],
//       "timestamp": FieldValue.serverTimestamp(),
//     });
//   }

//   // Load messages
//   Future<void> loadMessagesFromFirebase() async {
//     final snapshot = await _firestore
//         .collection("chats")
//         .orderBy("timestamp")
//         .get();

//     messages = snapshot.docs.map((doc) {
//       return {
//         "sender": doc["sender"],
//         "message": doc["message"],
//       };
//     }).toList();

//     notifyListeners();
//   }
// }
