import 'package:flutter/material.dart';

import 'package:box_app/app_properties.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnimatedBottomNav extends StatelessWidget {
  int currentIndex;
  Function(int) onChange;
  AnimatedBottomNav({
    Key key,
    this.currentIndex,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: blue.withOpacity(0.2),
            blurRadius: 15.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: BottomNavItem(
                icon: Icons.home_filled,
                title: "Paiement",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: BottomNavItem(
                icon: Icons.history,
                title: "Historique",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(2),
              child: BottomNavItem(
                icon: Icons.person_sharp,
                title: "Admin",
                isActive: currentIndex == 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  BottomNavItem({
    Key key,
    this.isActive = false,
    this.icon,
    this.activeColor = blue,
    this.inactiveColor = gray,
    this.title,
  }) : super(key: key);

  bool isActive;
  IconData icon;
  Color activeColor;
  Color inactiveColor;
  String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: /* isActive
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: activeColor, // ?? Colors.grey,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      letterSpacing: 1.0,
                      color: activeColor, // ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor, // ?? Colors.grey,
            ), */
          isActive
              ? Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: activeColor, // ?? Colors.grey,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          letterSpacing: 1.0,
                          color:
                              activeColor, // ?? Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: inactiveColor, // ?? Colors.grey,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          letterSpacing: 1.0,
                          color:
                              inactiveColor, // ?? Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
