import 'package:flutter/material.dart';

const Color _brand = Color(0xFF1F4FD6);
const Color _brandDark = Color(0xFF1740A8);
const Color _pageBackground = Color(0xFFF3F5F9);
const Color _textPrimary = Color(0xFF172033);
const Color _textSecondary = Color(0xFF6B7280);
const Color _badgeColor = Color(0xFFFFC107);

class PricingPackage {
  final String id;
  final String name;
  final String tagline;
  final IconData icon;
  final String price;
  final String unit;
  final List<String> features;
  final String description;
  final bool recommended;

  const PricingPackage({
    required this.id,
    required this.name,
    required this.tagline,
    required this.icon,
    required this.price,
    required this.unit,
    required this.features,
    required this.description,
    this.recommended = false,
  });
}

const professionalPackage = PricingPackage(
  id: 'professional',
  name: 'Paket Profesional',
  tagline: 'Solusi lengkap untuk bisnis yang siap scale.',
  icon: Icons.laptop_mac,
  price: 'Rp 5.000.000',
  unit: '/ proyek',
  features: [
    'Desain UI/UX Khusus',
    'Setup Database',
    'Integrasi API',
    'Dukungan 30 Hari',
  ],
  description: 'Untuk bisnis yang butuh aplikasi custom end-to-end.',
  recommended: true,
);

const starterPackage = PricingPackage(
  id: 'starter',
  name: 'Paket Starter',
  tagline: 'Landing page sederhana untuk mulai go-online dengan cepat.',
  icon: Icons.smartphone,
  price: 'Rp 1.500.000',
  unit: '/ proyek',
  features: [
    'Desain Landing Page Sederhana',
    'Form Kontak WhatsApp',
    'Responsif untuk Mobile',
    'Gratis Revisi 1x',
  ],
  description: 'Cocok untuk UMKM yang baru punya website pertama.',
);

const List<PricingPackage> pricingPackages = [
  professionalPackage,
  starterPackage,
];

void main() {
  runApp(const PricingCardApp());
}

class PricingCardApp extends StatelessWidget {
  const PricingCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiered Pricing Card',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const _NoStretchScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _brand),
        scaffoldBackgroundColor: _pageBackground,
      ),
      home: const Scaffold(
        backgroundColor: _pageBackground,
        body: SafeArea(child: PricingPackageList()),
      ),
    );
  }
}

class _NoStretchScrollBehavior extends MaterialScrollBehavior {
  const _NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class PricingPackageList extends StatelessWidget {
  const PricingPackageList({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const sidePadding = 20.0;
        const cardGap = 20.0;
        final availableWidth = (constraints.maxWidth - (sidePadding * 2))
            .clamp(0.0, double.infinity)
            .toDouble();
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final isTwoColumn = isLandscape && constraints.maxWidth >= 720;
        final cardWidth = isTwoColumn
            ? ((availableWidth - cardGap) / 2).clamp(0.0, 300.0).toDouble()
            : availableWidth.clamp(0.0, 300.0).toDouble();

        final cards = [
          for (final package in pricingPackages)
            SizedBox(
              width: cardWidth,
              child: PricingCard(
                key: ValueKey('pricing-${package.id}'),
                package: package,
              ),
            ),
        ];

        final content = isTwoColumn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(width: cardGap),
                    cards[i],
                  ],
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    if (i > 0) const SizedBox(height: cardGap),
                    cards[i],
                  ],
                ],
              );

        final minContentHeight = constraints.hasBoundedHeight
            ? (constraints.maxHeight - 60)
                  .clamp(0.0, double.infinity)
                  .toDouble()
            : 0.0;

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(sidePadding, 28, sidePadding, 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minContentHeight),
            child: SizedBox(
              width: availableWidth,
              child: Center(child: content),
            ),
          ),
        );
      },
    );
  }
}

class PricingCard extends StatelessWidget {
  final PricingPackage package;

  const PricingCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label:
          '${package.name}, ${package.recommended ? "kartu harga rekomendasi" : "kartu harga"}, harga ${package.price} ${package.unit}',
      child: Container(
        key: ValueKey('card-${package.id}'),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, package.recommended ? 54 : 24, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x18000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PackageHeader(package: package),
                const SizedBox(height: 20),
                _PriceRow(price: package.price, unit: package.unit),
                const SizedBox(height: 14),
                Text(
                  package.description,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                _FeatureList(features: package.features),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: Semantics(
                    button: true,
                    label: 'Pilih ${package.name}',
                    hint: 'Tampilkan konfirmasi pilihan paket',
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text('${package.name} dipilih')),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: package.recommended
                            ? _brandDark
                            : _brand,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(48),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Pilih Paket',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (package.recommended)
              const Positioned(top: 0, right: 0, child: _Badge()),
          ],
        ),
      ),
    );
  }
}

class _PackageHeader extends StatelessWidget {
  final PricingPackage package;

  const _PackageHeader({required this.package});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(child: Icon(package.icon, size: 40, color: _brand)),
        const SizedBox(height: 12),
        Text(
          package.name,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          package.tagline,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 13,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String price;
  final String unit;

  const _PriceRow({required this.price, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              price,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(unit, style: const TextStyle(color: _textSecondary, fontSize: 14)),
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  final List<String> features;

  const _FeatureList({required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < features.length; i++) ...[
          if (i > 0) const SizedBox(height: 9),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExcludeSemantics(
                child: Icon(Icons.check, size: 18, color: _brand),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  features[i],
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Badge Rekomendasi',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _badgeColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          'Rekomendasi',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
