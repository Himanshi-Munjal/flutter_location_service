import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io' show Platform;

final MaterialColor themeMaterialColor =
BaseflowPluginExample.createMaterialColor(
    const Color.fromRGBO(48, 49, 60, 1)
);


void main() {
  runApp(const GeolocatorWidget ());
}

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({super.key});

  static ExamplePage createPage() {
    return ExamplePage(Icons.location_on, (context) => const GeolocatorWidget()
    );
  }


  @override
  State<GeolocatorWidget> createState() => _GeolocatorWidgetState();
}


class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  @override
  void initState() {
    super.initState();
    _toggleServiceStatusStream();
  }

  PopupMenuButton _createActions() {
    return PopupMenuButton(
      elevation: 40,
      onSelected: (value) async {
        switch (value) {
          case 1:
            _getLocationAccuracy();
            break;
          case 2:
            _requestTemporaryFullAccuracy();
            break;
          case 3:
            _openAppSettings();
            break;
          case 4:
            _openLocationSettings();
            break;
          case 5:
            setState(_positionItems.clear);
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) =>
      [
        if (Platform.isIOS)
          const PopupMenuItem(
            value: 1,
            child: Text('get location accuracy'),
          ),
        if (Platform.isIOS)
          const PopupMenuItem(
            value: 2,
            child: Text("Request Temporary Full Accuracy"),
          ),
        const PopupMenuItem(
          value: 3,
          child: Text("open app settings "),
        ),
        if(Platform.isAndroid || Platform.isWindows)
          const PopupMenuItem(
            value: 4,
            child: Text("open app settings"),
          ),
        const PopupMenuItem(
            value: 5,
            child: Text("clear")
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 10,
    );
    return BaseflowPluginExample(
        pluginName: 'Geolocator',
        githubURL: 'https://github.com/Baseflow/flutter-geolocator',
        pubDevURL: 'https://pub.dev/packages/geolocator',
        appBarActions: [
          _createActions()
        ],
        pages: [
        ExamplePage(
        Icons.location_on,
            (context) =>
            Scaffold(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                body: ListView.builder(
                  itemCount: _positionItems.length,
                  itemBuilder: (context, index) {
                    final positionItem = _positionItems[index];
                    if (positionItem.type == _positionItemType.log) {
                      return ListTile(
                        title:
                        Text(positionItem.displayValue,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      );
                    } else {
                      return Card(
                        child: ListTile(
                          tileColor:
                          themeMaterialColor,
                          title: Text(
                            positionItem.displayValue,
                            style: const TextStyle(color: colors.white),
                          ),
                        ),
                      );
                    }
                  },
                ),
                floatingActionButton: Column(
                    crossAxisAlignment.end,
                    MainAxisAlignment.end,
                    children: [
                    ]
                )
                }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}



