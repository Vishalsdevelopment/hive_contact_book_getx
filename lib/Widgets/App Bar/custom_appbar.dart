import 'package:flutter/material.dart';
import 'package:hive_dbms/Widgets/TextFields.dart';

class CustomAppBar extends StatelessWidget {
  final double appBarHeight;
  final double screenWidth;

  const CustomAppBar({
    super.key,
    required this.appBarHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appBarHeight,
      child: Card(
        elevation: 8,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(screenWidth / 2, 28),
          bottomRight: Radius.elliptical(screenWidth / 2, 28),
        )),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Hive Contact Book with GetX',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: SearchingContact(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
