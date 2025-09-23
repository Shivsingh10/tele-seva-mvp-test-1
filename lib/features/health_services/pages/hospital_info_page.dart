import 'package:flutter/material.dart';

class HospitalInfoPage extends StatefulWidget {
  const HospitalInfoPage({super.key});

  @override
  State<HospitalInfoPage> createState() => _HospitalInfoPageState();
}

class _HospitalInfoPageState extends State<HospitalInfoPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';

  final List<String> filters = [
    'All',
    'Emergency',
    'Multi-specialty',
    '24/7 Service',
    'Insurance Accepted',
  ];

  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'City General Hospital',
      'address': '123 Healthcare Boulevard, Downtown',
      'distance': '1.2 km',
      'rating': 4.6,
      'type': 'Multi-specialty',
      'beds': 250,
      'availableBeds': 45,
      'phone': '+91 11 2345 6789',
      'emergency': true,
      'services': ['Emergency', '24/7 Service', 'ICU', 'Surgery'],
      'specialties': ['Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics'],
      'insurance': true,
      'image': Icons.local_hospital,
      'color': Colors.red,
    },
    {
      'name': 'Apollo Medical Center',
      'address': '456 Wellness Avenue, North Delhi',
      'distance': '2.8 km',
      'rating': 4.8,
      'type': 'Super-specialty',
      'beds': 400,
      'availableBeds': 78,
      'phone': '+91 11 3456 7890',
      'emergency': true,
      'services': ['Emergency', '24/7 Service', 'Trauma Center', 'Cancer Care'],
      'specialties': ['Oncology', 'Cardiothoracic Surgery', 'Neurosurgery'],
      'insurance': true,
      'image': Icons.local_hospital,
      'color': Colors.blue,
    },
    {
      'name': 'Metro Heart Institute',
      'address': '789 Cardiac Care Street, South Delhi',
      'distance': '3.5 km',
      'rating': 4.9,
      'type': 'Specialty',
      'beds': 180,
      'availableBeds': 22,
      'phone': '+91 11 4567 8901',
      'emergency': false,
      'services': ['Cardiac Care', 'Cath Lab', 'Heart Surgery'],
      'specialties': [
        'Cardiology',
        'Cardiac Surgery',
        'Interventional Cardiology',
      ],
      'insurance': true,
      'image': Icons.favorite,
      'color': Colors.pink,
    },
    {
      'name': 'Children\'s Medical Hospital',
      'address': '321 Kids Care Lane, East Delhi',
      'distance': '4.1 km',
      'rating': 4.7,
      'type': 'Pediatric',
      'beds': 120,
      'availableBeds': 18,
      'phone': '+91 11 5678 9012',
      'emergency': true,
      'services': ['Pediatric Emergency', 'NICU', 'Pediatric Surgery'],
      'specialties': ['Pediatrics', 'Neonatology', 'Pediatric Surgery'],
      'insurance': false,
      'image': Icons.child_care,
      'color': Colors.green,
    },
    {
      'name': 'Unity Orthopedic Center',
      'address': '654 Bone Care Road, West Delhi',
      'distance': '5.2 km',
      'rating': 4.5,
      'type': 'Specialty',
      'beds': 80,
      'availableBeds': 12,
      'phone': '+91 11 6789 0123',
      'emergency': false,
      'services': ['Joint Replacement', 'Sports Medicine', 'Physiotherapy'],
      'specialties': ['Orthopedics', 'Sports Medicine', 'Rheumatology'],
      'insurance': true,
      'image': Icons.healing,
      'color': Colors.orange,
    },
  ];

  List<Map<String, dynamic>> get filteredHospitals {
    return hospitals.where((hospital) {
      bool matchesSearch =
          _searchController.text.isEmpty ||
          hospital['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          hospital['specialties'].any(
            (specialty) => specialty.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          );

      bool matchesFilter =
          selectedFilter == 'All' ||
          (selectedFilter == 'Emergency' && hospital['emergency']) ||
          (selectedFilter == 'Multi-specialty' &&
              hospital['type'] == 'Multi-specialty') ||
          (selectedFilter == '24/7 Service' &&
              hospital['services'].contains('24/7 Service')) ||
          (selectedFilter == 'Insurance Accepted' && hospital['insurance']);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Hospital Info'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Emergency contacts feature coming soon!'),
                  backgroundColor: Color(0xFFEA2A33),
                ),
              );
            },
            icon: const Icon(Icons.emergency),
            tooltip: 'Emergency Contacts',
          ),
        ],
      ),
      body: Column(
        children: [
          // Emergency Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.emergency,
                    color: Colors.red.shade600,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency Services',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      Text(
                        'Call 102 for ambulance or visit nearest emergency hospital',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Calling emergency services...'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Call 102'),
                ),
              ],
            ),
          ),

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
                    hintText: 'Search hospitals or specialties...',
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

                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          selectedColor: const Color(
                            0xFFEA2A33,
                          ).withOpacity(0.2),
                          checkmarkColor: const Color(0xFFEA2A33),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? const Color(0xFFEA2A33)
                                : Colors.grey.shade700,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Bed Availability Summary
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildBedStatCard(
                    'Total Hospitals',
                    hospitals.length.toString(),
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBedStatCard(
                    'Available Beds',
                    hospitals
                        .fold(0, (sum, h) => sum + (h['availableBeds'] as int))
                        .toString(),
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBedStatCard(
                    'Emergency Ready',
                    hospitals.where((h) => h['emergency']).length.toString(),
                    Colors.red,
                  ),
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredHospitals.length} hospitals found',
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
                  label: const Text('Sort'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFEA2A33),
                  ),
                ),
              ],
            ),
          ),

          // Hospitals List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = filteredHospitals[index];
                return _buildHospitalCard(hospital);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Hospital Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: hospital['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  hospital['image'],
                  size: 28,
                  color: hospital['color'],
                ),
              ),
              const SizedBox(width: 16),

              // Hospital Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            hospital['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        if (hospital['emergency'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'EMERGENCY',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hospital['address'],
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
                          hospital['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hospital['distance'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          hospital['type'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Bed Availability
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.bed, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  'Beds: ${hospital['availableBeds']}/${hospital['beds']} available',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor:
                        (hospital['availableBeds'] as int) /
                        (hospital['beds'] as int),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            (hospital['availableBeds'] as int) >
                                (hospital['beds'] as int) * 0.5
                            ? Colors.green
                            : (hospital['availableBeds'] as int) >
                                  (hospital['beds'] as int) * 0.2
                            ? Colors.orange
                            : Colors.red,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Services Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: hospital['services'].map<Widget>((service) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  service,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Specialties
          Text(
            'Specialties: ${hospital['specialties'].join(', ')}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Contact and Insurance
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                hospital['phone'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const Spacer(),
              if (hospital['insurance'])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Insurance Accepted',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${hospital['name']}'),
                        backgroundColor: const Color(0xFFEA2A33),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEA2A33),
                    side: const BorderSide(color: Color(0xFFEA2A33)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Getting directions to ${hospital['name']}',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.directions, size: 18),
                  label: const Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA2A33),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
