import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  // ✅ Change to StatefulWidget
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> tips = [
    {
      "icon": Icons.water_drop,
      "title": "Stay Hydrated",
      "description":
          "Drink 8-10 glasses of water daily for healthy hair growth.\n\nProper hydration keeps your scalp moisturized and supports nutrient delivery to hair follicles.",
    },
    {
      "icon": Icons.local_florist,
      "title": "Balanced Diet",
      "description":
          "Eat foods rich in vitamins & minerals like spinach, eggs, and nuts to strengthen your hair roots.",
    },
    {
      "icon": Icons.bedtime,
      "title": "Good Sleep",
      "description":
          "Sleep 7-8 hours daily to allow your body to repair and grow healthier hair.",
    },
    {
      "icon": Icons.spa,
      "title": "Oil Massage",
      "description":
          "Massage your scalp with natural oils like coconut or argan oil twice a week to improve blood circulation.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Your Progress",
          style: TextStyle(
            fontSize: 20,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.share, color: Colors.black),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PROGRESS OVERVIEW
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Progress Overview",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _progressItem(Icons.timer, "0", "Total Scans"),
                        _progressItem(Icons.calendar_today, "0", "This Month"),
                        _progressItem(Icons.trending_up, "50%", "Trend"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("This month you scanned 0 times",
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// RECENT SCANS
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recent Scans",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("New Scan",
                              style: TextStyle(color: Colors.blue)),
                        ]),
                    const SizedBox(height: 12),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          Text("No scans yet"),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("Take Your First Scan"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// COMPARE PROGRESS
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Compare Progress",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _compareBox("Before", "Take more scans"),
                        _compareBox("After", "to compare"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// HAIR CARE TIPS
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hair Care Tips",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 170,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: tips.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return _tipCard(
                            icon: tips[index]["icon"],
                            title: tips[index]["title"],
                            description: tips[index]["description"],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// DOT INDICATORS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        tips.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Progress Overview Item
  Widget _progressItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  /// Compare Progress Box
  Widget _compareBox(String label, String subtitle) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.image, size: 40, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  /// Hair Care Tip Card (swipeable)
  Widget _tipCard(
      {required IconData icon,
      required String title,
      required String description}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(description,
              style: TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}
