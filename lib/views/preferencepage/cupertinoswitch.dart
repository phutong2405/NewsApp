import 'package:flutter/cupertino.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';

enum SwitchType {
  darkMode,
  expandedSummary,
  autoTranslate,
  textScaleFactor,
  languages,
  translateTo,
}

class CupertinoSwitchCustom extends StatefulWidget {
  final AppBloc appBloc;
  final SwitchType switchType;
  const CupertinoSwitchCustom({
    super.key,
    required this.appBloc,
    required this.switchType,
  });

  @override
  State<CupertinoSwitchCustom> createState() => _CupertinoSwitchCustomState();
}

class _CupertinoSwitchCustomState extends State<CupertinoSwitchCustom> {
  late bool switchValue;

  ///GETTING DATA TO UI
  bool switchType() {
    switch (widget.switchType) {
      case SwitchType.darkMode:
        return widget.appBloc.localSettingDataService.getDarkMode;
      case SwitchType.expandedSummary:
        return widget.appBloc.localSettingDataService.getExpandedSum;
      default:
        return false;
    }
  }

  ///Bloc EVENT TRIGGER
  void eventTrigger(bool value) {
    widget.appBloc.add(
      AppSettingChangedSwitchEvent(
        context: context,
        switchType: widget.switchType,
        isOn: value,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    switchValue = switchType();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      // This bool value toggles the switch.
      value: switchValue,
      activeColor: CupertinoColors.activeBlue.withOpacity(0.7),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          switchValue = value;
          eventTrigger(value);
        });
      },
    );
  }
}
