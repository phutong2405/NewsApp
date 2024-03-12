import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/models/category_item.dart';
import 'package:newsapplication/views/sideview/widgets/generic_widgets.dart';

class FilterPage extends StatefulWidget {
  final AppBloc appBloc;
  const FilterPage({super.key, required this.appBloc});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  get itemBuilder => null;

  void tapToTile(CategoryItem categoryItem) {
    widget.appBloc.add(FilterClicked(categoryItem));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: filterPageBackground(
            context,
            [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CupertinoSearchTextField(
                  keyboardType: TextInputType.text,
                  placeholder: tr("search"),
                ),
              ),
              divineSpace(height: MediaQuery.of(context).size.width * 0.1),
              gridTitle(context, tr("byCategories")),
              divineSpace(height: 5),
              filterGrid(context, widget.appBloc, kNewsCategories, (item) {
                tapToTile(item);
              }),
              divineSpace(height: MediaQuery.of(context).size.width * 0.1),
              gridTitle(context, tr("byPages")),
              divineSpace(height: 5),
              filterGrid(context, widget.appBloc, kFamousNewspapers, (item) {
                tapToTile(item);
              }),
              divineSpace(height: 10),
              Container(
                  alignment: Alignment.centerRight,
                  child: textButtonCustom(
                    context,
                    tr("done"),
                    null,
                    () => Navigator.pop(context),
                  )),
            ],
          )),
    );
  }
}

Widget filterPageBackground(BuildContext context, List<Widget> widgets) {
  return GlassContainer(
    blur: 15,
    color: Theme.of(context).colorScheme.background.withOpacity(0.7),
    child: Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height > 800 ? 80 : 30,
          left: 15,
          right: 0),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...widgets],
      ),
    ),
  );
}

Widget filterGrid(
  BuildContext context,
  AppBloc appBloc,
  List<CategoryItem> categoryItems,
  Function(CategoryItem item) func,
) {
  return SizedBox(
    height: MediaQuery.of(context).size.width * 0.5,
    width: MediaQuery.of(context).size.width,
    child: GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.only(right: 8),
      itemCount: categoryItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            /////////////////////////////////////////////////////////////////////////////////////
            func(categoryItems[index]);
            /////////////////////////////////////////////////////////////////////////////////////
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    categoryItems[index].icon,
                    const Spacer(),
                    appBloc.filterItem == categoryItems[index]
                        ? const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.green,
                              size: 22,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                divineSpace(height: 5),
                Text(
                  categoryItems[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget gridTitle(BuildContext context, String title) {
  return Text(
    title,
    style: GoogleFonts.openSans(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 15,
        fontWeight: FontWeight.bold),
  );
}
