import 'package:flutter/material.dart';

class FindDoctorsPage extends StatefulWidget {
  const FindDoctorsPage({super.key});

  @override
  State<FindDoctorsPage> createState() => _FindDoctorsPageState();
}

class _FindDoctorsPageState extends State<FindDoctorsPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedSpecialty = 'All';
  String selectedLocation = 'All Areas';

  final List<String> specialties = [
    'All',
    'General Physician',
    'Cardiologist',
    'Dermatologist',
    'Orthopedic',
    'Pediatrician',
    'Gynecologist',
    'ENT Specialist',
    'Neurologist',
    'Psychiatrist',
  ];

  final List<String> locations = [
    'All Areas',
    'Downtown',
    'North Delhi',
    'South Delhi',
    'East Delhi',
    'West Delhi',
    'Gurgaon',
    'Noida',
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Rajesh Kumar',
      'specialty': 'General Physician',
      'experience': '15 years',
      'rating': 4.8,
      'location': 'Downtown',
      'distance': '2.3 km',
      'fee': '₹500',
      'available': true,
      'nextSlot': '2:30 PM',
      'image': Icons.person,
    },
    {
      'name': 'Dr. Priya Sharma',
      'specialty': 'Cardiologist',
      'experience': '12 years',
      'rating': 4.9,
      'location': 'North Delhi',
      'distance': '3.1 km',
      'fee': '₹800',
      'available': true,
      'nextSlot': '4:00 PM',
      'image': Icons.person,
    },
    {
      'name': 'Dr. Amit Patel',
      'specialty': 'Dermatologist',
      'experience': '10 years',
      'rating': 4.7,
      'location': 'South Delhi',
      'distance': '4.5 km',
      'fee': '₹600',
      'available': false,
      'nextSlot': 'Tomorrow 10:00 AM',
      'image': Icons.person,
    },
    {
      'name': 'Dr. Sunita Verma',
      'specialty': 'Pediatrician',
      'experience': '18 years',
      'rating': 4.9,
      'location': 'East Delhi',
      'distance': '1.8 km',
      'fee': '₹550',
      'available': true,
      'nextSlot': '3:15 PM',
      'image': Icons.person,
    },
    {
      'name': 'Dr. Vikram Singh',
      'specialty': 'Orthopedic',
      'experience': '20 years',
      'rating': 4.8,
      'location': 'West Delhi',
      'distance': '5.2 km',
      'fee': '₹900',
      'available': true,
      'nextSlot': '5:30 PM',
      'image': Icons.person,
    },
    {
      'name': 'Dr. Kavya Reddy',
      'specialty': 'Gynecologist',
      'experience': '14 years',
      'rating': 4.9,
      'location': 'Gurgaon',
      'distance': '6.1 km',
      'fee': '₹700',
      'available': false,
      'nextSlot': 'Tomorrow 11:30 AM',
      'image': Icons.person,
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    return doctors.where((doctor) {
      bool matchesSearch =
          _searchController.text.isEmpty ||
          doctor['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          doctor['specialty'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );

      bool matchesSpecialty =
          selectedSpecialty == 'All' ||
          doctor['specialty'] == selectedSpecialty;
      bool matchesLocation =
          selectedLocation == 'All Areas' ||
          doctor['location'] == selectedLocation;

      return matchesSearch && matchesSpecialty && matchesLocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Find Doctors'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search doctors or specialties...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFEA2A33)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),

                // Filter Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedSpecialty,
                        decoration: InputDecoration(
                          labelText: 'Specialty',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        items: specialties.map((specialty) {
                          return DropdownMenuItem(
                            value: specialty,
                            child: Text(specialty),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSpecialty = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedLocation,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        items: locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredDoctors.length} doctors found',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Sort functionality
                  },
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort by'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFEA2A33),
                  ),
                ),
              ],
            ),
          ),

          // Doctors List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return _buildDoctorCard(doctor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            children: [
              // Doctor Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  doctor['image'],
                  size: 30,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
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
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${doctor['experience']} exp',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Availability Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: doctor['available']
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  doctor['available'] ? 'Available' : 'Busy',
                  style: TextStyle(
                    fontSize: 12,
                    color: doctor['available']
                        ? Colors.green.shade600
                        : Colors.orange.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Additional Info Row
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                '${doctor['location']} • ${doctor['distance']}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const Spacer(),
              Text(
                'Fee: ${doctor['fee']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing ${doctor['name']} profile'),
                        backgroundColor: const Color(0xFFEA2A33),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEA2A33),
                    side: const BorderSide(color: Color(0xFFEA2A33)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Profile'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Booking appointment with ${doctor['name']}',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA2A33),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Book • ${doctor['nextSlot']}'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
