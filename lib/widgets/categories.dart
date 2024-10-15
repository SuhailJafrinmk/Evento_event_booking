import 'package:evento_event_booking/blocs/category/bloc/category_bloc.dart';
import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:evento_event_booking/view/events/category_events.dart';
import 'package:evento_event_booking/view/home/category_page.dart';
import 'package:evento_event_booking/widgets/custom_cachednetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesList({required this.categories, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
       if(state is CategoryEventsFetched){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryEvents(categoryModel: state.categoryModel, eventModel: state.events)));
       }
      },
      child: Container(
        height: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            return InkWell(
              onTap: () {
                BlocProvider.of<CategoryBloc>(context)
                    .add(GetEventsByCategory(categoryModel: item));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: EdgeInsets.only(bottom: 3),
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.categoryBackgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipOval(
                          child: CustomCachedNetworkImage(
                              width: 40, height: 40, imageUrl: item.image),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          categories[index].name,
                          style: theme.textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
