import 'package:flutter/material.dart';

const Color _brand = Color(0xFF1F4FD6);
const Color _brandDark = Color(0xFF1740A8);
const Color _pageBackground = Color(0xFFF6F8FB);
const Color _textPrimary = Color(0xFF172033);
const Color _textSecondary = Color(0xFF6B7280);
const Color _badgeColor = Color(0xFFFFC107);

class PricingPackage {
  final String id;
  final String name;
  final String tagline;
  final IconData icon;
  final String price;
  final int basePrice;
  final String unit;
  final List<String> features;
  final String description;
  final bool recommended;
  final Color pastelColor;

  const PricingPackage({
    required this.id,
    required this.name,
    required this.tagline,
    required this.icon,
    required this.price,
    required this.basePrice,
    required this.unit,
    required this.features,
    required this.description,
    this.recommended = false,
    required this.pastelColor,
  });
}

const starterPackage = PricingPackage(
  id: 'starter',
  name: 'Paket Starter',
  tagline: 'Landing page sederhana untuk mulai go-online dengan cepat.',
  icon: Icons.smartphone,
  price: 'Rp 1.500.000',
  basePrice: 1500000,
  unit: '/ proyek',
  features: [
    'Desain Landing Page Sederhana',
    'Form Kontak WhatsApp',
    'Responsif Mobile & Desktop',
    'Gratis Revisi 1x',
  ],
  description:
      'Paket ideal untuk UMKM, perorangan, atau bisnis rintisan yang ingin membangun kehadiran digital dengan cepat, terjangkau, dan tanpa kerumitan teknis.',
  pastelColor: Color(0xFFE8F1FF), // Pastel Blue
);

const professionalPackage = PricingPackage(
  id: 'professional',
  name: 'Paket Profesional',
  tagline: 'Solusi lengkap untuk bisnis yang siap scale.',
  icon: Icons.laptop_mac,
  price: 'Rp 5.000.000',
  basePrice: 5000000,
  unit: '/ proyek',
  features: [
    'Desain UI/UX Khusus & Prototipe',
    'Setup Database & Arsitektur Cloud',
    'Integrasi API Payment & Eksternal',
    'Dukungan Teknis & Garansi 30 Hari',
  ],
  description:
      'Dirancang khusus untuk bisnis berkembang yang membutuhkan aplikasi custom end-to-end dengan performa optimal, integrasi database, dan skalabilitas tinggi.',
  recommended: true,
  pastelColor: Color(0xFFF3E8FF), // Pastel Purple
);

const enterprisePackage = PricingPackage(
  id: 'enterprise',
  name: 'Paket Enterprise',
  tagline: 'Ekosistem digital skala besar dengan keandalan maksimal.',
  icon: Icons.business_center,
  price: 'Rp 12.000.000',
  basePrice: 12000000,
  unit: '/ proyek',
  features: [
    'Arsitektur Microservices & High-Availability',
    'Audit Keamanan & Penetrasi Standar ISO',
    'Multi-tenant & Dashboard Manajemen Tim',
    'Dedicated Technical Account Manager & SLA 99.9%',
  ],
  description:
      'Solusi komprehensif bagi korporasi atau startup skala lanjut dengan kebutuhan sistem kritikal, arsitektur terdistribusi, serta standar keamanan dan SLA kelas industri.',
  pastelColor: Color(0xFFFEF3C7), // Pastel Amber
);

const List<PricingPackage> pricingPackages = [
  starterPackage,
  professionalPackage,
  enterprisePackage,
];

void main() {
  runApp(const PricingCardApp());
}

class PricingCardApp extends StatelessWidget {
  const PricingCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Paket Layanan IT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _brand),
        scaffoldBackgroundColor: _pageBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: _textPrimary,
          elevation: 0.5,
          centerTitle: true,
        ),
      ),
      home: const CatalogHomeScreen(),
    );
  }
}

/// Screen 1: Beranda / Katalog (Wajib StatelessWidget)
class CatalogHomeScreen extends StatelessWidget {
  const CatalogHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Paket Layanan',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: pricingPackages.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final package = pricingPackages[index];
            return _CatalogCard(package: package);
          },
        ),
      ),
    );
  }
}

/// Card item di Screen 1 yang menggunakan ListTile dan tombol interaktif untuk navigasi
class _CatalogCard extends StatelessWidget {
  final PricingPackage package;

