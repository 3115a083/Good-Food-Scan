import 'package:flutter/material.dart';
import '../../data/open_food_facts_api.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.barcode});
  final String barcode;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final Future<Map<String, dynamic>> _product = OpenFoodFactsApi().getProduct(widget.barcode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produkt')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Produktdaten konnten nicht geladen werden.\n${snapshot.error}', textAlign: TextAlign.center),
            ));
          }
          final product = (snapshot.data?['product'] as Map?)?.cast<String, dynamic>() ?? const <String, dynamic>{};
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(product['product_name']?.toString() ?? 'Unbekanntes Produkt', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(product['brands']?.toString() ?? 'Marke unbekannt'),
              const SizedBox(height: 20),
              Wrap(spacing: 8, runSpacing: 8, children: [
                _ScoreChip(label: 'Nutri-Score', value: product['nutrition_grades']),
                _ScoreChip(label: 'Green-Score', value: product['ecoscore_grade']),
                _ScoreChip(label: 'NOVA', value: product['nova_group']),
              ]),
              const SizedBox(height: 24),
              _Section(title: 'Zutaten', body: product['ingredients_text']?.toString() ?? 'Keine Angaben'),
              const _Section(title: 'Vegan / Vegetarisch', body: 'Analyse folgt in der nächsten Ausbaustufe.'),
              const _Section(title: 'Eigentümer', body: 'Ultimate-Parent-Resolver folgt.'),
              const _Section(title: 'BDS-Status', body: 'Offizielle, versionierte BDS-Datenquelle folgt.'),
              const SizedBox(height: 16),
              Text('Barcode: ${widget.barcode}', style: Theme.of(context).textTheme.bodySmall),
            ],
          );
        },
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip({required this.label, required this.value});
  final String label;
  final Object? value;
  @override
  Widget build(BuildContext context) => Chip(label: Text('$label: ${value ?? '?'}'));
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(body),
      ]),
    ),
  );
}
