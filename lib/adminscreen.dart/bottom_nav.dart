import 'package:casa_example/adminscreen.dart/add_booking.dart';
import 'package:casa_example/adminscreen.dart/addservice/adduser_show.dart';
import 'package:casa_example/adminscreen.dart/admin_home.dart';
import 'package:casa_example/adminscreen.dart/user_list.dart';
import 'package:casa_example/color.dart';
import 'package:flutter/material.dart';

class BottomNav1 extends StatefulWidget {
  const BottomNav1({super.key});

  @override
  State<BottomNav1> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav1> {
   int _selectIndex = 0;
  final List<Widget> _pages = [

const    AdHome(),
   AdBokking(),

AddUser(),

  AdProfile(), 



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
              label: 'Add Category'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.layers_outlined,
              ),
              label: 'User List'),
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
