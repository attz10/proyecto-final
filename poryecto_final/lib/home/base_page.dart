import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poryecto_final/home/home.dart';
import 'package:poryecto_final/pages/admin.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);
    return user == null ? Home() : Admin();
  }
}
