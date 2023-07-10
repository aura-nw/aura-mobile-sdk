import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/aura_navigator.dart';
import 'package:aura_wallet/src/core/utils/context_extension.dart';
import 'package:aura_wallet/src/presentation/screens/scan_qr/widgets/scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: true,
    detectionTimeoutMs: 2,
    returnImage: false,
  );
  final GlobalKey _cameraKey = GlobalKey();

  @override
  void initState() {
    if (_controller.isStarting) {
      _controller.stop();
    }

    _startCall();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  Future<void> _startCall() async {
    try {
      await _controller.start();
    } catch (e) {
      ///only first start camera event. Not handle
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (!_controller.isStarting) {
        await _startCall();
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: MobileScanner(
                  key: _cameraKey,
                  controller: _controller,
                  onDetect: (barcode) async{
                    if(barcode.barcodes.isNotEmpty){
                      final result = barcode.barcodes.first;
                      await _controller.stop();
                      AppNavigator.pop(result.rawValue);
                    }
                  },
                  errorBuilder: (_, error, child) {
                    return Container(
                      color: theme.primaryColor3.withOpacity(0.6),
                    );
                  },
                  placeholderBuilder: (context, child) {
                    return Container(
                      color: theme.primaryColor3.withOpacity(0.6),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  size: Size(
                    context.w,
                    context.h,
                  ),
                  painter: CustomPaintCamera(
                    theme,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ScannerWidget(
                  theme: theme,
                  child: const SizedBox(),
                ),
              ),
              Positioned(
                top: context.statusBar + 20,
                left: 30,
                child: InkWell(
                  onTap: () {
                    AppNavigator.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                      color: theme.lightColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomPaintCamera extends CustomPainter {
  final AppTheme theme;

  const CustomPaintCamera(this.theme);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    Paint paint = Paint()
      ..color = theme.darkColor.withOpacity(0.8)
      ..strokeWidth = 0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    path
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(0, size.height * 0.3)
      ..close();

    path
      ..moveTo(0, size.height * 0.3)
      ..lineTo(size.width * (1 / 7), size.height * 0.3)
      ..lineTo(size.width * (1 / 7), size.height * 0.7)
      ..lineTo(0, size.height * 0.7)
      ..close();

    path
      ..moveTo(0, size.height * 0.7)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.7)
      ..close();

    path
      ..moveTo(size.width, size.height * 0.7)
      ..lineTo(size.width * (6 / 7), size.height * 0.7)
      ..lineTo(size.width * (6 / 7), size.height * 0.3)
      ..lineTo(size.width, size.height * 0.3)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
