import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/Models/categories.dart';
import 'package:shop_app/Models/user.dart';

class DatabaseServices {
  final _db = Firestore.instance;
  void createUser(String phoneNumber) async {
    final CollectionReference _doc = _db.collection('Users');
    await _doc.document(phoneNumber).setData({
      'address': "None",
      'phoneNumber': phoneNumber,
      'cartID': phoneNumber,
      'name': "Name",
      'alternatePhoneNumber': "Enter alternate phone number",
    });
  }

  Stream<User> streamUser(User user) {
    return _db
        .collection('Users')
        .document(user.phone)
        .snapshots()
        .map((snap) => User.fromfirebase(snap));
  }

  Stream<List<Category>> getCateries() {
    var ref = _db.collection('Category').snapshots();
    print(ref);
    //return _db.collection('Category').snapshots().;
  }
}
