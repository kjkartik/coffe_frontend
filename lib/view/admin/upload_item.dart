import 'dart:io';

import 'package:coffee_app_bloc/config/app_url.dart';
import 'package:coffee_app_bloc/config/utils/sharePreferance/share_pref.dart';
import 'package:coffee_app_bloc/config/utils/showMessage/snack_bar.dart';
import 'package:coffee_app_bloc/view/admin/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../config/colors.dart';


class UploadItemScreen extends StatefulWidget {
  const UploadItemScreen({super.key});

  @override
  State<UploadItemScreen> createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _coffeeTypeController = TextEditingController();
  final TextEditingController _coffeeNameController = TextEditingController();
  final TextEditingController _coffeeNatureController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _smallPriceController = TextEditingController();
  final TextEditingController _mediumPriceController = TextEditingController();
  final TextEditingController _largePriceController = TextEditingController();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _uploadCoffeeItem() async {
    if (_coffeeTypeController.text.isEmpty ||
        _coffeeNameController.text.isEmpty ||
        _coffeeNatureController.text.isEmpty ||
        _detailsController.text.isEmpty ||
        _smallPriceController.text.isEmpty ||
        _mediumPriceController.text.isEmpty ||
        _largePriceController.text.isEmpty ||
        _image == null) {
      MessageUtils.error(context: context, message: "Please fill all fields and select an image.");

      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.100.2:8002/api/admin/uploadItem'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer ${authManager.getData("tokenAdmin")}', // Replace with actual JWT token
      });

      request.fields['coffeeType'] = _coffeeTypeController.text;
      request.fields['coffeeName'] = _coffeeNameController.text;
      request.fields['coffeeNature'] = _coffeeNatureController.text;
      request.fields['details'] = _detailsController.text;
      request.fields['price'] = '{"large":${_largePriceController.text},"medium":${_mediumPriceController.text},"small":${_smallPriceController.text}}';

      final imageFile = await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(imageFile);

      final response = await request.send();

      if (response.statusCode == 200) {
        _showSuccessDialog("Coffee item uploaded successfully!");
      } else {
        _showErrorDialog("Failed to upload coffee item.");
      }
    } catch (e) {
      _showErrorDialog("Error uploading item: $e");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Extracted method for creating text fields


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle:  true  ,
        title: const Text('Upload Coffee Item'),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use the extracted method to create text fields
              buildTextField(
                label: 'Coffee Type',
                controller: _coffeeTypeController,
                hintText: 'Enter coffee type',
              ),
              buildTextField(
                label: 'Coffee Name',
                controller: _coffeeNameController,
                hintText: 'Enter coffee name',
              ),
              buildTextField(
                label: 'Coffee Nature',
                controller: _coffeeNatureController,
                hintText: 'Enter coffee nature (e.g. Strong, Mild)',
              ),
              buildTextField(
                label: 'Details',
                controller: _detailsController,
                hintText: 'Enter coffee details',
              ),
              buildTextField(
                label: 'Small Price',
                controller: _smallPriceController,
                hintText: 'Enter small size price',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              buildTextField(
                label: 'Medium Price',
                controller: _mediumPriceController,
                hintText: 'Enter medium size price',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              buildTextField(
                label: 'Large Price',
                controller: _largePriceController,
                hintText: 'Enter large size price',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 20),
              const Text(
                'Select Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),border: Border.all(color: AppColors.submitColor)),
                  width: double.infinity,
                  height: 200,
                  // color: AppColors.grey,
                  child: _image == null
                      ? const Center(child: Text('Tap to select image'))
                      : Image.file(
                    File(_image!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isUploading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _uploadCoffeeItem,
                child: Text('Upload Item',style: TextStyle(color: AppColors.white),),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(AppColors.submitColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
