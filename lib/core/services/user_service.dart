import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _usersKey = 'registered_users';
  static const String _userCountsKey = 'user_counts';

  // Save a new user
  static Future<bool> registerUser({
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get existing users
      List<Map<String, dynamic>> users = await getUsers();

      // Check if user already exists
      bool userExists = users.any((user) => user['email'] == email);
      if (userExists) {
        return false; // User already exists
      }

      // Create new user
      Map<String, dynamic> newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'registeredAt': DateTime.now().toIso8601String(),
      };

      // Add to users list
      users.add(newUser);

      // Save users
      await prefs.setString(_usersKey, json.encode(users));

      // Update user counts
      await _updateUserCounts();

      return true;
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
  }

  // Get all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? usersData = prefs.getString(_usersKey);

      if (usersData != null) {
        List<dynamic> usersList = json.decode(usersData);
        return usersList.cast<Map<String, dynamic>>();
      }

      return [];
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  // Get user counts by role
  static Future<Map<String, int>> getUserCounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? countsData = prefs.getString(_userCountsKey);

      if (countsData != null) {
        Map<String, dynamic> counts = json.decode(countsData);
        return counts.map((key, value) => MapEntry(key, value as int));
      }

      // Return default counts if no data exists
      return {
        'patient': 0,
        'doctor': 0,
        'hospital_staff': 0,
        'pharmacist': 0,
        'total': 0,
      };
    } catch (e) {
      print('Error getting user counts: $e');
      return {
        'patient': 0,
        'doctor': 0,
        'hospital_staff': 0,
        'pharmacist': 0,
        'total': 0,
      };
    }
  }

  // Update user counts
  static Future<void> _updateUserCounts() async {
    try {
      List<Map<String, dynamic>> users = await getUsers();

      Map<String, int> counts = {
        'patient': 0,
        'doctor': 0,
        'hospital_staff': 0,
        'pharmacist': 0,
        'total': 0,
      };

      // Count users by role
      for (var user in users) {
        String role = user['role'] ?? '';
        if (counts.containsKey(role)) {
          counts[role] = counts[role]! + 1;
        }
        counts['total'] = counts['total']! + 1;
      }

      // Save counts
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userCountsKey, json.encode(counts));
    } catch (e) {
      print('Error updating user counts: $e');
    }
  }

  // Get users by role
  static Future<List<Map<String, dynamic>>> getUsersByRole(String role) async {
    List<Map<String, dynamic>> allUsers = await getUsers();
    return allUsers.where((user) => user['role'] == role).toList();
  }

  // Check if user exists (for login)
  static Future<Map<String, dynamic>?> loginUser(
    String email,
    String password,
  ) async {
    List<Map<String, dynamic>> users = await getUsers();

    try {
      return users.firstWhere(
        (user) => user['email'] == email,
        // Note: In real app, you'd hash and compare passwords
        // For demo purposes, we're just checking email exists
      );
    } catch (e) {
      return null; // User not found
    }
  }

  // Add some demo data (call this once to populate initial data)
  static Future<void> addDemoData() async {
    final prefs = await SharedPreferences.getInstance();
    String? existing = prefs.getString(_usersKey);

    // Only add demo data if no users exist
    if (existing == null || existing.isEmpty || existing == '[]') {
      await registerUser(
        name: 'Dr. Rajesh Kumar',
        email: 'rajesh.doctor@example.com',
        phone: '+91 98765 43210',
        role: 'doctor',
      );

      await registerUser(
        name: 'Priya Sharma',
        email: 'priya.patient@example.com',
        phone: '+91 87654 32109',
        role: 'patient',
      );

      await registerUser(
        name: 'Amit Pharmacist',
        email: 'amit.pharmacy@example.com',
        phone: '+91 76543 21098',
        role: 'pharmacist',
      );

      await registerUser(
        name: 'Staff Member',
        email: 'staff.hospital@example.com',
        phone: '+91 65432 10987',
        role: 'hospital_staff',
      );

      await registerUser(
        name: 'Anita Singh',
        email: 'anita.patient@example.com',
        phone: '+91 54321 09876',
        role: 'patient',
      );

      await registerUser(
        name: 'Dr. Sunita Verma',
        email: 'sunita.doctor@example.com',
        phone: '+91 43210 98765',
        role: 'doctor',
      );
    }
  }

  // Force refresh user counts (useful for widgets)
  static Future<void> refreshUserCounts() async {
    await _updateUserCounts();
  }

  // Delete user (for admin purposes)
  static Future<bool> deleteUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> users = await getUsers();

      users.removeWhere((user) => user['id'] == userId);

      await prefs.setString(_usersKey, json.encode(users));
      await _updateUserCounts();

      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Update user information
  static Future<bool> updateUser({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> users = await getUsers();

      int userIndex = users.indexWhere((user) => user['id'] == userId);
      if (userIndex != -1) {
        users[userIndex]['name'] = name;
        users[userIndex]['email'] = email;
        users[userIndex]['phone'] = phone;
        users[userIndex]['updatedAt'] = DateTime.now().toIso8601String();

        await prefs.setString(_usersKey, json.encode(users));
        return true;
      }

      return false;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }
}
