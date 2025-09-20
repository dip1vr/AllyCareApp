import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Features/appointments/presentation/widgets/appointmentsSection.dart';
import '../../assessments/domain/Assessments.dart';
import '../presentation/screen/choose_service_screen.dart';
import '../presentation/widgets/appointment_card.dart';
import '../../shared_widget/stat_card.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.blue.shade800, 
          backgroundColor: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Hey Jane!",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.055,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text("👋", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Ready to crush your goals today?",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: screenWidth * 0.05,
                      backgroundColor: const Color(0xFFEDEAFF),
                      child: Text(
                        "J",
                        style: TextStyle(
                          color: const Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatCard(
                      icon: Icons.offline_bolt_outlined,
                      color: Colors.orange,
                      value: "7",
                      label: "days\nStreak",
                    ),
                    StatCard(
                      icon: Icons.track_changes_outlined,
                      color: Colors.blue.shade600,
                      value: "75",
                      label: "%\nGoal",
                    ),
                    StatCard(
                      icon: Icons.local_fire_department_outlined,
                      color: Colors.green.shade600,
                      value: "420",
                      label: "kcal\nCalories",
                    ),
                    StatCard(
                      icon: Icons.emoji_events_outlined,
                      color: Colors.purple.shade700,
                      value: "12",
                      label: "Badges\nEarned",
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const DashboardScreen(),
                              transition: Transition.leftToRight,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                            ),
                            child: Center(
                              child: Text(
                                "My Assessments",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4285F4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "My Appointments",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                const AppointmentsSection(),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Book Your Appointment",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const ServicesScreen(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_hospital,
                                  color: Colors.blue,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Cancer 2nd Opinion",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Expert oncology consultation\nGet a second opinion from leading cancer specialists",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const ServicesScreen(),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                child: AppointmentCard(
                                  cardcolor: const Color(0xFFF3E8FF),
                                  icon: Icons.accessibility_new,
                                  iconBgColor: Colors.white,
                                  iconColor: Colors.purple,
                                  title: "Physiotherapy Appointment",
                                  subtitle: "Movement & rehabilitation",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const ServicesScreen(),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                child: const AppointmentCard(
                                  cardcolor: Color(0xFFFFF4E5),
                                  icon: Icons.fitness_center,
                                  iconBgColor: Colors.white,
                                  iconColor: Colors.orange,
                                  title: "Book Appointment",
                                  subtitle: "Schedule your fitness session",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}