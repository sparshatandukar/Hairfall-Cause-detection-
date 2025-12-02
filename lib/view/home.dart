import 'package:flutter/material.dart';
import 'package:hairfall_app/view/profile.dart';
import 'package:hairfall_app/view/progress.dart';
import 'package:hairfall_app/view/scan.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HairCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ===== Main Page with Bottom Navigation =====
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ScanPage(),
    const ProgressPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.tips_and_updates), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ===== HomeScreen =====
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> symptoms = [
    {"name": "Hair Thinning", "icon": Icons.content_cut},
    {"name": "Bald Patches", "icon": Icons.blur_on},
    {"name": "Scalp Itching", "icon": Icons.medical_services},
    {"name": "Dandruff", "icon": Icons.ac_unit},
    {"name": "Oily Scalp", "icon": Icons.water_drop},
    {"name": "Dry Scalp", "icon": Icons.grain},
  ];

  final List<int> selectedSymptoms = [];

  void toggleSymptom(int index) {
    setState(() {
      if (selectedSymptoms.contains(index)) {
        selectedSymptoms.remove(index);
      } else {
        selectedSymptoms.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Welcome Card =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text("Ready to continue your hair journey?",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ===== Hair Scan Section =====
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://via.placeholder.com/150", // replace with your asset if needed
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text("Hair Loss Detection",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Personalized insights in seconds",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Start Hair Scan"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ===== Symptoms Chips =====
            const Text("Select Your Symptoms",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(symptoms.length, (index) {
                final isSelected = selectedSymptoms.contains(index);
                return GestureDetector(
                  onTap: () => toggleSymptom(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(symptoms[index]["icon"], color: isSelected ? Colors.blue : Colors.grey),
                        const SizedBox(width: 6),
                        Text(symptoms[index]["name"],
                            style: TextStyle(color: isSelected ? Colors.blue : Colors.black)),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: selectedSymptoms.isNotEmpty ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedSymptoms.isNotEmpty ? Colors.blue : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text("Analyze (${selectedSymptoms.length})"),
            ),
            const SizedBox(height: 25),

            // ===== Info Cards Horizontal Scroll =====
            const Text("Explore",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final cards = [
                    {"title": "Causes", "desc": "Hair loss triggers"},
                    {"title": "Treatments", "desc": "Explore options"},
                    {"title": "Track Progress", "desc": "Monitor health"},
                    {"title": "Expert Advice", "desc": "Consult pros"},
                  ];
                  return InfoCard(
                    title: cards[index]["title"]!,
                    desc: cards[index]["desc"]!,
                  );
                },
              ),
            ),
            const SizedBox(height: 25),

            // ===== Recent Activity Horizontal Scroll =====
            const Text("Recent Activity",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final activities = [
                    {"text": "📷 Hair scan completed", "time": "2d ago"},
                    {"text": "💚 Health assessment", "time": "1w ago"},
                  ];
                  return ActivityCard(
                    text: activities[index]["text"]!,
                    time: activities[index]["time"]!,
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

// ===== InfoCard Widget =====
class InfoCard extends StatelessWidget {
  final String title;
  final String desc;
  const InfoCard({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(desc,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

// ===== ActivityCard Widget =====
class ActivityCard extends StatelessWidget {
  final String text;
  final String time;
  const ActivityCard({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
