import 'package:flutter/material.dart';
import 'package:coffee_app_bloc/config/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Notifications',style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: 1,  // Dummy notifications count
          itemBuilder: (context, index) {
            return Card(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(

                leading: Icon(Icons.notifications, color: AppColors.submitColor),
                title: Text('Notification ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('This is the details of notification number ${index + 1}.'),
                // trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle tap
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
