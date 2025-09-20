// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Features/assessments/presentation/widgets/challengs_card.dart';
import 'package:project/Features/shared_widget/stat_card.dart';
import '../../appointments/domain/Appointments.dart';
import '../presentation/screen/fitness_assess.dart';
import '../presentation/screen/health_assess.dart';
import '../presentation/widgets/assessment_card.dart' hide ChallengeCard;


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
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
                            SizedBox(width: screenWidth * 0.015),
                            const Text("👋", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.005),
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
                  borderRadius: BorderRadius.circular(screenWidth * 0.075),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4285F4),
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.075,
                            ),
                          ),
                          child: Text(
                            "My Assessments",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const Appointment(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                            ),
                            child: Text(
                              "My Appointments",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Assessment",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Container(
                              padding: EdgeInsets.all(screenWidth * 0.015),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0C2340),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size: screenWidth * 0.04,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    AssessmentCard(
                      title: "Fitness Assessment",
                      description:
                          "Discover your fitness level with our AI-powered assessment",
                      imageUrl:
                          "https://plus.unsplash.com/premium_photo-1674421795169-e4550d50ece2?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      color: const Color(0xFF4285F4),
                      text: "Start Now",
                      onPressed: () {
                        Get.to(() => const FitnessAssessmentScreen());
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    AssessmentCard(
                      title: "Health Risk Assessment",
                      description:
                          "Identify potential health risks with comprehensive screening",
                      imageUrl:
                          "https://images.unsplash.com/photo-1535914254981-b5012eebbd15?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      color: const Color(0xFF00C9A7),
                      text: "Start Now",
                      onPressed: () {
                        Get.to(() => const HealthAssessmentScreen());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Challenges",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.035,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C2340),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              ChallengeCard(),
              SizedBox(height: screenHeight * 0.01),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Workout Routines",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.035,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C2340),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: screenWidth * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: AssessmentCard(
                        title: "Sweat Starter",
                        description: "Full Body",
                        imageUrl:
                            "https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg",
                        color: Colors.deepPurple,
                        text: "Lose Weight",
                        difficulty: "Medium",
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: AssessmentCard(
                        title: "Plank Hold",
                        description: "Plank for 30 seconds",
                        imageUrl:
                            "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg",
                        color: Colors.orange,
                        text: "Lose Weight",
                        difficulty: "Easy",
                        difficultyColor: Colors.blueAccent,
                        onPressed: () {},
                      ),
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
