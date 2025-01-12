import 'dart:io';

import 'package:coffee_app_bloc/blocs/get_items.dart';
import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:coffee_app_bloc/config/utils/sharePreferance/share_pref.dart';
import 'package:coffee_app_bloc/view/home/widget/bottom_card.dart';
import 'package:coffee_app_bloc/view/home/widget/search_filled.dart';
import 'package:coffee_app_bloc/view/home/widget/tap_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/icons.dart';
import '../../config/images.dart';
import '../../viewModel/get_item_view_model/item_view_model.dart';
import 'widget/coffee_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController? _tabController;
  String selectedCoffeeType = "All";
  List<dynamic> filteredData = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    // Fetch data on initialization
    final itemDataBloc = context.read<ItemBloc>();
    ItemViewModel(itemDataBloc).getAllItem();
  }

  void filterData(String coffeeType, dynamic data) {
    if (coffeeType == "All") {
      filteredData = data["data"];
    } else {
      filteredData = data["data"].where((item) {
        return item["coffeeType"] == coffeeType;
      }).toList();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemSuccessState && _tabController == null) {
            final uniqueCoffeeTypes = <String>{};
            final uniqueData = state.response["data"].where((item) {
              final coffeeType = item["coffeeType"] ?? "Cappuccino";
              if (uniqueCoffeeTypes.contains(coffeeType)) {
                return false;
              } else {
                uniqueCoffeeTypes.add(coffeeType);
                return true;
              }
            }).toList();

            _tabController = TabController(
              vsync: this,
              length: uniqueCoffeeTypes.length + 1, // +1 for "All"
            );

            filteredData = state.response["data"];
          }
        },
        builder: (context, state) {
          if (state is ItemLoadingState || _tabController == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ItemSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [

                      Container(
                        height: height / 5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF5A5A5A),
                              Color(0xFF1A1A1A),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height/18,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 21),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Mohali, India",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            AppIcons.downIcon,
                                            color: AppColors.white,
                                            size: 23,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: _image == null
                                        ? Image.asset(
                                      AppImages.profile,
                                      height: height / 12,
                                    )
                                        : Image.file(
                                      File(_image!.path),
                                      height: height / 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 41),
                  TapBarView(
                    tabController: _tabController!,
                    data: state.response["data"],
                    selectedCoffeeType: selectedCoffeeType,
                    onPress: (index) {
                      setState(() {
                        selectedCoffeeType = index == 0
                            ? "All"
                            : state.response["data"][index+3]["coffeeType"];
                      });
                      filterData(selectedCoffeeType, state.response);
                    },
                  ),
                  SizedBox(height: height / 21),
                  filteredData.isNotEmpty
                      ? SizedBox(
                    height: height / 3.8,
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CoffeeListView(
                        heading: filteredData[index]["coffeeName"],
                        subHeading: filteredData[index]["coffeeNature"],
                        amount: filteredData[index]["price"]["medium"]
                            .toString(),
                        ratting: filteredData[index]["rating"].toString(),
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesName.itemDetailView,
                            arguments: filteredData[index],
                          );
                        },
                        imageId:
                        filteredData[index]["imageId"].toString(),
                      ),
                    ),
                  )
                      : const Center(child: Text("No data available")),
                  SizedBox(height: height / 31),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 21),
                        child: Text(
                          "Special for you",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 21),
                      if (filteredData.isNotEmpty)
                        BottomCard(data: filteredData[0]),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


