import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/services/consumer_controller.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:provider/provider.dart';

import '../../services/farmer_controller.dart';

class UpdateProfile extends StatefulWidget {
  final Map<String, dynamic>? farmerData;
  const UpdateProfile({super.key, this.farmerData});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill form fields with existing user data
    if (widget.farmerData != null) {
      _usernameController.text = widget.farmerData!['fullName'] ?? '';
      _emailController.text = widget.farmerData!['email'] ?? '';
      _phoneController.text = widget.farmerData!['phone'] ?? '';
    }
  }

  File? _image;
  final FarmerController _auth = FarmerController();
  String _base64Image = "";
  final picker = ImagePicker();

  uploadImg() async {
    final XFile? pickedImage2 =
    await picker.pickImage(source: ImageSource.gallery);
    final user = Provider.of<UserModel?>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    if (pickedImage2 != null) {
      final bytes = await pickedImage2.readAsBytes();
      final base64Image = base64Encode(bytes);

      try {
        await _auth
            .updateFarmerImage(context, user?.uid ?? '', base64Image);

        setState(() {
          _image = File(pickedImage2.path);
          _base64Image = base64Image;
          isLoading = false;
        });


      } catch (e) {
        ShowAlert.showAlert(
          context,
          "Error uploading image: ${e.toString()}",
          AlertType.error,
        );
      }
    }
  }

  _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final password = widget.farmerData!['password'];

        await _auth.updateFarmerProfile(
          context,
          widget.farmerData!['id'],
          {
            'email': _emailController.text.trim(),
            'fullName': _usernameController.text.trim(),
            'phone': _phoneController.text.trim(),
            'image': _base64Image,
          },
        );

        // Show success alert
        ShowAlert.showAlert(
          context,
          'Account Updated Successfully',
          AlertType.success,
        );

        // Navigate to account page
        Navigator.pushReplacementNamed(context, '/farm_acc');
      } catch (e) {
        // Handle error if update fails
        ShowAlert.showAlert(
          context,
          'Error updating profile: $e',
          AlertType.error,
        );
      } finally {
        // Reset loading state
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image =
        widget.farmerData!['image'] ?? ''; // Use the correct key here
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child:  VegHeader(title: 'Update Profile', route: '/farm_acc',),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture Section
                      CircleAvatar(
                        foregroundImage: imageBytes != null
                            ? MemoryImage(imageBytes)
                            : const AssetImage('assets/F.jpg'),
                        maxRadius: 50,
                      ),
                      TextButton(
                        onPressed: uploadImg,
                        child: const Text('Change Picture',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      const SizedBox(height: 20),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Fullname',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'FullName cannot be empty' : null,
                      ),
                      const SizedBox(height: 10),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Id',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) =>
                        value!.isEmpty || !value.contains('@')
                            ? 'Enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 10),

                      // Phone Number Field
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Phone number cannot be empty'
                            : null,
                      ),
                      const SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomNextButton(
                      text: 'Update', onPressed: _updateProfile))
            ],
          ),
        ),
      ),
    );
  }
}
