import 'package:evento_event_booking/blocs/search/bloc/search_state.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:evento_event_booking/widgets/custom_textfield.dart';
import 'package:evento_event_booking/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../blocs/search/bloc/search_bloc.dart';



class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String? _selectedValue; // To track the selected dropdown item

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FetchAllItemsEvent());
    
    // When the list reaches the max scroll an event is fired to get more items from the API
    scrollController.addListener(() { 
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final currentState=context.read<SearchBloc>().state;
        if(currentState is ItemLoadedState && currentState.hasMoreItems){
          context.read<SearchBloc>().add(FetchMoreItemsEvents());
          logInfo('fetching more events');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
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
                context.read<SearchBloc>().add(FilterItemsEvent(
                    query: query, 
                    sortType: _selectedValue ?? 'name' // Ensure sorting applies during search
                ));
              },
            ),
            const SizedBox(height: 10,),
            
            // The list of events
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is ItemLoadingState) {
                    return const Center(
                      child: CustomProgressIndicator(size: 30,),
                    );
                  } else if (state is ItemErrorState) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is ItemLoadedState) {
                    logInfo('the next page url is ${state.nextPageUrl}');
                    if (state.filteredItems.isEmpty) {
                      return  Center(child: Lottie.asset(AssetImages.lottieNoData,height: size.height*.5,width: size.width*.5));
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
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
