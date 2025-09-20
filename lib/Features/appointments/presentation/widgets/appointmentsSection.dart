import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'appointment_status.dart';
import 'appointmer_card_shimmer.dart'; 

class AppointmentsSection extends StatefulWidget {
  const AppointmentsSection({super.key});

  @override
  _AppointmentsSectionState createState() => _AppointmentsSectionState();
}

class _AppointmentsSectionState extends State<AppointmentsSection> {
  Stream<QuerySnapshot>? _appointmentsStream;

  @override
  void initState() {
    super.initState();
    _updateStream();
  }

  void _updateStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _appointmentsStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('appointments')
          .orderBy('created_at', descending: true)
          .snapshots();
    } else {
      _appointmentsStream = null;
    }
  }

  void refreshStream() {
    setState(() {
      _updateStream();
    });
  }

  String _getDoctorImageUrl(String doctorName) {
    const Map<String, String> doctorImages = {
      'Dr. Sarah Johnson':
          'https://plus.unsplash.com/premium_photo-1682141142889-218debf4f8dc?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'Dr. Michael Chen':
          'https://images.unsplash.com/photo-1582750433449-648ed127bb54?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'Dr. Emma Wilson':
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    };
    return doctorImages[doctorName] ??
        'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg';
  }
  IconData _getAppointmentIcon(String type) {
    if (type == 'Video Consultation') {
      return Icons.videocam_outlined;
    } else if (type == 'In-Person') {
      return Icons.location_on_outlined;
    }
    return Icons.event;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Appointments",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
               
                },
                child: Row(
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
                    const SizedBox(width: 8),
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
              ),
            ],
          ),
          const SizedBox(height: 8),
          StreamBuilder<QuerySnapshot>(
            stream: _appointmentsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: List.generate(
                    2,
                    (_) => const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: AppointmentStatusShimmer(),
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading appointments'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Book an appointment now!', style: TextStyle(color: Colors.black , fontSize: 16, fontWeight: FontWeight.bold),
                ),
                
                 );
              }

              final appointments = snapshot.data!.docs;

              return SizedBox(
                height: appointments.length > 2 ? 240 : null,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: appointments.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final appointment = appointments[index].data() as Map<String, dynamic>;
                    return AppointmentStatus(
                      doctorName: appointment['doctor_name'] ?? 'Unknown Doctor',
                      specialty: appointment['doctor_specialization'] ?? 'Unknown Specialty',
                      date: appointment['date'] ?? 'Unknown Date',
                      time: appointment['time'] ?? 'Unknown Time',
                      type: appointment['type'] ?? 'Unknown Type',
                      icon: _getAppointmentIcon(appointment['type'] ?? 'Unknown Type'),
                      rating: appointment['doctor_rating']?.toString() ?? '0.0',
                      imageUrl: _getDoctorImageUrl(appointment['doctor_name'] ?? ''),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}