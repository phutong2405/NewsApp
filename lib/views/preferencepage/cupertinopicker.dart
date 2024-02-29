import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/views/preferencepage/cupertinoswitch.dart';
import 'package:newsapplication/views/preferencepage/preferencepage.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

const double _kItemExtent = 32.0;

class CupertinoPickerCustom extends StatefulWidget {
  final AppBloc appBloc;
  final List<String> selectionsName;
  final SwitchType switchType;
  final String title;
  final IconData iconData;
  const CupertinoPickerCustom({
    super.key,
    required this.appBloc,
    required this.selectionsName,
    required this.title,
    required this.iconData,
    required this.switchType,
  });

  @override
  State<CupertinoPickerCustom> createState() => _CupertinoPickerCustomState();
}

class _CupertinoPickerCustomState extends State<CupertinoPickerCustom> {
  late int _selectedName;

  ///GETTING DATA TO UI
  void switchType() {
    switch (widget.switchType) {
      case SwitchType.textScaleFactor:
        _selectedName =
            widget.appBloc.localSettingDataService.getTextScaleFactorPosition;

      case SwitchType.languages:
        _selectedName =
            widget.appBloc.localSettingDataService.getLanguagePosition;

      default:
        return;
    }
  }

  ///Bloc EVENT TRIGGER
  void eventTrigger(int selectedItem) {
    _selectedName = selectedItem;
    switch (widget.switchType) {
      case SwitchType.languages:
        widget.appBloc.add(
          AppSettingChangedLanguageEvent(
            switchType: widget.switchType,
            context: context,
          ),
        );
        break;
      case SwitchType.textScaleFactor:
        widget.appBloc.add(
          AppSettingChangedPickerEvent(
            switchType: widget.switchType,
            position: selectedItem,
          ),
        );
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    switchType();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listTileCustom(
      context: context,
      leading: Icon(
        widget.iconData,
        size: 20,
      ),
      title: widget.title,
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        // Display a CupertinoPicker with list of fruits.
        onPressed: () => _showDialog(
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoPicker(
                      magnification: 1,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedName,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        ////////////////////////////////////////////////////////////////////
                        setState(() {
                          eventTrigger(selectedItem);
                        });
                        ////////////////////////////////////////////////////////////////////
                      },
                      children: List<Widget>.generate(
                          widget.selectionsName.length, (int index) {
                        return Center(
                            child: Text(widget.selectionsName[index]));
                      }),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Text(
                            widget.title,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        doneFilterButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // This displays the selected fruit name.
        child: Text(
          widget.selectionsName[_selectedName],
          style: GoogleFonts.openSans(fontSize: 15),
        ),
      ),
    );
  }
}
