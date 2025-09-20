import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircularShimmer extends StatelessWidget {
  final double? size; // optional, agar specify karna ho
  const CircularShimmer({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final double finalSize = size ?? 24; // default 24 if not provided
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: finalSize,
          height: finalSize,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
