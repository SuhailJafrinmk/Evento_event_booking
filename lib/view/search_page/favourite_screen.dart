import 'package:evento_event_booking/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:evento_event_booking/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavouritesBloc>(context).add(GetAllFavouriteEvents());
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Favorites',style: theme.textTheme.displayLarge,),
          SizedBox(height: 10,),
          Expanded(
            child: BlocBuilder<FavouritesBloc, FavouritesState>(
              builder: (context, state) {
                if(state is GetAllFavouritesSuccess){
                  if(state.favouriteEvents.isEmpty){
                    return Center(
                      child:Text('No items in favourite list',style: theme.textTheme.bodySmall,),
                    );
                  }
                 return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.favouriteEvents.length,
                  itemBuilder: (context, index) {
                    final item=state.favouriteEvents[index];
                    return EventTile(eventModel: item);
                  },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
