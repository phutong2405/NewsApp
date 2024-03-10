import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/bookmarkpage/bookmarkpage.dart';
import 'package:newsapplication/views/detailpage/detailpage.dart';
import 'package:newsapplication/views/sideview/widgets/fab.dart';
import 'package:newsapplication/views/preferencepage/preferencepage.dart';

class HomePage extends StatefulWidget {
  final AppBloc appBloc;
  final List<Article> data;
  const HomePage({super.key, required this.appBloc, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  // late ScrollController controllerHot;
  // bool fabIsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder(
        bloc: widget.appBloc,
        builder: (context, state) {
          if (state is AppLoaddedState) {
            return CustomScrollView(
              controller: controller,
              slivers: <Widget>[
                ///AppBar
                homepageAppBar(context, widget.appBloc),
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    widget.appBloc.add(const AppRefreshEvent());
                  },
                ),
                hottestListTile(
                  context,
                  widget.appBloc,
                  widget.data,
                ),
                trendingListTile(context),
                newsListTile(
                  context,
                  widget.appBloc,
                  widget.data,
                ),
                //Body
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: fabHomePage(
        context,
        controller,
      ),
    );
  }
}

Widget homepageAppBar(BuildContext context, AppBloc appBloc) {
  return SliverAppBar(
    pinned: false,
    floating: true,
    backgroundColor: Theme.of(context).colorScheme.background,
    shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
    toolbarHeight: 50,
    expandedHeight: 55.0,
    collapsedHeight: 55,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.none,
      title: Text(
        'Tinews',
        style: GoogleFonts.dancingScript(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    actions: [
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                      barrierDismissible: true,
                      semanticsDismissible: true,
                      builder: (context) => PreferencePage(appBloc: appBloc),
                      // fullscreenDialog: true
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.at,
                  color: Theme.of(context).colorScheme.onBackground,
                )),
            const Spacer(),
            // IconButton(
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       CupertinoDialogRoute(
            //         context: context,
            //         builder: (context) => const TodayHotPage(),
            //         // fullscreenDialog: true
            //       ),
            //     );
            //   },
            //   icon: const Icon(
            //     CupertinoIcons.today_fill,
            //     color: Colors.red,
            //     size: 27,
            //   ),
            // ),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.amber.withOpacity(0.7),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookmarkPage(
                        data: appBloc.bookmarkList,
                        appBloc: appBloc,
                      ),
                      // fullscreenDialog: true
                    ),
                  );
                },
                icon: const Icon(CupertinoIcons.bookmark_fill)),
          ],
        ),
      ),
    ],
  );
}

Widget newsListTile(
  BuildContext context,
  AppBloc appBloc,
  List<Article> data,
) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (_, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (index == 0)
              Container(
                  padding: const EdgeInsets.only(
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    tr("today"),
                    style: GoogleFonts.openSans(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ))
            else if (index == 10)
              Container(
                  padding: const EdgeInsets.only(
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    tr("yesterday"),
                    style: GoogleFonts.openSans(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ))
            else
              const SizedBox(),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(appBloc: appBloc, article: data[index]),
                ));
              },
              child: newsListTileView(context, appBloc, data[index]),
            ),
            if (index == data.length - 1)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            const Divider()
          ],
        );
      },
      childCount: data.length,
    ),
  );
}

Widget hottestListTile(
    BuildContext context, AppBloc appBloc, List<Article> data) {
  return SliverToBoxAdapter(
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: MediaQuery.of(context).size.width * 0.75,
      width: MediaQuery.of(context).size.width * 0.8,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.7,
          // viewportFraction: MediaQuery.of(context).size.width < 400 ? 0.7 : 0.8,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DetailPage(appBloc: appBloc, article: data[index]),
              ));
            },
            child: hottestListTileView(context, appBloc, data[index]),
          );
        },
      ),
    ),
  );
}

Widget trendingListTile(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 8),
        margin: const EdgeInsets.only(bottom: 8),
        height: 50,
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // "Trending\n 🔥 News:\n",
                    tr("trending"),
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 0.1),
                      color: const Color.fromARGB(
                        170,
                        234,
                        220,
                        198,
                      ),
                    ),
                    child: Text(
                      "Apple iphone 15",
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.1),
                  color: const Color.fromARGB(
                    170,
                    234,
                    220,
                    198,
                  ),
                ),
                child: Text(
                  "Apple iphone 15",
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              );
            }
          },
          itemCount: 10,
        )),
  );
}

