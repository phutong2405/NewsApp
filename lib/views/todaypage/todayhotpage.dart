import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/views/widgets/fab.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

class TodayHotPage extends StatefulWidget {
  const TodayHotPage({super.key});

  @override
  State<TodayHotPage> createState() => _TodayHotPageState();
}

class _TodayHotPageState extends State<TodayHotPage> {
  @override
  Widget build(BuildContext context) {
    print("no");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Today',
          style: GoogleFonts.aladin(
            color: Colors.black,
            fontSize: 30,
            // fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(CupertinoIcons.clear, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: todayHotPageBody(context),
      // bottomSheet: filterBottomSheet(),
    );
  }
}

enum Time { today, yesterday }

Map<Time, Widget> skyColors = <Time, Widget>{
  Time.today: const Text("Today"),
  Time.yesterday: const Text("Yesterday"),
};

Widget todayHotPageBody(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    padding: const EdgeInsets.only(bottom: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color.fromARGB(
                170,
                234,
                220,
                198,
              ),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Today",
              //   style: GoogleFonts.publicSans(
              //       color: Colors.black,
              //       fontSize: 24,
              //       fontWeight: FontWeight.w700),
              // ),
              // divineSpace(
              //   height: 10,
              // ),
              CupertinoScrollbar(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 300,
                  width: double.infinity,
                  // color: Colors.tealAccent,
                  child: SingleChildScrollView(
                    child: SelectableText(
                      """Tóm tắt bài viết Người dân lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết:
                                \- Hàng nghìn người chen chúc, lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết.
                                - Bến xe Mỹ Đình chật kín người, nhiều tuyến xe hết vé.
                                - Nhiều người phải chờ đợi hàng giờ để mua vé và lên xe.
                                - Giao thông tại bến xe Mỹ Đình ùn tắc nghiêm trọng.
                                - Cần có giải pháp để giảm tải áp lực cho các bến xe trong dịp Tết.

                                Bài viết còn đề cập đến:

                                - Câu chuyện của một số người dân về hành trình về quê ăn Tết.
                                - Khuyến cáo của lực lượng chức năng về việc đảm bảo an toàn khi di chuyển.""",
                      style: GoogleFonts.publicSans(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              // Center(child: icon),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              CupertinoSlidingSegmentedControl(
                thumbColor: const Color.fromARGB(
                  170,
                  234,
                  220,
                  198,
                ),
                padding: const EdgeInsets.all(5),
                children: skyColors,
                onValueChanged: (value) {},
              ),
              const Spacer(),
              fabSFBlueprint(
                func: () {},
                content: const Icon(
                  CupertinoIcons.refresh,
                  color: Colors.black,
                ),
              ),
              divineSpace(width: 8),
              fabSFBlueprint(
                func: () {},
                content: const Icon(
                  CupertinoIcons.headphones,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget filterBottomSheet() {
  return BottomSheet(
    enableDrag: false,
    onClosing: () {},
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.01, color: Colors.blueGrey),
          gradient: const RadialGradient(
            radius: 1,
            colors: [
              Color.fromARGB(
                170,
                234,
                220,
                198,
              ),
              Colors.white
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(8), child: CupertinoSearchTextField()),
            divineSpace(height: 20),
            listFilterButton(context),
            divineSpace(height: 10),
            listFilterButton(context),
          ],
        ),
      );
    },
  );
}

Widget listFilterButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 8, bottom: 8),
    width: MediaQuery.of(context).size.width,
    height: 60,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Center(
            child: Text(
          "Page",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        )),
        divineSpace(width: 15),
        filterButton(),
        divineSpace(width: 15),
        filterButton(),
        divineSpace(width: 15),
        filterButton(),
        divineSpace(width: 15),
        filterButton(),
        divineSpace(width: 15),
        filterButton(),
        divineSpace(width: 15),
        filterButton(),
      ],
    ),
  );
}

Widget filterButton() {
  return GlassContainer(
    blur: 150,
    shadowColor: Colors.transparent,
    child: CupertinoButton(
      padding: const EdgeInsets.all(8),
      // color: Colors.amber.shade100,
      child: Row(
        children: [
          const Icon(
            Icons.sports,
            color: Colors.black,
          ),
          divineSpace(width: 5),
          const Text(
            "Sport",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
      onPressed: () {},
    ),
  );
}
