import 'package:evento_event_booking/blocs/profile/bloc/profile_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/about_us/about_us_page.dart';
import 'package:evento_event_booking/view/profile/edit_profile.dart';
import 'package:evento_event_booking/view/ticket_booking/booked_tickets_page.dart';
import 'package:evento_event_booking/view/wishlist/my_wishlist.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(GetProfileDetails());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                logInfo('the current state is $state');
                if (state is ProfileDataLoading) {
                  return CircularProgressIndicator();
                } else if (state is ProfileDataFetched) {
                  logInfo('the data is ${state.userProfile}');
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(state.userProfile.profilePicture ?? AssetImages.profileAvatar),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.userProfile.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.userProfile.email ?? 'guest@gmail.com',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButtonBlack(
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                        },
                        text: 'Edit profile',
                        color: AppColors.accentColor,
                        width: size.width * 0.3,
                        height: size.height * 0.05,
                        buttonRadius: 10,
                      ),
                    ],
                  );
                } else if (state is ErrorFetchingProfileData) {
                  return Text(
                    'Error: ${state.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Container(); // Fallback for unknown state
              },
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                buildProfileOption(
                  icon: Icons.account_circle_rounded,
                  title: 'My profile',
                  onTap: () {
                    // Add navigation to profile details
                  },
                ),
                buildProfileOption(
                  icon: Icons.favorite_outlined,
                  title: 'My Wishlist',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWishlistPage()));
                  },
                ),
                buildProfileOption(
                  icon: Icons.airplane_ticket_rounded,
                  title: 'My tickets',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BookedTicketsPage()));
                  },
                ),
                buildProfileOption(
                  icon: Icons.info,
                  title: 'About us',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption({
    required IconData icon,
    required String title,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {
        onTap();
      },
    );
  }
}
