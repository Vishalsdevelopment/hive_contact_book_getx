import 'package:flutter/material.dart';
import 'package:hive_dbms/Hive%20Database/hive_database.dart';

import '../GetX/get_x.dart';
import 'method.dart';

class CustomTile extends StatelessWidget {
  final int index;
  String? titleText;
  String? subTitleText;

  CustomTile(
      {super.key, required this.index, this.titleText, this.subTitleText});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFF5AC8FA),
      child: ListTile(
        title: Text(titleText ?? ''),
        subtitle: Text(subTitleText ?? ''),
        trailing: PopupMenuButton(
          onSelected: (value) => Methods.openBottomSheet(context,
              isUpdate: true,
              index: index,
              name: titleText ?? '',
              contact: subTitleText ?? ''),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'update',
              child: Text('Update'),
            ),
            PopupMenuItem(
              child: const Text('Delete'),
              onTap: () => HiveDatabase.deleteContact(
                  id: GetXClass.contactsList[index]['key']),
            ),
          ],
        ),
      ),
    );
  }
}
