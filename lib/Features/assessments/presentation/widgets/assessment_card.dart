import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:project/Features/shared_widget/circular_shimmer.dart';

class AssessmentCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color color;
  final String text;
  final String? difficulty;
  final VoidCallback onPressed;
  final Color? difficultyColor;

  const AssessmentCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.color,
    required this.text,
    this.difficulty,
    this.difficultyColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AssessmentCard> createState() => _AssessmentCardState();
}

class _AssessmentCardState extends State<AssessmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fillAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 6.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onPressed();
        _controller.reset();
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: screenWidth * 0.015,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(screenWidth * 0.05),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              height: screenWidth * 0.4,
              width: screenWidth * 0.3,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: screenWidth * 0.4,
                width: screenWidth * 0.3,
                color: Colors.grey[300],
                child: const Center(child: CircularShimmer()),
              ),
              errorWidget: (context, url, error) => Container(
                height: screenWidth * 0.4,
                width: screenWidth * 0.3,
                color: Colors.grey,
                child: const Center(
                  child: Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.033,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.difficulty != null &&
                      widget.text == "Lose Weight") ...[
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: screenWidth * 0.015,
                            offset: const Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Difficulty: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.033,
                              ),
                            ),
                            TextSpan(
                              text: "${widget.difficulty}",
                              style: TextStyle(
                                color: widget.difficultyColor ?? Colors.red,
                                fontSize: screenWidth * 0.033,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: _handleTap,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenWidth * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.05,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF1976D2).withOpacity(0.9),
                                  Colors.white.withOpacity(0.9),
                                ],
                                stops: [
                                  _fillAnimation.value,
                                  _fillAnimation.value,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1976D2)
                                      .withOpacity(0.3),
                                  blurRadius: _glowAnimation.value,
                                  spreadRadius: _glowAnimation.value / 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(screenWidth * 0.015),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1976D2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  widget.text,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.035,
                                    color: _fillAnimation.value > 0.5
                                        ? Colors.white
                                        : const Color(0xFF1976D2),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String challengeTitle;
  final String challengeText;
  final double progressValue;
  final String progressText;
  final VoidCallback? onContinuePressed;

  const ChallengeCard({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    this.challengeTitle = "Today's Challenge!",
    this.challengeText = 'Push Up 20x',
    this.progressValue = 0.5,
    this.progressText = '10/20 Complete',
    this.onContinuePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.greenAccent[100],
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challengeTitle,
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  child: Text(
                    challengeText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFF06292),
                  ),
                  minHeight: screenHeight * 0.01,
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  progressText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                ElevatedButton(
                  onPressed: onContinuePressed ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.075),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_circle_fill, size: screenWidth * 0.05),
                      SizedBox(width: screenWidth * 0.015),
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/challenge.png',
            height: screenWidth * 0.25,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
