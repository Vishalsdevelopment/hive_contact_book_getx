import 'package:hive/hive.dart';
import 'package:hive_dbms/GetX/get_x.dart';

class HiveDatabase {
  static Box contacts = Hive.box('Hive_Example');

  static addContact({required Map value}) =>
      contacts.add(value).then((value) => viewContacts());

  static viewContacts() {
    GetXClass.contactsList.value = contacts.keys.map((key) {
      var item = contacts.get(key);
      return {'key': key, 'name': item['name'], 'contact': item['contact']};
    }).toList();
    GetXClass.contactsList.sort((a, b) {
      return a['name'].compareTo(b['name']);
    });
    GetXClass.searchList.addAll(GetXClass.contactsList);
  }

  static deleteContact({required int id}) =>
      contacts.delete(id).then((value) => viewContacts());

  static void updateContact({required key, required newValue}) {
    contacts.put(key, newValue).then((value) => viewContacts());
  }
}
