import 'package:flutter/material.dart';

import '../../../config/app_url.dart';
import '../../../config/colors.dart';
import '../../../config/routes/routes_name.dart';

class ListViewFav extends StatelessWidget {
  final dynamic apiCoffee;
  final void Function()? onPress;
  
  const ListViewFav({super.key, this.apiCoffee, this.onPress});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          AppRoutesName.itemDetailView,
          arguments: apiCoffee,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.addMark.withOpacity(0.3), blurRadius: 4)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                AppUrl.image + apiCoffee['imageId'],  // Update with actual image URL
                height: height / 10,
                width: width / 5,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apiCoffee['coffeeName'] ?? 'Coffee Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width/2,
                  child: Text(
                    apiCoffee['details'] ?? 'Description',
                    style: TextStyle(color: AppColors.grey, fontSize: 12,overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap:onPress ,
              child: Icon(
                Icons.favorite,
                color: AppColors.submitColor,  // Always show as favorite
              ),
            ),
          ],
        ),
      ),
    );
  }
}
