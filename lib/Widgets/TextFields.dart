import 'package:flutter/material.dart';
import 'package:hive_dbms/GetX/get_x.dart';

class SearchingContact extends StatelessWidget {
  const SearchingContact({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: (value) => GetXClass.searching(value: value),
      decoration: const InputDecoration(
          fillColor: Color(0xFFEFEFF4),
          filled: true,
          hintText: 'Search Name or Contact',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E5EA))),
          border: OutlineInputBorder()),
    );
  }
}

class InputData extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String? labelText;
  InputData({super.key,required this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Name')),
    );
  }
}

