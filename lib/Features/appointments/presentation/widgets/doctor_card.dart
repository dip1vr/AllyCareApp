import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/Features/shared_widget/circular_shimmer.dart';

import '../screen/select_doctor_screen.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final bool isSelected;
  final VoidCallback onTap;
  final String? heroTag; // ✅ Optional Hero tag for animation

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isSelected ? Colors.blue : Colors.transparent;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Semantics(
      label:
          'Doctor ${doctor.name}, ${doctor.specialization}, ${doctor.rating} stars, ${doctor.experience} years experience',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: screenWidth * 0.3),
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2.5 : 0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(isSelected ? 0.3 : 0.15),
                spreadRadius: isSelected ? 2 : 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✅ Hero animation wrapper
                Hero(
                  tag: heroTag ?? doctor.imageUrl, // fallback if heroTag not provided
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: doctor.imageUrl,
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        alignment: Alignment.center,
                        color: Colors.grey[300],
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: const CircularShimmer(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),

                /// ✅ Doctor Info
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          color: const Color(0xFF131212),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: Colors.amber,
                            size: screenWidth * 0.04,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Flexible(
                            child: Text(
                              '${doctor.rating} (${doctor.reviews} reviews)',
                              style: TextStyle(
                                fontSize: screenWidth * 0.032,
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025,
                            ),
                            child: Text(
                              '•',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${doctor.experience} years exp',
                              style: TextStyle(
                                fontSize: screenWidth * 0.032,
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// ✅ Checkmark if selected
                if (isSelected)
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.005),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: screenWidth * 0.045,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
