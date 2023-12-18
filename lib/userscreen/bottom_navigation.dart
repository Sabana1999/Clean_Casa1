
import 'package:casa_example/color.dart';
import 'package:casa_example/profile_user.dart';
import 'package:casa_example/userscreen/help/help.dart';
import 'package:casa_example/userscreen/home.dart';
import 'package:casa_example/userscreen/userbookin/user_booking.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
   int _selectIndex = 0;
  final List<Widget> _pages = [

const    MyHomePage(),
  UserBooking (),

UserHelp(),

 ProfileUs(), 



  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor:primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
              ),
              label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_outlined,
              ),
              label: 'Help'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box_outlined,
              ),
              label: 'User Account'),
         // BottomNavigationBarItem(
          //    icon: Icon(
           //     Icons.account_box_rounded,
            //  ),
            //  label: 'Account')
        ],
        currentIndex: _selectIndex,
        onTap: (value) {
          _selectIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