  const _CatalogCard({required this.package});

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCatalogScreen(package: package),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: package.recommended
              ? _brand.withValues(alpha: 0.5)
              : const Color(0xFFE5E7EB),
          width: package.recommended ? 1.5 : 1.0,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (package.recommended)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '★ Rekomendasi Pilihan',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: package.pastelColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(package.icon, color: _brandDark, size: 26),
              ),
              title: Text(
                package.name,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                package.tagline,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: _textSecondary, fontSize: 13),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: _textSecondary,
              ),
              onTap: () => _navigateToDetail(context),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mulai dari',
                      style: TextStyle(color: _textSecondary, fontSize: 11),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          package.price,
                          style: const TextStyle(
                            color: _brand,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          package.unit,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => _navigateToDetail(context),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('Detail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: package.recommended ? _brandDark : _brand,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Screen 2: Detail Katalog (Wajib StatefulWidget dengan Layout Vertikal Column)
class DetailCatalogScreen extends StatefulWidget {
  final PricingPackage package;

  const DetailCatalogScreen({super.key, required this.package});

  @override
  State<DetailCatalogScreen> createState() => _DetailCatalogScreenState();
}

class _DetailCatalogScreenState extends State<DetailCatalogScreen> {
  bool _isBookmarked = false;
  bool _isSelected = false;
  int _projectQuantity = 1;

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked
              ? '${widget.package.name} ditambahkan ke Favorit!'
              : '${widget.package.name} dihapus dari Favorit.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSelected
              ? 'Berhasil memilih ${widget.package.name}!'
              : 'Pilihan ${widget.package.name} dibatalkan.',
        ),
        backgroundColor: _isSelected ? Colors.green[700] : Colors.grey[800],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _changeQuantity(int delta) {
    final next = _projectQuantity + delta;
    if (next >= 1 && next <= 10) {
      setState(() {
        _projectQuantity = next;
      });
    }
  }

  String _formatCalculatedPrice() {
    final total = widget.package.basePrice * _projectQuantity;
    final buffer = StringBuffer('Rp ');
    final str = total.toString();
    final chars = str.split('');
    for (var i = 0; i < chars.length; i++) {
      if (i > 0 && (chars.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(chars[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Leading back icon eksplisit menggunakan Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Kembali ke Katalog',
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.package.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? _badgeColor : _textPrimary,
            ),
            tooltip: 'Simpan ke Favorit',
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      // Tata letak vertikal wajib menggunakan Column
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Icon & Nama Katalog
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: widget.package.pastelColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(widget.package.icon, color: _brand, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.package.name,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.package.tagline,
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 13,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Harga Utama
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.package.price,
                    style: const TextStyle(
                      color: _brandDark,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.package.unit,
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Container berlatar warna pastel dan padding sebagai tempat deskripsi (Requirement Wajib)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.package.pastelColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _brand.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.notes, size: 18, color: _brandDark),
                        SizedBox(width: 8),
                        Text(
                          'Ringkasan & Deskripsi Paket',
                          style: TextStyle(
                            color: _brandDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.package.description,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Fitur Layanan
              const Text(
                'Fitur yang Termasuk',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  for (final feature in widget.package.features)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFFDCFCE7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 14,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                color: _textPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE5E7EB)),
              const SizedBox(height: 16),

              // Interaktif StatefulWidget: Kuantitas Proyek & Estimasi Biaya
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumlah Kebutuhan Proyek',
                              style: TextStyle(
                                color: _textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Atur kuantitas lisensi/order',
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton.outlined(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: _projectQuantity > 1
                                  ? () => _changeQuantity(-1)
                                  : null,
                              visualDensity: VisualDensity.compact,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                '$_projectQuantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton.outlined(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: _projectQuantity < 10
                                  ? () => _changeQuantity(1)
                                  : null,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFF3F4F6)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Estimasi:',
                          style: TextStyle(
                            color: _textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _formatCalculatedPrice(),
                          style: const TextStyle(
                            color: _brandDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Interaktif State: Konfirmasi Pilihan Paket
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleSelection,
                  icon: Icon(
                    _isSelected
                        ? Icons.check_circle
                        : Icons.shopping_cart_checkout,
                  ),
                  label: Text(
                    _isSelected
                        ? '✓ Paket Telah Dipilih (Klik untuk Batalkan)'
                        : 'Pilih & Konfirmasi Paket Ini',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSelected
                        ? const Color(0xFF16A34A)
                        : _brand,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol Secondary untuk Favorit / Bookmark
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _toggleBookmark,
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: _isBookmarked
                        ? const Color(0xFFD97706)
                        : _textPrimary,
                  ),
                  label: Text(
                    _isBookmarked ? 'Tersimpan di Favorit' : 'Simpan ke Favorit',
                    style: TextStyle(
                      color: _isBookmarked
                          ? const Color(0xFFD97706)
                          : _textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(
                      color: _isBookmarked
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFFD1D5DB),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
