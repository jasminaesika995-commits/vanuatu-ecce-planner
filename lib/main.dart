import 'package:flutter/material.dart';

void main() {
  runApp(const EccePlannerApp());
}

class EccePlannerApp extends StatefulWidget {
  const EccePlannerApp({Key? key}) : super(key: key);

  @override
  State<EccePlannerApp> createState() => _EccePlannerAppState();
}

class _EccePlannerAppState extends State<EccePlannerApp> {
  String selectedLanguage = 'Bislama';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanuatu ECCE Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF00A859), // Vanuatu Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00A859),
          primary: const Color(0xFF00A859),
        ),
      ),
      home: NavigationHomeScreen(
        language: selectedLanguage,
        onLanguageChanged: (newLang) {
          setState(() {
            selectedLanguage = newLang;
          });
        },
      ),
    );
  }
}

class NavigationHomeScreen extends StatefulWidget {
  final String language;
  final ValueChanged<String> onLanguageChanged;

  const NavigationHomeScreen({
    Key? key,
    required this.language,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> _samplePlans = [
    {
      'title': 'Unit Plan: Culture & Community',
      'type': 'Web Plan',
      'date': 'Week 1 - Term 1'
    },
    {
      'title': 'Daily Plan: Outdoor Play & Health',
      'type': 'Daily Lesson',
      'date': 'Today'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildLessonPlansTab(),
      _buildTemplatesTab(),
      _buildWeeklySchedulesTab(),
      _buildRegistrationFormsTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language == 'Bislama' ? 'Vanuatu ECCE Planner' : 'Vanuatu ECCE Planner'),
        backgroundColor: const Color(0xFF00A859),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: widget.onLanguageChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Bislama', child: Text('Bislama')),
              const PopupMenuItem(value: 'English', child: Text('English')),
              const PopupMenuItem(value: 'Français', child: Text('Français')),
            ],
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00A859),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Lesson Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_copy),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: 'Registration',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _showNewPlanDialog,
              backgroundColor: const Color(0xFF00A859),
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text(widget.language == 'Bislama' ? 'Niu Plan' : 'New Plan'),
            )
          : null,
    );
  }

  // TAB 1: Lesson Plans
  Widget _buildLessonPlansTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: const Color(0xFFE8F5E9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: Color(0xFF00A859), size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAlignment.start,
                    children: [
                      Text(
                        widget.language == 'Bislama' ? 'Lisen Plan Dashboard' : 'Lesson Planning Dashboard',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.language == 'Bislama'
                            ? 'Bioltem Web Plans, Unit Plans mo Daily Lessons'
                            : 'Generate Web Plans, Unit Plans, & Daily Schedules.',
                        style: const TextStyle(color: Colors.black70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Saved Plans',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._samplePlans.map((plan) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF00A859).withOpacity(0.15),
                  child: const Icon(Icons.description, color: Color(0xFF00A859)),
                ),
                title: Text(plan['title']!),
                subtitle: Text('${plan['type']} • ${plan['date']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening ${plan['title']}...')),
                  );
                },
              ),
            )),
      ],
    );
  }

  // TAB 2: Templates
  Widget _buildTemplatesTab() {
    final templates = [
      'Daily Lesson Plan Template',
      'Weekly Web Plan Template',
      'Term Unit Plan Framework',
      'Weekly Student Evaluation Form',
      'ECCE Learning Center Checklist',
    ];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Official Curriculum & Planning Templates',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...templates.map((title) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.file_present, color: Color(0xFF00A859)),
                title: Text(title),
                subtitle: const Text('Pre-formatted ECCE Standard'),
                trailing: IconButton(
                  icon: const Icon(Icons.download_rounded, color: Color(0xFF00A859)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Loaded template: $title')),
                    );
                  },
                ),
              ),
            )),
      ],
    );
  }

  // TAB 3: Weekly Schedules
  Widget _buildWeeklySchedulesTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          '2026 Weekly Schedule & Calendar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAlignment.start,
              children: const [
                Text('Monday - Friday Routine', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Divider(),
                ListTile(
                  dense: true,
                  leading: Text('08:00 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text('Devotion & Arrival Circle'),
                ),
                ListTile(
                  dense: true,
                  leading: Text('08:30 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text('Guided Learning Activity / Language'),
                ),
                ListTile(
                  dense: true,
                  leading: Text('09:30 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text('Free Play & Outdoor Exploration'),
                ),
                ListTile(
                  dense: true,
                  leading: Text('10:30 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text('Healthy Snack Time & Rest'),
                ),
                ListTile(
                  dense: true,
                  leading: Text('11:15 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text('Creative Arts, Music & Storytelling'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // TAB 4: Registration Data Forms
  Widget _buildRegistrationFormsTab() {
    final _nameController = TextEditingController();
    final _ageController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAlignment.start,
        children: [
          const Text(
            'Student & School Registration Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Record student details for OpenVEMIS & school tracking.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Child Full Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age / Date of Birth',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cake),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.wc),
            ),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
            ],
            onChanged: (val) {},
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A859),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration Data Saved Successfully!')),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Registration Record'),
            ),
          ),
        ],
      ),
    );
  }

  void _showNewPlanDialog() {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.language == 'Bislama' ? 'Create New Plan' : 'Create New Plan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Plan Title (e.g., Week 2 Web Plan)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A859)),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                setState(() {
                  _samplePlans.add({
                    'title': titleController.text,
                    'type': 'Custom Plan',
                    'date': 'New',
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
