import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
    backgroundColor: Color(0xFF222222),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'SOLO/FOLLOW',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'AUTONOMOUS',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'OTHER',
      ),
    ],
    unselectedItemColor: Colors.white,
    selectedLabelStyle: TextStyle(fontSize: 12),
    // 選択されたラベルのフォントサイズを設定
    unselectedLabelStyle: TextStyle(fontSize: 12),
  );
}
