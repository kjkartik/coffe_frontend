




import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';
import 'package:flutter/material.dart';
import '../../../config/colors.dart';
import '../../../config/icons.dart';
import '../../../config/images.dart';
import '../../../config/utils/showMessage/snack_bar.dart';
import 'helper_widget.dart';

class CoffeeCardView extends StatefulWidget {
    final  int tabIndex ;
    final  dynamic data ;
   const CoffeeCardView({super.key ,required this.tabIndex, this.data});

  @override
  State<CoffeeCardView> createState() => _CoffeeCardViewState();
}

class _CoffeeCardViewState extends State<CoffeeCardView> {

  bool isFavCoffee = false;

  @override
  void initState(){
   Future.microtask(()async{
     isFavCoffee = await dbHelper.keyExists(widget.data["coffeeName"]);

     print("isFavCoffee ${isFavCoffee}");

     setState(() {

     });
   });
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return    Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(63),
        child: Container(
          height: height / 2.5,
          width: width / 1.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(AppUrl.image + widget.data["imageId"]),
              fit: BoxFit.fill,
              onError: (exception, stackTrace) {
                // Handle the error
              },
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 41),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconBackground(
                      context: context,
                      icon: AppIcons.back,
                      onPress: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    iconBackground(
                      context: context,
                      color: AppColors.redColor,
                      icon:isFavCoffee ==true ? AppIcons.fav1 : AppIcons.fav,
                      onPress: () async {

                        if(await dbHelper.keyExists(widget.data["coffeeName"])){
                          MessageUtils.error(context: context, message: "Coffee Remove Successfully");
                          dbHelper.deleteDataFav(widget.data["coffeeName"]);

                          setState(() {
                            isFavCoffee = false;
                          });
                          return;
                        }
                        MessageUtils.success(context: context, message: "Coffee Added Successfully");
                        await dbHelper.saveFav(widget.data["coffeeName"].toString(), {"data":widget.data});
                        isFavCoffee = true;
                          setState(() {});



                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: height / 8,
                padding: const EdgeInsets.only(top: 11),
                decoration: BoxDecoration(
                  color: AppColors.addMark.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(31),
                    topRight: Radius.circular(31),
                    bottomRight: Radius.circular(71),
                    bottomLeft: Radius.circular(71),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data["coffeeName"],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white),
                        ),
                        Text(
                          widget.tabIndex == 0
                              ? "With chocolate"
                              : widget.tabIndex == 1
                              ? "Milk Chocolate"
                              : "Dark Chocolate",
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.white.withOpacity(0.8)),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          children: [
                            Icon(
                              AppIcons.star,
                              color: AppColors.submitColor,
                              size: 19,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              widget.data["rating"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppColors.white),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "(${widget.data["totalRating"].toString()})",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.white.withOpacity(0.7)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: width / 9,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  AppImages.coffeeIcons,
                                  height: height / 31,
                                  color: AppColors.white,
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  "Coffee",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      AppColors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 21,
                            ),
                            Column(
                              children: [
                                Image.asset(AppImages.dropIcon,
                                    color: AppColors.white,
                                    height: height / 31),
                                const SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  "Chocolate",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      AppColors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.data["coffeeNature"],
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

    Future<IconData> favIcon(String coffeeName) async {
      // Check if the key exists in the database
      bool exists = await dbHelper.keyExists(coffeeName);

      // Return the appropriate icon based on whether the key exists
      return exists ? AppIcons.fav1 : AppIcons.fav;
    }
}
