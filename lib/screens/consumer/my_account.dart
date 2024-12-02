import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/screens/consumer/edit_profile.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/services/consumer_controller.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {

  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoadingConsumer = true;
  Map<String, dynamic>? consumerData;
  File? _image;
  String _base64Image = "";
  bool isLoading = false;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    fetchConsumerData();
  }

   uploadImg() async {

    final XFile? pickedImage2 = await picker.pickImage(source: ImageSource.gallery);
    final user = Provider.of<UserModel?>(context, listen: false);
    setState(() {
      isLoadingConsumer=true;
    });
    if (pickedImage2 != null) {
      final bytes = await pickedImage2.readAsBytes();
      final base64Image = base64Encode(bytes);

      try {
        await AuthService().updateConsumerImage(context, user?.uid ?? '', base64Image);

        setState(() {
          _image = File(pickedImage2.path);
          _base64Image = base64Image;
          isLoadingConsumer=false;
          fetchConsumerData();
        });

        ShowAlert.showAlert(
          context,
          "Image uploaded successfully!",
          AlertType.success,
        );
      } catch (e) {
        ShowAlert.showAlert(
          context,
          "Error uploading image: ${e.toString()}",
          AlertType.error,
        );
        setState(() {
          isLoadingConsumer=true;
        });

      }
    }
  }


  Future<void> fetchConsumerData() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      if (user != null) {
        final data = await ConsumerController().getConsumerByID(user.uid);
        setState(() {
          consumerData = data.isNotEmpty ? data[0]['consumer'] : null;
        });
      }
    } catch (e) {
      print("Error fetching consumer data: $e");
    } finally {
      setState(() {
        isLoadingConsumer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image =
        consumerData?['image'] ?? ''; // Use the correct key here
    final user = Provider.of<UserModel?>(context, listen: false);

    Uint8List? imageBytes;
    if (base64Image.isNotEmpty) {
      try {
        imageBytes = base64Decode(base64Image);

      } catch (e) {
        print("Error decoding Base64: $e");
        imageBytes = null;
      }


    }
    return Scaffold(
      body: isLoadingConsumer
          ? const Center(
              child: SpinKitSquareCircle(color: Color(0xff4B6F39), size: 50.0))
          : LayoutBuilder(
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
                              foregroundImage: imageBytes != null
                                  ? MemoryImage(imageBytes)
                                  : const AssetImage('assets/F.jpg'),
                              maxRadius: 50,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: constraints.maxWidth * 0.03,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: uploadImg,
                                      icon: const Icon(Icons.edit,
                                          size: 15, color: Colors.blue)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              consumerData?['fullName'],
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              consumerData?['phone'],
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.04,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              consumerData?['email'],
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
                                _buildIconButton(Icons.local_shipping,
                                    'Package', constraints),
                                _buildIconButton(Icons.local_shipping_outlined,
                                    'To ship', constraints),
                                _buildIconButton(Icons.fact_check_outlined,
                                    'To check', constraints),
                                _buildIconButton(
                                    Icons.undo, 'Returns', constraints),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildListTile(Icons.person, 'Update Profile', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(consumerData:consumerData),
                                ),
                              );
                            }),
                            _buildListTile(
                                Icons.inventory, 'My Products', () {}),
                            _buildListTile(
                                Icons.help, 'Help and Support', () {}),
                            _buildListTile(Icons.settings, 'Setting', () {}),
                            _buildListTile(Icons.logout, 'Logout', () async {
                              await AuthService().logout(context);
                            }),
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

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[800]),
      onTap: onTap,
    );
  }
}
