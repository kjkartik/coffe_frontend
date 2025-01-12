import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:coffee_app_bloc/view/home/widget/show_image.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/images.dart';

class CoffeeListView extends StatelessWidget {
  final VoidCallback onPress;
  final String heading;
  final String subHeading;
  final String amount;
  final String ratting;
  final String imageId;

  const CoffeeListView(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.amount,
      required this.ratting,
      required this.onPress, required this.imageId});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 9,
      ),

      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.addMark.withOpacity(0.5), blurRadius: 1),
          ],
          borderRadius: BorderRadius.circular(21)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 11,horizontal: 9),
            child: SingleChildScrollView(physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      InkWell(
                        child: Container(
                            height: height / 7.6,
                            width: width / 2.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(41)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(31),
                              child:  Image.network(AppUrl.image+imageId,errorBuilder: (buildContext, object, stackTrace){
                                return Image.asset(
                                      AppImages.coffe,
                                      fit: BoxFit.fill,
                                    );

                              },)

                            )),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ImageAlertBox(imageUrl: AppUrl.image + imageId);
                            },
                          );
                        },

                      ),
                      Container(
                        height: 27,
                        width: width / 5.5,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              // Diagonal gradient direction
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF5A5A5A),
                                // Lighter gray tone
                                Color(0xFF1A1A1A),
                                // Darker gray tone
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(21),
                                topRight: Radius.circular(31))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.submitColor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "$ratting ",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    heading,
                    style: TextStyle(
                        color: AppColors.textColorh1,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  // const SizedBox(height:1,),
                  Text(
                    " $subHeading",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColorh1.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        " \$",
                        style: TextStyle(
                            color: AppColors.submitColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                            color: AppColors.textColorh1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onPress,
                child: Container(
                  height: height / 17,
                  width: width / 8,
                  decoration: BoxDecoration(
                    color: AppColors.addMark,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(31),
                      bottomRight: Radius.circular(21),
                    ),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: AppColors.white,
                    size: 32,
                    weight: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
