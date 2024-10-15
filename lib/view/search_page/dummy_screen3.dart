import 'package:evento_event_booking/blocs/ticket_booking/bloc/ticket_booking_bloc.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/ticket_booking/booked_tickets_page.dart';
import 'package:evento_event_booking/widgets/custom_button_black.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(AssetImages.profileAvatar)
                ),
                const SizedBox(height: 10),
                const Text(
                  'Guest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'guest@gmail.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
               CustomButtonBlack(
                ontap: () {
                  BlocProvider.of<TicketBookingBloc>(context).add(GetBookedTickets());
                },
                text: 'Edit profile',
               color: AppColors.accentColor,
               width: size.width*.3,
               height: size.width*.15,
               buttonRadius: 20,
              //  buttonTextStyle: ,
               )
              ],
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
                  },
                ),
                buildProfileOption(
                  icon: Icons.favorite_outlined,
                  title: 'My Wishlist',
                  onTap: () {
                  },
                ),
                buildProfileOption(
                  icon: Icons.airplane_ticket_rounded,
                  title: 'My tickets',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookedTicketsPage()));
                  },
                ),
                  ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {

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
