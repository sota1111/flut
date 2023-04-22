import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
    backgroundColor: Color(0xFF222222),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Solo/Follow',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Autonomous',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'other',
      ),
    ],
    unselectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(fontSize: 15), // 選択されたラベルのフォントサイズを設定
    unselectedLabelStyle: TextStyle(fontSize: 15),
  );
}