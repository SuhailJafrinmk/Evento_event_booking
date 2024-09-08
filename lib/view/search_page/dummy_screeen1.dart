import 'package:evento_event_booking/blocs/search/bloc/search_bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:evento_event_booking/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FetchAllItemsEvent());
    //when the list reaches the max scroll an event is to get more items from the api
    scrollController.addListener(() { 
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        // BlocProvider.of<SearchBloc>(context).add(FetchMoreItemsEvents());
        logInfo('scroll is at max...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Search for an event',
              textEditingController: textEditingController,
              prefixIcon: Icons.search,
              onChanged: (query) {
                BlocProvider.of<SearchBloc>(context)
                    .add(FilterItemsEvent(query: query));
              },
            ),
            const SizedBox(height: 10,),
            Expanded(child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is ItemLoadingState) {
                  return Center(
                    child: CustomProgressIndicator(),
                  );
                } else if (state is ItemErrorState) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is ItemLoadedState) {
                  if (state.filteredItems.isEmpty) {
                    return Center(child: Text('No items found'));
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: state.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = state.filteredItems[index];
                      return EventTile(eventModel: item);
                    },
                  );
                }
                return SizedBox();
              },
            )),
          ],
        ),
      ),
    );
  }
}
