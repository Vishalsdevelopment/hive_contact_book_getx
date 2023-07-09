import 'package:flutter/material.dart';
import 'package:hive_dbms/GetX/get_x.dart';
import 'package:hive_dbms/Hive%20Database/hive_database.dart';
import 'package:hive_dbms/Widgets/TextFields.dart';

class Methods {
  static void openBottomSheet(BuildContext context,
      {bool isUpdate = false,
      int? index,
      String name = '',
      String contact = ''}) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    if (isUpdate) {
      nameController.text = name;
      contactController.text = contact;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      )),
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            8, 8, 8, MediaQuery.of(context).viewInsets.bottom),
        child: ListView(shrinkWrap: true, children: [
          InputData(
            controller: nameController,
            labelText: 'Name',
          ),
          const SizedBox(
            height: 16,
          ),
          InputData(
            controller: contactController,
            labelText: 'Contact',
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5AC8FA)),
              onPressed: () {
                Map map = {
                  'name': nameController.text,
                  'contact': contactController.text,
                };
                if (isUpdate) {
                  var key = GetXClass.contactsList[index!]['key'];
                  HiveDatabase.updateContact(key: key, newValue: map);
                } else {
                  HiveDatabase.addContact(value: map);
                }
                Navigator.pop(context);
              },
              child: Text(isUpdate ? 'Update Contact' : 'Add Contact')),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }
}
