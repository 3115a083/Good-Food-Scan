import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../product/product_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _openingProduct = false;

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_openingProduct || capture.barcodes.isEmpty) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;
    _openingProduct = true;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductScreen(barcode: code)),
    );
    _openingProduct = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Good Food Scan')),
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
              child: MobileScanner(onDetect: _handleBarcode),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              children: [
                Text('Barcode scannen', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                const Text(
                  'Zeige den Barcode eines Lebensmittels in die Kamera. Produktdaten werden über Open Food Facts geladen.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
