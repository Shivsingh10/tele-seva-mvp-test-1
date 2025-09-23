import 'package:flutter/material.dart';

class HealthRecordsPage extends StatefulWidget {
  const HealthRecordsPage({super.key});

  @override
  State<HealthRecordsPage> createState() => _HealthRecordsPageState();
}

class _HealthRecordsPageState extends State<HealthRecordsPage> {
  int selectedTabIndex = 0;

  final List<String> tabs = [
    'All Records',
    'Prescriptions',
    'Lab Reports',
    'Visits',
  ];

  final List<Map<String, dynamic>> medicalRecords = [
    {
      'id': '1',
      'type': 'prescription',
      'title': 'General Checkup Prescription',
      'doctor': 'Dr. Rajesh Kumar',
      'date': '2025-09-20',
      'hospital': 'City General Hospital',
      'status': 'active',
      'medicines': ['Paracetamol 500mg', 'Vitamin D3', 'Omeprazole 20mg'],
      'duration': '7 days',
      'icon': Icons.medical_services,
      'color': Colors.blue,
    },
    {
      'id': '2',
      'type': 'lab_report',
      'title': 'Complete Blood Count (CBC)',
      'doctor': 'Dr. Priya Sharma',
      'date': '2025-09-18',
      'hospital': 'Apollo Diagnostics',
      'status': 'normal',
      'results': [
        'Hemoglobin: 14.2 g/dL',
        'WBC: 7,200/μL',
        'Platelets: 250,000/μL',
      ],
      'icon': Icons.science,
      'color': Colors.green,
    },
    {
      'id': '3',
      'type': 'visit',
      'title': 'Cardiology Consultation',
      'doctor': 'Dr. Amit Patel',
      'date': '2025-09-15',
      'hospital': 'Heart Care Center',
      'status': 'completed',
      'diagnosis': 'Normal heart function',
      'notes': 'Regular follow-up in 6 months',
      'icon': Icons.favorite,
      'color': Colors.red,
    },
    {
      'id': '4',
      'type': 'lab_report',
      'title': 'Lipid Profile',
      'doctor': 'Dr. Sunita Verma',
      'date': '2025-09-10',
      'hospital': 'Metro Diagnostics',
      'status': 'attention',
      'results': [
        'Total Cholesterol: 220 mg/dL',
        'HDL: 35 mg/dL',
        'LDL: 150 mg/dL',
      ],
      'icon': Icons.science,
      'color': Colors.orange,
    },
    {
      'id': '5',
      'type': 'prescription',
      'title': 'Diabetes Management',
      'doctor': 'Dr. Vikram Singh',
      'date': '2025-09-05',
      'hospital': 'Diabetes Care Clinic',
      'status': 'active',
      'medicines': ['Metformin 500mg', 'Glimepiride 2mg', 'Insulin pen'],
      'duration': '30 days',
      'icon': Icons.medical_services,
      'color': Colors.purple,
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    if (selectedTabIndex == 0) return medicalRecords;

    String filterType = '';
    switch (selectedTabIndex) {
      case 1:
        filterType = 'prescription';
        break;
      case 2:
        filterType = 'lab_report';
        break;
      case 3:
        filterType = 'visit';
        break;
    }

    return medicalRecords
        .where((record) => record['type'] == filterType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Health Records'),
        backgroundColor: const Color(0xFFEA2A33),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showAddRecordDialog();
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Record',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Records',
                    '${medicalRecords.length}',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Active Prescriptions',
                    '2',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Recent Reports', '2', Colors.orange),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: TabController(
                length: tabs.length,
                vsync: Scaffold.of(context),
              ),
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              labelColor: const Color(0xFFEA2A33),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFFEA2A33),
              onTap: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              isScrollable: true,
            ),
          ),

          // Records List
          Expanded(
            child: filteredRecords.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No records found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your medical records will appear here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredRecords.length,
                    itemBuilder: (context, index) {
                      final record = filteredRecords[index];
                      return _buildRecordCard(record);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecordDialog,
        backgroundColor: const Color(0xFFEA2A33),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: record['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(record['icon'], size: 24, color: record['color']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dr. ${record['doctor']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(record['status']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record['status'].toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(record['status']),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Record Details
          if (record['type'] == 'prescription') ...[
            _buildDetailRow('Medicines:', record['medicines'].join(', ')),
            _buildDetailRow('Duration:', record['duration']),
          ] else if (record['type'] == 'lab_report') ...[
            _buildDetailRow('Results:', record['results'].join(', ')),
          ] else if (record['type'] == 'visit') ...[
            _buildDetailRow('Diagnosis:', record['diagnosis']),
            if (record['notes'] != null)
              _buildDetailRow('Notes:', record['notes']),
          ],

          const SizedBox(height: 12),

          // Date and Hospital
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                record['date'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              const SizedBox(width: 16),
              Icon(Icons.local_hospital, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  record['hospital'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
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
                    _showRecordDetails(record);
                  },
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('View Details'),
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
                      const SnackBar(
                        content: Text('Downloading record...'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download'),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Color(0xFF111827)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'normal':
        return Colors.blue;
      case 'attention':
        return Colors.orange;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showRecordDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(record['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctor: ${record['doctor']}'),
            Text('Date: ${record['date']}'),
            Text('Hospital: ${record['hospital']}'),
            const SizedBox(height: 16),
            if (record['type'] == 'prescription') ...[
              const Text(
                'Medicines:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...record['medicines'].map<Widget>(
                (medicine) => Text('• $medicine'),
              ),
              const SizedBox(height: 8),
              Text('Duration: ${record['duration']}'),
            ] else if (record['type'] == 'lab_report') ...[
              const Text(
                'Results:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...record['results'].map<Widget>((result) => Text('• $result')),
            ] else if (record['type'] == 'visit') ...[
              const Text(
                'Diagnosis:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(record['diagnosis']),
              if (record['notes'] != null) ...[
                const SizedBox(height: 8),
                const Text(
                  'Notes:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(record['notes']),
              ],
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Record'),
        content: const Text(
          'This feature will allow you to add new medical records, upload documents, and sync with healthcare providers.',
        ),
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
                  content: Text('Add record feature coming soon!'),
                  backgroundColor: Color(0xFFEA2A33),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEA2A33),
            ),
            child: const Text('Coming Soon'),
          ),
        ],
      ),
    );
  }
}
