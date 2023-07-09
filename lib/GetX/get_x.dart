import 'package:get/get.dart';
import 'package:hive_dbms/Hive%20Database/hive_database.dart';

class GetXClass extends GetxController {
  @override
  void onInit() {
    super.onInit();
    HiveDatabase.viewContacts();
  }

  static RxList contactsList = [].obs;
  static RxList searchList = [].obs;
  static RxBool isSearch = false.obs;

  static searching({required String value}) {
    isSearch.value = value.isNotEmpty;
    if (isSearch.value) {
      searchList.clear();
      for (var i in contactsList) {
        if (i['name'].contains(value) || i['contact'].contains(value)) {
          searchList.add(i);
        }
      }
    }
  }
}
