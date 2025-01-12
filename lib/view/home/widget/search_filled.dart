import 'package:flutter/material.dart';
import '../../../config/colors.dart';

class SearchFilled extends StatelessWidget {
  const SearchFilled({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: height / 18,
        width: width / 1.2,
        padding: const EdgeInsets.only(left: 11, right: 7),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              size: 27,
            ),
            SizedBox(width: width / 41),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: "Search Coffee",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.submitColor,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Center(
                child:  Icon(
                  Icons.tune,
                  size: 21,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
