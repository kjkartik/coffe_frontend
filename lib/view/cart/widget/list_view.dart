import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_url.dart';
import '../../../config/colors.dart';
import 'helper_widget.dart';

class CoffeeCard extends StatelessWidget {
  final Map<String, dynamic> coffeeData;
  final int quantity;
  final Function() onAdd;
  final Function() onSubtract;
  final Function() onTap;
  final Function() onDelete;
  final bool isSelected;
  final Function() onSelectToggle;

  const CoffeeCard({
    super.key,
    required this.coffeeData,
    required this.quantity,
    required this.onAdd,
    required this.onSubtract,
    required this.onTap,
    required this.isSelected,
    required this.onSelectToggle, required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          height: height / 7,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onSelectToggle,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.addMark),
                    color: isSelected ? AppColors.addMark : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: isSelected ? AppColors.white : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: height / 9,
                width: width / 4,
                margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(41),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31),
                  child: Image.network(
                    AppUrl.image + coffeeData["imageId"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            coffeeData["coffeeName"],
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onDelete ,
                          child: Icon(
                            Icons.delete,
                            color: AppColors.deleteColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "US \$${coffeeData['price']["medium"]}",
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          "Delivery fee US \$2",
                          style: TextStyle(color: AppColors.deleteColor, fontSize: 11),
                        ),
                        const SizedBox(width: 21),
                        addMethod(onPress: onAdd),
                        const SizedBox(width: 11),
                        Text(
                          quantity.toString(),
                          style: TextStyle(color: AppColors.black, fontSize: 15),
                        ),
                        const SizedBox(width: 11),
                        subtractMethod(onPress: onSubtract),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
