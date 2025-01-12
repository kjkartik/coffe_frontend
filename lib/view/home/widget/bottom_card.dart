import 'package:coffee_app_bloc/view/home/widget/show_image.dart';
import 'package:flutter/material.dart';

import '../../../config/app_url.dart';
import '../../../config/colors.dart';
import '../../../config/images.dart';

class BottomCard extends StatelessWidget {
  final dynamic data;
  const BottomCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 17),
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 9),
      decoration: BoxDecoration(
          color: AppColors.addMark,
          borderRadius: BorderRadius.circular(21)),
      child: Row(
        children: [
          InkWell(
            child: SizedBox(
             height: height/7,
              width: width / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(AppUrl.image + data["imageId"],errorBuilder: (_,__,___){
                  return  Image.asset(
                    AppImages.coffe,
                    fit: BoxFit.fill,
                  );
                },)
              ),
            ),
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ImageAlertBox(imageUrl: AppUrl.image + data["imageId"]);
                },
              );
            },
          ),
          SizedBox(
            width: width / 21,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Specially mixed and \nbrewed which you \nmust try!",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: height/51,),
              Row(
                children: [
                  Text(
                    "\$${data["price"]["medium"]}",
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    "\$${data["price"]["medium"]+14}",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.white.withOpacity(0.4),
                        fontWeight: FontWeight.w700,
                        fontSize: 11.8,
                        decorationColor:
                        AppColors.white.withOpacity(0.4)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
