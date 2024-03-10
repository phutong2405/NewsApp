import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/sideview/widgets/generic_widgets.dart';

// ignore: must_be_immutable
class DetailPageBody extends StatefulWidget {
  DetailPageBody(
      {super.key,
      this.expandedHeight,
      required this.icon,
      required this.appBloc,
      required this.article});
  final AppBloc appBloc;
  final Article article;
  double? expandedHeight;
  Icon icon;

  @override
  State<DetailPageBody> createState() => _DetailPageBodyState();
}

class _DetailPageBodyState extends State<DetailPageBody> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          detailpageHeader(context, widget.appBloc, widget.article),
          summaryView(
              context, widget.appBloc, widget.expandedHeight, widget.icon, () {
            setState(() {
              widget.expandedHeight = widget.expandedHeight == 0 ? null : 0;
              widget.icon = widget.expandedHeight == 0
                  ? const Icon(
                      CupertinoIcons.chevron_down,
                      size: 22,
                      color: Colors.blueGrey,
                    )
                  : const Icon(
                      CupertinoIcons.chevron_up,
                      size: 22,
                      color: Colors.blueGrey,
                    );
            });
          }),
          contentView(
            context,
            widget.appBloc,
            widget.article,
          ),
        ],
      ),
    );
  }
}

Widget detailpageHeader(
  BuildContext context,
  AppBloc appBloc,
  Article article,
) {
  return Column(
    children: [
      ///IMG
      Container(
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/filterbg.jpg"),
            fit: BoxFit.cover,
            opacity: 1,
            alignment: Alignment.center,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),

      ///BRAND
      Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "The New York Time",
                  maxLines: 2,
                  style: GoogleFonts.lato(fontSize: 14),
                ),
                const Spacer(),
                Text(
                  "40 ${tr("minutes")}",
                  maxLines: 2,
                  style: GoogleFonts.lato(fontSize: 14),
                ),
              ],
            ),
            divineSpace(height: 10),
            SelectableText(
              article.title,
              style: GoogleFonts.publicSans(
                  fontSize: 18, fontWeight: FontWeight.bold),
              textScaleFactor:
                  appBloc.localSettingDataService.getTextScaleFactor,
            ),
          ],
        ),
      )
    ],
  );
}

Widget summaryView(
  BuildContext context,
  AppBloc appBloc,
  double? expandedHeight,
  Icon icon,
  Function func,
) {
  return GestureDetector(
    onTap: () {
      func();
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          170,
          234,
          220,
          198,
        ),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.1),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Center(
                child: Text(
                  tr("ai"),
                  style: GoogleFonts.publicSans(
                      color: Colors.blueGrey,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              icon
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 150),
            curve: Curves.bounceInOut,
            child: Container(
              padding: const EdgeInsets.all(5),
              height: expandedHeight,
              width: double.infinity,
              // color: Colors.tealAccent,
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
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
                textScaleFactor:
                    appBloc.localSettingDataService.getTextScaleFactor,
              ),
            ),
          ),
          // Center(child: icon),
        ],
      ),
    ),
  );
}

Widget contentView(
  BuildContext context,
  AppBloc appBloc,
  Article article,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    // color: Colors.amber,
    padding: const EdgeInsets.only(
      left: 15,
      right: 15,
      top: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // htmlBody(),

        SelectableText(
          """Tóm tắt bài viết Người dân lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết:
\- Hàng nghìn người chen chúc, lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết.
- Bến xe Mỹ Đình chật kín người, nhiều tuyến xe hết vé.
- Nhiều người phải chờ đợi hàng giờ để mua vé và lên xe.
- Giao thông tại bến xe Mỹ Đình ùn tắc nghiêm trọng.
- Cần có giải pháp để giảm tải áp lực cho các bến xe trong dịp Tết.

Bài viết còn đề cập đến:

- Câu chuyện của một số người dân về hành trình về quê ăn Tết.
- Khuyến cáo của lực lượng chức năng về việc đảm bảo an toàn khi di chuyển. Tóm tắt bài viết Người dân lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết:
\- Hàng nghìn người chen chúc, lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết.
- Bến xe Mỹ Đình chật kín người, nhiều tuyến xe hết vé.
- Nhiều người phải chờ đợi hàng giờ để mua vé và lên xe.
- Giao thông tại bến xe Mỹ Đình ùn tắc nghiêm trọng.
- Cần có giải pháp để giảm tải áp lực cho các bến xe trong dịp Tết.

Bài viết còn đề cập đến:

- Câu chuyện của một số người dân về hành trình về quê ăn Tết.
- Khuyến cáo của lực lượng chức năng về việc đảm bảo an toàn khi di chuyển. Tóm tắt bài viết Người dân lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết:
\- Hàng nghìn người chen chúc, lỉnh kỉnh hành lý rời Hà Nội về quê ăn Tết.
- Bến xe Mỹ Đình chật kín người, nhiều tuyến xe hết vé.
- Nhiều người phải chờ đợi hàng giờ để mua vé và lên xe.
- Giao thông tại bến xe Mỹ Đình ùn tắc nghiêm trọng.
- Cần có giải pháp để giảm tải áp lực cho các bến xe trong dịp Tết.

Bài viết còn đề cập đến:

- Câu chuyện của một số người dân về hành trình về quê ăn Tết.
- Khuyến cáo của lực lượng chức năng về việc đảm bảo an toàn khi di chuyển.""",
          style: GoogleFonts.publicSans(
              fontSize: 17, fontWeight: FontWeight.normal),
          textScaleFactor: appBloc.localSettingDataService.getTextScaleFactor,
        ),
        footerButtonDetailPage(context, appBloc, article)
      ],
    ),
  );
}

Widget footerButtonDetailPage(
  BuildContext context,
  AppBloc appBloc,
  Article article,
) {
  return Container(
    height: 100,
    margin: const EdgeInsets.only(bottom: 21),
    child: Row(
      children: [
        IconButton(
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
        IconButton(
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {},
            icon: const Icon(CupertinoIcons.share)),
        IconButton(
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {},
            icon: const Icon(CupertinoIcons.globe)),
      ],
    ),
  );
}


// Widget htmlBody() {
//   return HtmlWidget(
//     // the first parameter (`html`) is required
//     // htmlString,
//     "",
//     customStylesBuilder: (element) {
//       if (element.classes.contains('foo')) {
//         return {'color': 'red'};
//       }

//       return null;
//     },

//     // this callback will be triggered when user taps a link

//     // select the render mode for HTML body
//     // by default, a simple `Column` is rendered
//     // consider using `ListView` or `SliverList` for better performance
//     renderMode: RenderMode.column,

//     // set the default styling for text
//     textStyle: GoogleFonts.roboto(fontSize: 15),
//   );
// }
