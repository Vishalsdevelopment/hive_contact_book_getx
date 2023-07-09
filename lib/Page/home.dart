import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_dbms/GetX/get_x.dart';
import 'package:hive_dbms/Hive%20Database/hive_database.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => openBottomSheet(context),
        child: const Icon(
          Icons.add,
          color: Color(0xFF5AC8FA),
          size: 35,
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => (GetXClass.isSearch.value &&
                        GetXClass.searchList.isNotEmpty) ||
                    !GetXClass.isSearch.value
                ? ListView.separated(
                    padding: const EdgeInsets.only(top: 145),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: const Color(0xFF5AC8FA),
                          child: GetXClass.isSearch.value
                              ? ListTile(
                                  title:
                                      Text(GetXClass.searchList[index]['name']),
                                  subtitle: Text(
                                      GetXClass.searchList[index]['contact']),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) => openBottomSheet(
                                        context,
                                        isUpdate: true,
                                        index: index,
                                        name: GetXClass.searchList[index]
                                            ['name'],
                                        contact: GetXClass.searchList[index]
                                            ['contact']),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'update',
                                        child: Text('Update'),
                                      ),
                                      PopupMenuItem(
                                        child: const Text('Delete'),
                                        onTap: () => HiveDatabase.deleteContact(
                                            id: GetXClass.contactsList[index]
                                                ['key']),
                                      ),
                                    ],
                                  ),
                                )
                              : ListTile(
                                  title: Text(
                                      GetXClass.contactsList[index]['name']),
                                  subtitle: Text(
                                      GetXClass.contactsList[index]['contact']),
                                  trailing: PopupMenuButton(
                                    onSelected: (value) => openBottomSheet(
                                        context,
                                        isUpdate: true,
                                        index: index,
                                        name: GetXClass.contactsList[index]
                                            ['name'],
                                        contact: GetXClass.contactsList[index]
                                            ['contact']),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'update',
                                        child: Text('Update'),
                                      ),
                                      PopupMenuItem(
                                        child: const Text('Delete'),
                                        onTap: () => HiveDatabase.deleteContact(
                                            id: GetXClass.contactsList[index]
                                                ['key']),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: GetXClass.isSearch.value
                        ? GetXClass.searchList.length
                        : GetXClass.contactsList.length)
                : const Center(child: Text('No result Found')),
          ),
          SizedBox(
            height: 145,
            child: Card(
              elevation: 8,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(width / 2, 28),
                bottomRight: Radius.elliptical(width / 2, 28),
              )),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  const Text(
                    'Hive Contact Book with GetX',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (value) => GetXClass.searching(value: value),
                        decoration: const InputDecoration(
                            fillColor: CupertinoColors.extraLightBackgroundGray,
                            filled: true,
                            hintText: 'Search Name or Contact',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFE5E5EA))),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openBottomSheet(BuildContext context,
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
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('Name')),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: contactController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('Contact')),
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
              child: const Text('Add Contact'))
        ]),
      ),
    );
  }
}
