import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'select_doctor_screen.dart';

// Model
class Service {
  final String title;
  final String description;
  final String price;
  final String duration;
  final IconData icon;

  const Service({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.icon,
  });
}

// Controller
class ServicesController extends GetxController {
  var services = <Service>[
    const Service(
      title: 'General Consultation',
      description: 'Complete health checkup with experienced doctors',
      price: '\$75',
      duration: '30 min',
      icon: Icons.favorite_border,
    ),
    const Service(
      title: 'Physical Therapy',
      description: 'Rehabilitation and movement therapy sessions',
      price: '\$85',
      duration: '45 min',
      icon: Icons.show_chart_sharp,
    ),
    const Service(
      title: 'Fitness Coaching',
      description: 'Personal training and fitness guidance',
      price: '\$65',
      duration: '60 min',
      icon: Icons.calendar_today_outlined,
    ),
  ].obs;
}

// UI
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicesController controller = Get.put(ServicesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Doctor"),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            return _ServiceCard(service: controller.services[index]);
          },
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Service service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(service.icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 10),
               // In ServicesScreen, _ServiceCard widget
SizedBox(
  height: 30,
  child: ElevatedButton(
    onPressed: () {
      Get.to(
        () => DoctorSelectionScreen(service: service), // Pass the selected service
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
    ),
    child: const Text(
      'Book Now',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                service.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                service.duration,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
