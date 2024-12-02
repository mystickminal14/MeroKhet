import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/navigation/farmer_navigation_flow.dart';
import 'package:merokhetapp/navigation/navigation_flow.dart';
import 'package:merokhetapp/screens/auth/login_page.dart';
import 'package:merokhetapp/screens/flashing_page.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      _isLoading = true;
      return const Loading();
    }

    if (_isLoading) {
      _isLoading = false;
    }

    if (!_isLoading) {
      if (user.role == 'farmer') {
        return const FarmerNavigationFlow( ind: 1,);
      } else if (user.role == 'consumer') {
        return const NavigationFlow( ind: 2);
      } else {
        return const FlashingPage();
      }
    }

    return const Loading();
  }
}
