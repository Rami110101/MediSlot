import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/pages/auth/login/login_screen.dart';
import 'package:project/pages/edit/edit_screen.dart';
import 'package:project/pages/favorite/screen.dart';

import '../../bloc/auth/cubit/auth_cubit.dart';
import '../../bloc/auth/state/auth_state.dart';
import '../../bloc/main/cubit/cubit_main.dart';
import '../../bloc/main/state/state_main.dart';
import '../../components/style/color.dart';
import '../appointments/appointments_screen.dart';
import '../home/home_screen.dart';
import '../notification/notification_screen.dart';

class MainScreen extends StatelessWidget {
    MainScreen({super.key});

  // قائمة الصفحات
  final List<Widget> _pages = [
    HomeScreen(),
    const AppointmentsScreen(),
    const FavoriteScreen(),
    const NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: Scaffold(
        drawer: buildDrawer(context),
        body: SafeArea(
          child: BlocBuilder<MainScreenCubit, MainScreenState>(
            builder: (context, state) {
              return _pages[state!.currentIndex];
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.snowColor,
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<MainScreenCubit>().changePage(index); // تحديث الـ index باستخدام Cubit
              },
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.black,
              items: [
                const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Icon(Icons.home),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 1 ? AppColors.primaryColor : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/calen.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 2 ? AppColors.primaryColor : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/heart.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        state.currentIndex == 3 ? AppColors.primaryColor : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/noti.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }


    Widget buildDrawer(BuildContext context) {
      return Drawer(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const EditScreen()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/d.png',
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ghalia AJ',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'About Us',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),

             ListTile(
              leading: SvgPicture.asset('assets/images/logout.svg'),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () async {
                final logoutCubit = LogoutCubit();
                logoutCubit.logoutUser();
                logoutCubit.stream.listen((state) {
                  if (state is LogoutLoading) {
                    // عرض مؤشر التحميل
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is LogoutSuccess) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>   LoginScreen()),
                    );
                  } else if (state is LogoutFailure) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.errorMessage}')),
                    );
                  }
                });
              },
            ),
          ],
        ),
      );
    }
}
