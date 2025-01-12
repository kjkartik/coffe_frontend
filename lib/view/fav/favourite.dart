import 'dart:convert';
import 'dart:developer';
import 'package:coffee_app_bloc/view/fav/widget/list_view_fav.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/images.dart';
import 'package:coffee_app_bloc/config/app_url.dart';
import '../../config/routes/routes_name.dart';
import '../../config/utils/showMessage/snack_bar.dart';
import '../../repostory/getItem/item_http_api_repository.dart';
import '../../repostory/getItem/item_repo.dart';
import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteCoffees = [];
  List<dynamic> apiCoffees = [];
  ItemRepo itemRepo = GetItemHttpApiRepository();

  // Fetch API Data
  Future<void> getApiData() async {
    var data = await itemRepo.getItems(AppUrl.getItem);

    setState(() {
      apiCoffees = data['data'];
    });
  }

  // Fetch local data from the database
  Future<void> getLocalData() async {
    var data = await dbHelper
        .getAllDataAsMapFav(); // Fetching data from local database
    setState(() {
      favoriteCoffees = data.entries
          .map((entry) => {
                'coffeeName': entry.key,
                'details':
                    entry.value, // Assuming the value contains coffee details
              })
          .toList();
    });
    log("Local Data: $favoriteCoffees");
  }

  // Delete item from local database
  void deleteItem(String coffeeName) {
    dbHelper.deleteDataFav(coffeeName);
    getApiData();
    getLocalData();
  }

  @override
  void initState() {
    super.initState();

    // Fetch both API data and local database data
    getApiData();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: favoriteCoffees.isEmpty
            ? Center(child: Image.asset(AppImages.emptyGif))
            : ListView.builder(
                itemCount: favoriteCoffees.length, // Show all favorite coffees
                itemBuilder: (context, index) {
                  var favorite = favoriteCoffees[index];

                  // Find corresponding API coffee for the favorite item
                  var apiCoffee = apiCoffees.firstWhere(
                    (apiCoffee) =>
                        apiCoffee['coffeeName'] == favorite['coffeeName'],
                    orElse: () => null, // If no match, return null
                  );

                  // If no match, skip this item
                  if (apiCoffee == null) return SizedBox();

                  return ListViewFav(
                    apiCoffee: apiCoffee,
                    onPress: () {
                      MessageUtils.error(context: context, message:apiCoffee["coffeeName"]+ " Remove Successfully" );

                      deleteItem(apiCoffee['coffeeName']);
                    },
                  );
                },
              ),
      ),
    );
  }
}
