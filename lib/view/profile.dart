import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            /// PROFILE CARD
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/profile_placeholder.png"),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 10, color: Colors.green),
                        const SizedBox(width: 4),
                        Text("Active member",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text("Edit Profile",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// PROFILE DETAILS CARD
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Profile Details",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _detailRow("Name", "Not set"),
                    _detailRow("Email", "Not set"),
                    _detailRow("Profile Picture", "Not set"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// HAIR CARE PREFERENCES
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hair Care Preferences",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    /// HAIR TYPE
                    Text("Hair Type"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _optionChip("Oily"),
                        _optionChip("Dry"),
                        _optionChip("Normal"),
                        _optionChip("Wavy", isSelected: true),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// SHAMPOO ROUTINE
                    Text("Shampooing Routine"),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _optionChip("Daily", isSelected: true),
                        _optionChip("Every Other Day"),
                        _optionChip("Twice Weekly"),
                        _optionChip("Weekly"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// LOGOUT BUTTON
            ElevatedButton(
              onPressed: () {
                // TODO: Add logout logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 125, 10, 2),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  /// Profile Details Row
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// Selectable Option Chip
  Widget _optionChip(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
