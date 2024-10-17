import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWishlistPage extends StatefulWidget {
  @override
  State<MyWishlistPage> createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavouritesBloc>(context).add(GetAllFavouriteEvents());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<FavouritesBloc, FavouritesState>(
                builder: (context, state) {
                  if (state is GetAllFavouritesSuccess) {
                    if (state.favouriteEvents.isEmpty) {
                      return Center(
                        child: Text(
                          'No items in favourite list',
                          style: theme.textTheme.bodySmall,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      scrollDirection: Axis.vertical,
                      itemCount: state.favouriteEvents.length,
                      itemBuilder: (context, index) {
                        final item = state.favouriteEvents[index];
                        return EventTile(eventModel: item);
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator while fetching
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
