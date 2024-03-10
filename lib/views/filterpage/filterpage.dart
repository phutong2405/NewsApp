import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/views/sideview/widgets/generic_widgets.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  get itemBuilder => null;

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
              filterGrid(context, kNewsCategories),
              divineSpace(height: MediaQuery.of(context).size.width * 0.1),
              gridTitle(context, tr("byPages")),
              divineSpace(height: 5),
              filterGrid(context, kFamousNewspapers),
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

Widget filterGrid(BuildContext context, Map data) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
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
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
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
                    data.entries.elementAt(index).value,
                    const Spacer(),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.green,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                divineSpace(height: 5),
                Text(
                  data.entries.elementAt(index).key,
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
          );
        },
      ),
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

final Map<String, Icon> kNewsCategories = {
  'General': const Icon(CupertinoIcons.checkmark_alt),
  'Sports': const Icon(Icons.sports),
  'Business': const Icon(Icons.business),
  'Technology': const Icon(Icons.computer),
  'Entertainment': const Icon(Icons.movie),
  'Health': const Icon(Icons.healing),
  'Science': const Icon(Icons.science),
};

// final Map<String, Icon> kNewsCategories = {
//   'Everything': const Icon(CupertinoIcons.checkmark_alt),
//   'News': const Icon(CupertinoIcons.doc_append),
//   'Sports': const Icon(Icons.sports),
//   'Business': const Icon(Icons.business),
//   'Technology': const Icon(Icons.computer),
//   'Entertainment': const Icon(Icons.movie),
//   'Health': const Icon(Icons.healing),
//   'Fashion': const Icon(Icons.shopping_cart),
//   'Travel': const Icon(Icons.flight),
//   'Food': const Icon(Icons.restaurant),
//   'Real Estate': const Icon(Icons.home),
//   'Education': const Icon(Icons.school),
//   'Culture': const Icon(Icons.palette),
//   'Science': const Icon(Icons.science),
//   'History': const Icon(Icons.history),
//   'Environment': const Icon(Icons.nature),
//   'Cars': const Icon(Icons.directions_car),
//   'Humanities': const Icon(Icons.people),
//   'Law': const Icon(Icons.gavel),
//   'Politics': const Icon(Icons.flag),
// };

// businessentertainmentgeneralhealthsciencesportstechnology. Note: you can't mix this param with the sources

final Map<String, Icon> kFamousNewspapers = {
  'The New York Times': const Icon(CupertinoIcons.doc_append),
  'The Washington Post': const Icon(CupertinoIcons.doc_append),
  'The Wall Street Journal': const Icon(CupertinoIcons.doc_append),
  'USA Today': const Icon(CupertinoIcons.doc_append),
  'Los Angeles Times': const Icon(CupertinoIcons.doc_append),
  'The Guardian': const Icon(CupertinoIcons.doc_append),
  'The Independent': const Icon(CupertinoIcons.doc_append),
  'The Telegraph': const Icon(CupertinoIcons.doc_append),
  'Le Monde': const Icon(CupertinoIcons.doc_append),
  'El País': const Icon(CupertinoIcons.doc_append),
  'The Straits Times': const Icon(CupertinoIcons.doc_append),
  'The South China Morning Post': const Icon(CupertinoIcons.doc_append),
  'The Japan Times': const Icon(CupertinoIcons.doc_append),
  'The Korea Times': const Icon(CupertinoIcons.doc_append),
  'The Hindu': const Icon(CupertinoIcons.doc_append),
  'The Sydney Morning Herald': const Icon(CupertinoIcons.doc_append),
  'The Age': const Icon(CupertinoIcons.doc_append),
  'The Australian': const Icon(CupertinoIcons.doc_append),
  'The Courier-Mail': const Icon(CupertinoIcons.doc_append),
  'The West Australian': const Icon(CupertinoIcons.doc_append),
};

final Map<String, String> kFamousNewspapersLogos = {
  'The New York Times':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/The_New_York_Times_logo.svg/1200px-The_New_York_Times_logo.svg.png',
  'The Washington Post':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/The_Washington_Post_logo.svg/1200px-The_Washington_Post_logo.svg.png',
  'The Wall Street Journal':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/The_Wall_Street_Journal_logo.svg/1200px-The_Wall_Street_Journal_logo.svg.png',
  'USA Today':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/USA_Today_logo.svg/1200px-USA_Today_logo.svg.png',
  'Los Angeles Times':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Los_Angeles_Times_logo.svg/1200px-Los_Angeles_Times_logo.svg.png',
  'The Guardian':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_Guardian_logo.svg/1200px-The_Guardian_logo.svg.png',
  'The Independent':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/The_Independent_logo.svg/1200px-The_Independent_logo.svg.png',
  'The Telegraph':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/The_Telegraph_logo.svg/1200px-The_Telegraph_logo.svg.png',
  'Le Monde':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Le_Monde_logo.svg/1200px-Le_Monde_logo.svg.png',
  'El País':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/El_Pa%C3%ADs_logo.svg/1200px-El_Pa%C3%ADs_logo.svg.png',
  'The Straits Times':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/The_Straits_Times_logo.svg/1200px-The_Straits_Times_logo.svg.png',
  'The South China Morning Post':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/South_China_Morning_Post_logo.svg/1200px-South_China_Morning_Post_logo.svg.png',
  'The Japan Times':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/The_Japan_Times_logo.svg/1200px-The_Japan_Times_logo.svg.png',
  'The Korea Times':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/The_Korea_Times_logo.svg/1200px-The_Korea_Times_logo.svg.png',
  'The Hindu':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/The_Hindu_logo.svg/1200px-The_Hindu_logo.svg.png',
  'The Sydney Morning Herald':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/The_Sydney_Morning_Herald_logo.svg/1200px-The_Sydney_Morning_Herald_logo.svg.png',
  'The Age':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/The_Age_logo.svg/1200px-The_Age_logo.svg.png',
  'The Australian':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/The_Australian_logo.svg'
};
