import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_dbms/GetX/get_x.dart';
import 'package:hive_dbms/Hive%20Database/hive_database.dart';
import 'package:hive_dbms/Widgets/App%20Bar/custom_appbar.dart';
import 'package:hive_dbms/Widgets/TextFields.dart';
import 'package:hive_dbms/Widgets/method.dart';
import 'package:hive_dbms/Widgets/tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Methods.openBottomSheet(context),
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
                    itemBuilder: (context, index) => GetXClass.isSearch.value
                        ? CustomTile(
                            index: index,
                            titleText: GetXClass.searchList[index]['name'],
                            subTitleText: GetXClass.searchList[index]
                                ['contact'])
                        : CustomTile(
                            index: index,
                            titleText: GetXClass.contactsList[index]['name'],
                            subTitleText: GetXClass.contactsList[index]
                                ['contact']),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: GetXClass.isSearch.value
                        ? GetXClass.searchList.length
                        : GetXClass.contactsList.length)
                : const Center(child: Text('No result Found')),
          ),
          CustomAppBar(appBarHeight: 145, screenWidth: width),
        ],
      ),
    );
  }


}
