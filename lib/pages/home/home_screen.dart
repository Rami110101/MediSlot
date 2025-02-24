import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/components/style/color.dart';

import '../../components/field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: buildDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(context),
                 buildSearchField(),
                const SizedBox(height: 20),
                const Text(
                  'What Are You Looking For?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                horizontalCircleList(),
                const SizedBox(height: 20),
                const Text(
                  "Don't Forget",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                buildDoctorCard(
                  name: "Dr. Assaad Hanash",
                  specialization: "ENT",
                  date: "Wed 7 Sep 2024",
                  time: "10:30 AM",
                ),
                const SizedBox(height: 20),
                const Text(
                  'My Recent Visit',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                buildRecentVisitList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Ghalia!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'How Do You Feel Today?',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: CircleAvatar(
            radius: 30,
             child: ClipOval(
              child: Image.asset('assets/images/d.png', fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchField() {
    return CustomInputField(
      controller: searchController, title: '',
isSearchField: true,
    );
  }

  Widget horizontalCircleList() {
    final List<String> imagePaths = [
      'assets/images/c1.png',
      'assets/images/c2.png',
      'assets/images/c3.png',
      'assets/images/c1.png',
      'assets/images/c2.png',
      'assets/images/c3.png',
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueAccent,
                  child: ClipOval(
                    child: Image.asset(
                      imagePaths[index], // تحميل الصورة بناءً على الـ index
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Option ${index + 1}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDoctorCard({
    required String name,
    required String specialization,
    required String date,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/d.png'),
              ),
              const SizedBox(width: 16),
              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      specialization,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/calen.png'),
                    const SizedBox(width: 5),
                    Text(date, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/clo.svg'),
                    const SizedBox(width: 5),
                    Text(time, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecentVisitCard({
    required String doctorName,
    required String specialization,
    required double rating,
    required double pricePerHour,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // مسافة بين الكروت
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.snowColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // الصورة الخاصة بالدكتور
          Container(
            width: 100,
            height: 103,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8), // زوايا دائرية خفيفة
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16), // مسافة بين الصورة والنصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  specialization,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // السعر في الزاوية اليمنى السفلى
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر القلب في الزاوية اليمنى العليا
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  // وظيفة الزر
                },
              ),
              Text(
                '\$$pricePerHour/hr',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// عرض 4 عناصر
  Widget buildRecentVisitList() {
    return Column(
      children: [
        buildRecentVisitCard(
          doctorName: 'Dr. Nour Srour',
          specialization: 'ENT',
          rating: 4.9,
          pricePerHour: 25,
          imagePath: 'assets/images/d1.png',
        ),
        buildRecentVisitCard(
          doctorName: 'Dr. Sarah Ahmed',
          specialization: 'Cardiologist',
          rating: 4.8,
          pricePerHour: 30,
          imagePath: 'assets/images/d2.png',
        ),
        buildRecentVisitCard(
          doctorName: 'Dr. John Smith',
          specialization: 'Dermatologist',
          rating: 4.7,
          pricePerHour: 20,
          imagePath: 'assets/images/d1.png',
        ),
        buildRecentVisitCard(
          doctorName: 'Dr. Emily Jones',
          specialization: 'Orthopedic',
          rating: 4.9,
          pricePerHour: 35,
          imagePath: 'assets/images/d2.png',
        ),
      ],
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Ghalia AJ'),
            accountEmail: const Text('ghalia.aj@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/d.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
