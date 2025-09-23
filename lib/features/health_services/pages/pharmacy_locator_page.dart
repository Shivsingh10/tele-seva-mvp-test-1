import 'package:flutter/material.dart';

class PharmacyLocatorPage extends StatefulWidget {
  const PharmacyLocatorPage({super.key});

  @override
  State<PharmacyLocatorPage> createState() => _PharmacyLocatorPageState();
}

class _PharmacyLocatorPageState extends State<PharmacyLocatorPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'All';

  final List<String> filters = [
    'All',
    '24/7 Open',
    'Home Delivery',
    'Insurance Accepted',
    'Generic Medicines',
  ];

  final List<Map<String, dynamic>> pharmacies = [
    {
      'name': 'Apollo Pharmacy',
      'address': '123 Main Street, Downtown',
      'distance': '0.5 km',
      'rating': 4.6,
      'isOpen': true,
      'timing': '24/7',
      'phone': '+91 98765 43210',
      'services': ['Home Delivery', '24/7 Open', 'Insurance Accepted'],
      'medicines': 1250,
      'image': Icons.local_pharmacy,
    },
    {
      'name': 'MedPlus Pharmacy',
      'address': '456 Health Avenue, North Delhi',
      'distance': '1.2 km',
      'rating': 4.4,
      'isOpen': true,
      'timing': '8:00 AM - 10:00 PM',
      'phone': '+91 87654 32109',
      'services': ['Home Delivery', 'Generic Medicines'],
      'medicines': 980,
      'image': Icons.local_pharmacy,
    },
    {
      'name': 'Wellness Pharmacy',
      'address': '789 Care Road, South Delhi',
      'distance': '2.1 km',
      'rating': 4.8,
      'isOpen': false,
      'timing': '9:00 AM - 9:00 PM',
      'phone': '+91 76543 21098',
      'services': ['Insurance Accepted', 'Generic Medicines'],
      'medicines': 1150,
      'image': Icons.local_pharmacy,
    },
    {
      'name': 'HealthKart Pharmacy',
      'address': '321 Wellness Street, East Delhi',
      'distance': '1.8 km',
      'rating': 4.5,
      'isOpen': true,
      'timing': '7:00 AM - 11:00 PM',
      'phone': '+91 65432 10987',
      'services': ['24/7 Open', 'Home Delivery'],
      'medicines': 1400,
      'image': Icons.local_pharmacy,
    },
    {
      'name': 'Guardian Pharmacy',
      'address': '654 Medicine Lane, West Delhi',
      'distance': '3.5 km',
      'rating': 4.3,
      'isOpen': true,
      'timing': '8:30 AM - 10:30 PM',
      'phone': '+91 54321 09876',
      'services': ['Generic Medicines', 'Insurance Accepted'],
      'medicines': 750,
      'image': Icons.local_pharmacy,
    },
  ];

  List<Map<String, dynamic>> get filteredPharmacies {
    return pharmacies.where((pharmacy) {
      bool matchesSearch =
          _searchController.text.isEmpty ||
          pharmacy['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          pharmacy['address'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );

      bool matchesFilter =
          selectedFilter == 'All' ||
          pharmacy['services'].contains(selectedFilter);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Pharmacy Locator'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Map view coming soon!'),
                  backgroundColor: Color(0xFFEA2A33),
                ),
              );
            },
            icon: const Icon(Icons.map),
            tooltip: 'Map View',
          ),
        ],
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
                    hintText: 'Search pharmacies or medicines...',
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

          // Quick Actions
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    'Upload Prescription',
                    Icons.camera_alt,
                    Colors.blue,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Prescription upload coming soon!'),
                          backgroundColor: Color(0xFFEA2A33),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionCard(
                    'Medicine Reminder',
                    Icons.alarm,
                    Colors.green,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Medicine reminder feature coming soon!',
                          ),
                          backgroundColor: Color(0xFFEA2A33),
                        ),
                      );
                    },
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
                  '${filteredPharmacies.length} pharmacies nearby',
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

          // Pharmacies List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredPharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = filteredPharmacies[index];
                return _buildPharmacyCard(pharmacy);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPharmacyCard(Map<String, dynamic> pharmacy) {
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
              // Pharmacy Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  pharmacy['image'],
                  size: 28,
                  color: Colors.orange.shade600,
                ),
              ),
              const SizedBox(width: 16),

              // Pharmacy Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pharmacy['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: pharmacy['isOpen']
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            pharmacy['isOpen'] ? 'Open' : 'Closed',
                            style: TextStyle(
                              fontSize: 12,
                              color: pharmacy['isOpen']
                                  ? Colors.green.shade600
                                  : Colors.red.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pharmacy['address'],
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
                          pharmacy['rating'].toString(),
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
                          pharmacy['distance'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${pharmacy['medicines']} medicines',
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
            ],
          ),
          const SizedBox(height: 12),

          // Services Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: pharmacy['services'].map<Widget>((service) {
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

          // Timing and Contact
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                pharmacy['timing'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const Spacer(),
              Text(
                pharmacy['phone'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
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
                        content: Text('Calling ${pharmacy['name']}'),
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
                          'Getting directions to ${pharmacy['name']}',
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
