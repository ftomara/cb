import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cb/Data/hiveservices.dart';
import 'package:cb/Data/sketch.dart';
import 'package:cb/Logic/paintcanvas.dart';
import 'package:cb/Logic/propertiescubit.dart';
import 'package:cb/Logic/undo_redo_cubit.dart';
import 'package:cb/Logic/undo_redo_state.dart';
import 'package:cb/Presentation/Screens/homescreen.dart';
import 'package:cb/Presentation/Widgets/paint_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

class Paintscreen extends StatefulWidget {
  Paintscreen({super.key, this.impath, this.history, this.index, this.list});
  String? impath;
  Uint8List? history;
  int? index;
  List<Sketch>? list = [];

  @override
  State<Paintscreen> createState() => _PaintscreenState();
}

class _PaintscreenState extends State<Paintscreen> {
  Sketch sketch = Sketch(points: []);
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  Hiveservices hive = Hiveservices();
  double _sacle = 1.0;
  double _pScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  bool _isScaling = false;
  final Offset _pivotPoint = Offset.zero;

  @override
  void initState() {
    super.initState();
    sketch.strokeColor = context.read<Propertiescubit>().list[1];
    sketch.strokeSize = context.read<Propertiescubit>().list[2];
    sketch.estrokeSize = context.read<Propertiescubit>().list[3];
    sketch.brushmode = context.read<Propertiescubit>().list[4];
    checkAndRequestPermissions();
  }

  Offset transformCoordinate(Offset point) {
    return (point - _offset) / _sacle;
  }

  Future<void> saveToHive() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      await hive.storeImage(pngBytes);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> replaceImage(int index) async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      debugPrint("Bytes length: ${pngBytes.length}");

      await hive.updateImageAt(index, pngBytes);

      debugPrint("Image updated at index: $index");
    } catch (e) {
      debugPrint("Error in replaceImage: $e");
    }
  }

  Future<void> checkAndRequestPermissions() async {
    bool statuses;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      statuses =
          sdkInt < 29 ? await Permission.storage.request().isGranted : true;
    } else {
      statuses = await Permission.photosAddOnly.request().isGranted;
    }
    _toastInfo('Permission Request Result: $statuses');
  }

  Future<void> saveScreen() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        String picturesPath = "${DateTime.now().millisecondsSinceEpoch}.jpg";
        final result = await SaverGallery.saveImage(
          byteData.buffer.asUint8List(),
          fileName: picturesPath,
          skipIfExists: false,
        );
        _toastInfo(result.toString());
      }
    } catch (e) {
      _toastInfo('Error: $e');
    }
  }

  void _toastInfo(String info) {
    debugPrint(info);
    // Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إرسمي",
          style: GoogleFonts.notoSansArabic(
              color: const Color(0XFF8B79CC),
              fontSize: 24.sp,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            if (context.read<UndoRedoCubit>().state.undoList.isNotEmpty) {
              if (widget.history != null && widget.index != null) {
                await replaceImage(widget.index!);
              } else {
                await saveToHive();
              }
            }
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Homescreen()));
            setState(() {
              context.read<UndoRedoCubit>().clear();
              context.read<Propertiescubit>().resetProperites();
            });
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0XFF8B79CC),
            size: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // _saveToGallery();
              saveScreen().then((value) => Fluttertoast.showToast(
                  msg: "تم حفظ الصورة بنجاح",
                  backgroundColor: const ui.Color.fromARGB(255, 179, 165, 231),
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                  fontSize: 20));
            },
            icon: const Icon(
              Icons.save_outlined,
              color: Color(0XFF8B79CC),
              size: 40,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocListener<Propertiescubit, List<dynamic>>(
        listener: (context, state) {
          sketch.isEraser = context.read<Propertiescubit>().list[0];
          sketch.strokeColor = context.read<Propertiescubit>().list[1];
          sketch.strokeSize = context.read<Propertiescubit>().list[2];
          sketch.estrokeSize = context.read<Propertiescubit>().list[3];
          sketch.brushmode = context.read<Propertiescubit>().list[4];
        },
        child: GestureDetector(
          onScaleStart: (details) {
            _initialFocalPoint = details.focalPoint;
            _pScale = _sacle;
            // debugPrint(
            // "onScaleStart: Pointer count is ${details.pointerCount}");
            setState(() {
              _isScaling =
                  details.pointerCount > 1; // Detect multi-touch gesture
              // debugPrint("onScaleStart: _isScaling set to $_isScaling");
            });
            // debugPrint(
            // "onScaleStart: initial scale $_pScale, initial focal point $_initialFocalPoint");
          },
          onScaleUpdate: (details) {
            if (_isScaling) {
              setState(() {
                _sacle = _pScale * details.scale;
                _offset += (details.focalPoint - _initialFocalPoint) / _sacle;
                _initialFocalPoint = details.focalPoint;
              });
              debugPrint("Zoom scale: $_sacle, Offset: $_offset");
            } else {
              setState(() {
                sketch.points.add(transformCoordinate(details.localFocalPoint));
              });
            }
          },
          onScaleEnd: (details) {
            // debugPrint("onScaleEnd: Gesture ended, _isScaling was $_isScaling");
            setState(() {
              _isScaling = false; // Reset scaling flag when gesture ends
              context.read<UndoRedoCubit>().addToList(sketch);
              sketch = Sketch(
                points: [],
                strokeColor: sketch.strokeColor,
                isEraser: sketch.isEraser,
                strokeSize:
                    sketch.isEraser ? sketch.estrokeSize : sketch.strokeSize,
                brushmode: sketch.brushmode,
              );
              debugPrint("onScaleEnd: Sketch reset and added to undo list");
            });
          },
          // onPanStart: (details) {
          //   Offset offset = details.localPosition;
          //   setState(() {
          //     sketch.points.add(offset);
          //   });
          // },
          // onPanUpdate: (details) {
          //   Offset offset = details.localPosition;
          //   setState(() {
          //     sketch.points.add(offset);
          //   });
          // },
          // onPanEnd: (details) {
          //   setState(() {
          //     context.read<UndoRedoCubit>().addToList(sketch);
          //     // list.add(sketch);
          //     sketch = Sketch(
          //       points: [],
          //       strokeColor: sketch.strokeColor,
          //       isEraser: sketch.isEraser,
          //       strokeSize:
          //           sketch.isEraser ? sketch.estrokeSize : sketch.strokeSize,
          //       brushmode: sketch.brushmode,
          //     );
          //   });
          // },
          child: BlocBuilder<UndoRedoCubit, UndoRedoState>(
              builder: (context, state) {
            return RepaintBoundary(
              key: _repaintBoundaryKey,
              child: Stack(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(_offset.dx, _offset.dy)
                      ..scale(_sacle),
                    child: widget.impath != null
                        ? Image.asset(
                            widget.impath!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : widget.history != null
                            ? Image.memory(
                                widget.history!,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Container(
                                color: Colors.white,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                  ),
                  CustomPaint(
                    painter: PaintCanvas(
                      sketches: state.undoList + [sketch],
                      scale: _sacle,
                      offset: _offset,
                    ),
                    child: Container(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: const PaintBar(),
    );
  }
}










//PaintCanvas(
                          // sketches: state.undoList + [sketch],
                        // ),