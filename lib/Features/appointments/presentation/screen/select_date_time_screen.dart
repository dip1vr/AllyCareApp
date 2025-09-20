// lib/Features/assessments/presentation/screen/select_date_time_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'choose_service_screen.dart'; // Import Service class
import 'select_doctor_screen.dart'; // Import Doctor class
import 'confirm_appointment_screen.dart';

final List<String> availableTimes = [
  '09:00 AM', '09:30 AM', '10:00 AM',
  '10:30 AM', '11:00 AM', '11:30 AM',
  '02:00 PM', '02:30 PM', '03:00 PM',
  '03:30 PM', '04:00 PM', '04:30 PM',
];

const Color primaryPurple = Colors.blue;
const Color accentMagenta = Colors.cyan;
const Color lightPurpleBackground = Color(0xFFEDE7F6);

class AppointmentPickerUI extends StatefulWidget {
  final Service service;
  final Doctor doctor;
  final String? heroTag; // ✅ Added heroTag

  const AppointmentPickerUI({
    super.key,
    required this.service,
    required this.doctor,
    this.heroTag, // ✅ optional heroTag
  });

  @override
  State<AppointmentPickerUI> createState() => _AppointmentPickerUIState();
}

class _AppointmentPickerUIState extends State<AppointmentPickerUI> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedTime = availableTimes[7];
  }

  void _bookAppointment() {
    if (_selectedTime != null) {
      String formattedDate =
          DateFormat('EEEE, MMM d, yyyy').format(_selectedDay);

      Get.to(
        () => ConfirmAppointmentScreen(
          service: widget.service,
          doctor: widget.doctor,
          selectedDate: formattedDate,
          selectedTime: _selectedTime!,
        ),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both a Date and a Time.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Hero Image with passed heroTag
                Center(
                  child: Hero(
                    tag: widget.heroTag ?? widget.doctor.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.doctor.imageUrl,
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Doctor Info
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.doctor.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.doctor.specialization,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                const Text(
                  'Select Date & Time',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: primaryPurple,
                  ),
                ),
                const SizedBox(height: 25),
                _buildCalendar(),
                const SizedBox(height: 30),
                const Text(
                  'Available Times',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                _buildTimeSlots(),
                const SizedBox(height: 35),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        leftChevronIcon:
            const Icon(Icons.chevron_left, color: primaryPurple, size: 28),
        rightChevronIcon:
            const Icon(Icons.chevron_right, color: primaryPurple, size: 28),
        headerPadding: const EdgeInsets.only(bottom: 10),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),
        weekendStyle:
            TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade600),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: primaryPurple,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          final isSelected = isSameDay(day, _selectedDay);
          return Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? primaryPurple : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected
                  ? null
                  : Border.all(color: accentMagenta, width: 1.5),
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : primaryPurple,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: availableTimes.map((time) {
        final isSelected = time == _selectedTime;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTime = time;
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? lightPurpleBackground : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? primaryPurple : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: primaryPurple.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? primaryPurple : Colors.black87,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContinueButton() {
    return InkWell(
      onTap: _bookAppointment,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [primaryPurple, accentMagenta],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryPurple.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Confirm Appointment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
