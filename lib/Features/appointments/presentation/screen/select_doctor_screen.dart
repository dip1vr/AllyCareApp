import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'choose_service_screen.dart';
import '../widgets/doctor_card.dart';
import 'select_date_time_screen.dart';

class Doctor {
  final String name;
  final String specialization;
  final double rating;
  final int reviews;
  final int experience;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.imageUrl,
  });
}

class DoctorSelectionScreen extends StatefulWidget {
  final Service service;
  const DoctorSelectionScreen({super.key, required this.service});

  @override
  State<DoctorSelectionScreen> createState() => _DoctorSelectionScreenState();
}

class _DoctorSelectionScreenState extends State<DoctorSelectionScreen> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Sarah Johnson',
      specialization: 'Cardiologist',
      rating: 4.9,
      reviews: 234,
      experience: 8,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1682141142889-218debf4f8dc?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Doctor(
      name: 'Dr. Michael Chen',
      specialization: 'Physiotherapist',
      rating: 4.8,
      reviews: 189,
      experience: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1582750433449-648ed127bb54?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Doctor(
      name: 'Dr. Emma Wilson',
      specialization: 'Fitness Coach',
      rating: 4.9,
      reviews: 156,
      experience: 5,
      imageUrl:
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text("Select Doctor"),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 120),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return DoctorCard(
                      doctor: doctor,
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      // ✅ Wrap Doctor image with Hero inside DoctorCard
                      heroTag: 'doctorImage-$index',
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedIndex != null
                      ? () {
                          Get.to(
                            () => AppointmentPickerUI(
                              service: widget.service,
                              doctor: doctors[selectedIndex!],
                              heroTag:
                                  'doctorImage-$selectedIndex', 
                            ),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 300),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    splashFactory: NoSplash.splashFactory,
                    animationDuration: Duration.zero,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
