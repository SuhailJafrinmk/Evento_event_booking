import 'dart:io';
import 'package:evento_event_booking/blocs/profile/bloc/profile_bloc.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save the profile to backend or database
      // Use _nameController.text, _emailController.text, _phoneController.text for the data
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage(AssetImages.profileAvatar) as ImageProvider, // Placeholder image
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
                SizedBox(height: 20),

                // Name input
               CustomTextField(
                prefixIcon: Icons.account_circle,
                hintText: 'Name',
                 textEditingController: _nameController),
                SizedBox(height: 20,),
                CustomElevatedButton(
                  buttonChild: Text('Save profile'),
                  onTap: () {
                    print('button clicked');
                    BlocProvider.of<ProfileBloc>(context).add(EditProfileClicked(image: _profileImage, userName: _nameController.text));
                  },

                  ),
                // CustomButtonBlack(
                //   ontap: () {
                //     print('button clicked');
                //     BlocProvider.of<ProfileBloc>(context).add(EditProfileClicked(image: _profileImage, userName: _nameController.text));
                //   },
                //   color: AppColors.accentColor,
                //   text: 'Save profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
