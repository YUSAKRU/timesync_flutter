import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../common/custom_network_image.dart';
import 'booking/service_selection_screen.dart';

class BusinessDetailScreen extends ConsumerStatefulWidget {
  final String businessId;
  final String businessName;
  final String businessImage;
  final double rating;
  final int reviewCount;

  const BusinessDetailScreen({
    super.key,
    required this.businessId,
    required this.businessName,
    required this.businessImage,
    required this.rating,
    required this.reviewCount,
  });

  @override
  ConsumerState<BusinessDetailScreen> createState() =>
      _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends ConsumerState<BusinessDetailScreen> {
  String _selectedTab = 'Hizmetler';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildBusinessInfo(),
                _buildTabs(),
                _buildTabContent(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBookingBar(context),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.surfaceDark,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: widget.businessImage,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.businessName,
            style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${widget.rating}',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${widget.reviewCount} değerlendirme)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, 'Kadıköy, İstanbul'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.access_time, 'Açık • 09:00 - 20:00'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone, '+90 555 123 4567'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[300]),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final tabs = ['Hizmetler', 'Çalışanlar', 'Yorumlar', 'Hakkında'];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: tabs.map((tab) => _buildTab(tab)).toList(),
      ),
    );
  }

  Widget _buildTab(String label) {
    final isSelected = _selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: isSelected ? AppColors.darkBackground : Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 'Hizmetler':
        return _buildServices();
      case 'Çalışanlar':
        return _buildEmployees();
      case 'Yorumlar':
        return _buildReviews();
      case 'Hakkında':
        return _buildAbout();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildServices() {
    final services = [
      {'name': 'Saç Kesimi', 'duration': '45 dk', 'price': '₺150'},
      {'name': 'Sakal Tıraşı', 'duration': '30 dk', 'price': '₺80'},
      {'name': 'Saç + Sakal', 'duration': '60 dk', 'price': '₺200'},
      {'name': 'Cilt Bakımı', 'duration': '45 dk', 'price': '₺180'},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hizmetlerimiz',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...services.map((service) => _buildServiceCard(service)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, String> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name']!,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      service['duration']!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            service['price']!,
            style: AppTextStyles.h4.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployees() {
    final employees = [
      {
        'name': 'Ahmet Yılmaz',
        'role': 'Baş Berber',
        'rating': 4.9,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuA8Hfs8i19B1mHAWKKRbYc3TCd-lL0bk3I0yOWDWGHGjJKDWV1LB1xPJ-TtWxmR0kNEGtKJjm79A8VnlJ9sCCbdR5V8qiTgKwqTNA',
      },
      {
        'name': 'Mehmet Demir',
        'role': 'Berber',
        'rating': 4.8,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAsYkyxwAOw5ioHq3gtXl0Ic5KSBbDisOHy4SI2rRON9dn9NfqC4vu1yb2aHyq5ozA6SPH1rwPeFyLhrdGSdpW8FaVVOP34pNLuEiTJw9pBnil8oEUDEXxbs_aPmTE5DQkIJy7CzyJFoYpwyTE1xVBhnpoHxyT22WYzj0UBATP7F5GjGLb-Lz-queuEO6A2lnTAg05A4coJOo53ZMloVLW9V_hYjFGZLfWmGeq1AU5UdW-Nxlu3OZue5dHI57nXPDL4sFXFfrGbjnQ',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Çalışanlarımız',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...employees.map((employee) => _buildEmployeeCard(employee)),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              image: DecorationImage(
                image: NetworkImage(employee['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee['name'],
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employee['role'],
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '${employee['rating']}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    final reviews = [
      {
        'name': 'Burak Yılmaz',
        'rating': 5,
        'date': '2 gün önce',
        'comment': 'Harika bir işletme, kesinlikle tavsiye ederim!',
      },
      {
        'name': 'Can Öztürk',
        'rating': 4,
        'date': '1 hafta önce',
        'comment': 'Güzel hizmet, profesyonel ekip.',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yorumlar',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...reviews.map((review) => _buildReviewCard(review)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review['name'],
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ...List.generate(
                5,
                (index) => Icon(
                  index < review['rating'] ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review['comment'],
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            review['date'],
            style: AppTextStyles.caption.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hakkında',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            '2015 yılından beri hizmet veren ${widget.businessName}, modern ve profesyonel hizmet anlayışıyla sizlere en iyi deneyimi sunmayı hedeflemektedir. Uzman kadromuz ve kaliteli ürünlerimizle güzelliğinize güzellik katıyoruz.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey[300],
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Çalışma Saatleri',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildWorkingHour('Pazartesi - Cuma', '09:00 - 20:00'),
          _buildWorkingHour('Cumartesi', '10:00 - 18:00'),
          _buildWorkingHour('Pazar', 'Kapalı'),
        ],
      ),
    );
  }

  Widget _buildWorkingHour(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[400]),
          ),
          Text(
            hours,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceSelectionScreen(
                  businessId: widget.businessId,
                  businessName: widget.businessName,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.darkBackground,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 8),
              Text(
                'Randevu Al',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.darkBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