Widget newsListTileView(
    BuildContext context, AppBloc appBloc, Article article) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    color: Colors.transparent,
    // width: 400,
    height: 150,
    child: Stack(
      children: [
        Positioned(
          child: Container(),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 0.1),
              color: const Color.fromARGB(
                170,
                234,
                220,
                198,
              ),
            ),
            width: MediaQuery.of(context).size.width - 40,
            height: 90,
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                // "Qualcomm bán Snapdragon 8 Gen 3 giá 200 USD, Qualcomm bán Snapdragon 8 Gen 3 giá 200 USD, có phải lý do S24 Ultra tăng giá?",
                article.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.publicSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
                textScaleFactor:
                    appBloc.localSettingDataService.getTextScaleFactor,
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              // color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // width: 190,
                    child: Text(
                      // "The New York Time \n40 minutes ago",
                      "${article.author} \n${article.date}",
                      maxLines: 2,
                      style: GoogleFonts.lato(fontSize: 13),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 19,
                    onPressed: () {
                      appBloc.add(
                        BookmarkClicked(article: article),
                      );
                    },
                    icon: !article.isBookmarked
                        ? const Icon(CupertinoIcons.bookmark)
                        : Icon(
                            CupertinoIcons.bookmark_fill,
                            color: Colors.amber.withOpacity(0.7),
                          ),
                  )
                ],
              ),
            ),
            const Spacer(),

            ///IMG
            Container(
              constraints: const BoxConstraints(
                maxHeight: 120,
                maxWidth: 120,
              ),
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey.shade400.withOpacity(0.7),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(2, 2),
                      color: Colors.grey,
                    )
                  ],
                  image: const DecorationImage(
                    // image: AssetImage(
                    //   "lib/assets/images/filterbg.jpg",
                    // ),
                    image: NetworkImage(
                      "https://photo2.tinhte.vn/data/attachment-files/2024/02/8263803_getty-uspto-patents.webp",
                      // article.thumbnailURL,
                    ),
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
      ],
    ),
  );
}

Widget hottestListTileView(
  BuildContext context,
  AppBloc appBloc,
  Article article,
) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(2),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10),
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width * 0.6,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "The New York Time \n40 ${tr("minutes")}",
                    maxLines: 2,
                    style: GoogleFonts.lato(fontSize: 13),
                    textScaleFactor:
                        appBloc.localSettingDataService.getTextScaleFactor,
                  ),
                ),
                const Spacer(),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 19,
                    onPressed: () {
                      appBloc.add(
                        BookmarkClicked(article: article),
                      );
                    },
                    icon: !article.isBookmarked
                        ? const Icon(CupertinoIcons.bookmark)
                        : Icon(
                            CupertinoIcons.bookmark_fill,
                            color: Colors.amber.withOpacity(0.7),
                          ))
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  "https://photo2.tinhte.vn/data/attachment-files/2024/02/8264348_Cover.jpg"),
              fit: BoxFit.cover,
              opacity: 0.25,
            ),
            // color: Colors.grey.shade400.withOpacity(0.7),
            color: const Color.fromARGB(
              170,
              234,
              220,
              198,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                // width: 240,
                child: Text(
                  "Qualcomm bán Snapdragon 8 Gen 3 giá 200 USD, Qualcomm bán Snapdragon 8 Gen 3 giá 200 USD, có phải lý do S24 Ultra tăng giá?",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.publicSans(
                      fontSize: 15, fontWeight: FontWeight.w800),
                  textScaleFactor:
                      appBloc.localSettingDataService.getTextScaleFactor,
                ),
              ),
              Text(
                "Xe máy len lỏi bên dòng ôtô nối dài trên đường Phan Trọng Tuệ hướng ra quốc lộ 1A cũ,Xe máy len lỏi bên dòng ôtô nối dài trên đường Phan Trọng Tuệ hướng ra quốc lộ 1A cũ, ùn tắc kéo dài đoạn câu Tó. Tuyến đường này có mặt đường hẹp, nhưng đón lượng lớn phương tiện tải trọng lớn lưu thông để tránh đi vào đường vành đai 3. ùn tắc kéo dài đoạn câu Tó. Tuyến đường này có mặt đường hẹp, nhưng đón lượng lớn phương tiện tải trọng lớn lưu thông để tránh đi vào đường vành đai 3.",
                maxLines: MediaQuery.of(context).size.width > 400 ? 9 : 7,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.publicSans(
                    fontSize: 14, fontWeight: FontWeight.w600),
                textScaleFactor:
                    appBloc.localSettingDataService.getTextScaleFactor,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
