import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: HeaderDash(title: 'Account'),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: constraints.maxWidth * 0.15,
                        backgroundImage:
                            const AssetImage('assets/F.jpg'),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: constraints.maxWidth * 0.03,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.edit,
                                size: 15, color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Charitra Shrestha',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '9861662986',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'natasha.seller@gmail.com',
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(
                              Icons.shopping_bag, 'Orders', constraints),
                          _buildIconButton(
                              Icons.payment, 'Payment', constraints),
                          _buildIconButton(
                              Icons.local_shipping, 'Package', constraints),
                          _buildIconButton(Icons.local_shipping_outlined,
                              'To ship', constraints),
                          _buildIconButton(Icons.fact_check_outlined,
                              'To check', constraints),
                          _buildIconButton(Icons.undo, 'Returns', constraints),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildListTile(Icons.person, 'Update Profile'),
                      _buildListTile(Icons.inventory, 'My Products'),
                      _buildListTile(Icons.help, 'Help and Support'),
                      _buildListTile(Icons.settings, 'Setting'),
                      _buildListTile(Icons.logout, 'Logout'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, String label, BoxConstraints constraints) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: constraints.maxWidth * 0.1, color: Colors.grey[800]),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.03,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[800]),
      onTap: () {},
    );
  }
}
