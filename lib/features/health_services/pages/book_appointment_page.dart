import 'package:flutter/material.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  String selectedSpecialty = '';
  String selectedDoctor = '';
  String selectedDate = '';
  String selectedTime = '';
  String appointmentType = 'In-Person';

  final List<Map<String, dynamic>> specialties = [
    {
      'name': 'General Physician',
      'icon': Icons.medical_services,
      'doctors': 12,
    },
    {'name': 'Cardiologist', 'icon': Icons.favorite, 'doctors': 8},
    {'name': 'Dermatologist', 'icon': Icons.healing, 'doctors': 6},
    {'name': 'Orthopedic', 'icon': Icons.accessibility, 'doctors': 10},
    {'name': 'Pediatrician', 'icon': Icons.child_care, 'doctors': 7},
    {'name': 'Gynecologist', 'icon': Icons.pregnant_woman, 'doctors': 5},
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Rajesh Kumar',
      'specialty': 'General Physician',
      'rating': 4.8,
      'experience': '15 years',
      'fee': '₹500',
      'nextAvailable': 'Today 2:30 PM',
    },
    {
      'name': 'Dr. Priya Sharma',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'experience': '12 years',
      'fee': '₹800',
      'nextAvailable': 'Today 4:00 PM',
    },
    {
      'name': 'Dr. Amit Patel',
      'specialty': 'Dermatologist',
      'rating': 4.7,
      'experience': '10 years',
      'fee': '₹600',
      'nextAvailable': 'Tomorrow 10:00 AM',
    },
  ];

  final List<String> timeSlots = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
    '5:00 PM',
    '5:30 PM',
    '6:00 PM',
    '6:30 PM',
    '7:00 PM',
    '7:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: Colors.green.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Book Your Appointment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Schedule a consultation with our qualified healthcare professionals',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Appointment Type Selection
            const Text(
              'Appointment Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildAppointmentTypeCard(
                    'In-Person',
                    'Visit clinic physically',
                    Icons.location_on,
                    appointmentType == 'In-Person',
                    () => setState(() => appointmentType = 'In-Person'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildAppointmentTypeCard(
                    'Video Call',
                    'Online consultation',
                    Icons.videocam,
                    appointmentType == 'Video Call',
                    () => setState(() => appointmentType = 'Video Call'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Specialty Selection
            const Text(
              'Select Specialty',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                final specialty = specialties[index];
                final isSelected = selectedSpecialty == specialty['name'];
                return _buildSpecialtyCard(specialty, isSelected);
              },
            ),
            const SizedBox(height: 24),

            // Doctor Selection (if specialty is selected)
            if (selectedSpecialty.isNotEmpty) ...[
              const Text(
                'Select Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              ...doctors
                  .where((doctor) => doctor['specialty'] == selectedSpecialty)
                  .map((doctor) => _buildDoctorCard(doctor)),
              const SizedBox(height: 24),
            ],

            // Date Selection (if doctor is selected)
            if (selectedDoctor.isNotEmpty) ...[
              const Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              _buildDateSelector(),
              const SizedBox(height: 24),
            ],

            // Time Selection (if date is selected)
            if (selectedDate.isNotEmpty) ...[
              const Text(
                'Select Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              _buildTimeSelector(),
              const SizedBox(height: 24),
            ],

            // Book Appointment Button
            if (selectedTime.isNotEmpty) ...[
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA2A33),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Confirm Appointment - ${doctors.firstWhere((d) => d['name'] == selectedDoctor)['fee']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildAppointmentSummary(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentTypeCard(
    String type,
    String description,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEA2A33).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFEA2A33) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? const Color(0xFFEA2A33)
                  : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color(0xFFEA2A33)
                    : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(Map<String, dynamic> specialty, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSpecialty = specialty['name'];
          selectedDoctor = '';
          selectedDate = '';
          selectedTime = '';
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEA2A33).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFEA2A33) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              specialty['icon'],
              size: 32,
              color: isSelected
                  ? const Color(0xFFEA2A33)
                  : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              specialty['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color(0xFFEA2A33)
                    : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${specialty['doctors']} doctors',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    final isSelected = selectedDoctor == doctor['name'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDoctor = doctor['name'];
            selectedDate = '';
            selectedTime = '';
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFEA2A33).withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFEA2A33)
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(Icons.person, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color(0xFFEA2A33)
                            : const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          doctor['experience'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Next: ${doctor['nextAvailable']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                doctor['fee'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEA2A33),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final dateStr = '${date.day}/${date.month}';
          final dayStr = [
            'Sun',
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
          ][date.weekday % 7];
          final isSelected = selectedDate == dateStr;

          return Container(
            width: 70,
            margin: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedDate = dateStr;
                  selectedTime = '';
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFEA2A33) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFEA2A33)
                        : Colors.grey.shade300,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayStr,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final time = timeSlots[index];
        final isSelected = selectedTime == time;
        final isAvailable = index % 3 != 2; // Mock availability

        return InkWell(
          onTap: isAvailable
              ? () {
                  setState(() {
                    selectedTime = time;
                  });
                }
              : null,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: !isAvailable
                  ? Colors.grey.shade100
                  : isSelected
                  ? const Color(0xFFEA2A33)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: !isAvailable
                    ? Colors.grey.shade300
                    : isSelected
                    ? const Color(0xFFEA2A33)
                    : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: !isAvailable
                      ? Colors.grey.shade500
                      : isSelected
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentSummary() {
    final doctor = doctors.firstWhere((d) => d['name'] == selectedDoctor);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade600),
              const SizedBox(width: 8),
              Text(
                'Appointment Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Type', appointmentType),
          _buildSummaryRow('Specialty', selectedSpecialty),
          _buildSummaryRow('Doctor', selectedDoctor),
          _buildSummaryRow('Date', selectedDate),
          _buildSummaryRow('Time', selectedTime),
          _buildSummaryRow('Fee', doctor['fee']),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookAppointment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Appointment'),
        content: const Text('Are you sure you want to book this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment booked successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Reset selections
              setState(() {
                selectedSpecialty = '';
                selectedDoctor = '';
                selectedDate = '';
                selectedTime = '';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEA2A33),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
