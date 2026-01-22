import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/auth/auth_provider.dart';
import '../../core/providers/auth/auth_state.dart';
import '../../data/models/user_model.dart';

enum RegisterType { customer, business }

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  RegisterType _selectedType = RegisterType.customer;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        authenticated: (user) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              _getRouteForRole(user.role),
            );
          }
        },
        unauthenticated: () {},
        error: (message) {
          setState(() {
            _errorMessage = message;
          });
        },
      );
    });

    final authState = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Stack(
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDqs9IKaOkUxrImPV6ZJsrx1crTBtfXFxJ2zBoCObEr_ZOunYpGgTpG3zvPXnPw1FDlKlE_qZH8G22jltMMEExNZpOdoG37aX5Yap4pYVEQUF9kfeW5q7bv9MMtXomhy53PoY6P1FbKojPDfqWDP5RqNXdjpOVmY77r1gLpqo_kQvvGMTrmpw_8xyyNtV3nGB98omXgvxUJsfoqyu5S3fQCWfmsHfhZKvHAUgqUWjb_FdZfPr17JVAh1YK4jPXCIqUVTS3mTC34us8',
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.6),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDark.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Sheet Modal
          Column(
            children: [
              // Back button
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              
              const Spacer(),
              
              SingleChildScrollView(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Handle
                        _buildHandle(),
                        
                        // Header
                        _buildHeader(),
                        
                        // Segmented Control
                        _buildSegmentedControl(),
                        
                        // Error Message
                        if (_errorMessage != null) _buildErrorMessage(),
                        
                        // Form
                        _buildForm(),
                        
                        // Register Button
                      _buildRegisterButton(authState),
                        // Divider
                        _buildDivider(),
                        
                        // Social Register
                        _buildSocialRegister(),
                        
                        // Login Link
                        _buildLoginLink(),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Loading overlay
          authState.maybeWhen(
            loading: () => Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Center(
        child: Container(
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Text(
        'Hesap Oluştur',
        style: AppTextStyles.h1.copyWith(
          color: Colors.white,
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF1d3629),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildSegmentButton(
                'Müşteri',
                RegisterType.customer,
                Icons.person,
              ),
            ),
            Expanded(
              child: _buildSegmentButton(
                'İşletme',
                RegisterType.business,
                Icons.storefront,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String label, RegisterType type, IconData icon) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          // Name Field
          _buildTextField(
            controller: _nameController,
            hint: _selectedType == RegisterType.customer ? 'Ad Soyad' : 'İşletme Adı',
            icon: _selectedType == RegisterType.customer ? Icons.person_outline : Icons.store_outlined,
          ),
          
          const SizedBox(height: 16),
          
          // Email Field
          _buildTextField(
            controller: _emailController,
            hint: 'E-posta Adresi',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          
          const SizedBox(height: 16),
          
          // Password Field
          _buildTextField(
            controller: _passwordController,
            hint: 'Şifre',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[500],
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Confirm Password Field
          _buildTextField(
            controller: _confirmPasswordController,
            hint: 'Şifre Tekrar',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[500],
              ),
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1d3629),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.grey[500],
          ),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(AuthState authState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: authState.maybeWhen(
            loading: () => null,
            orElse: () => _handleRegister,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: authState.maybeWhen(
            loading: () => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
            orElse: () => Text(
              'Kayıt Ol',
              style: AppTextStyles.button.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'VEYA ŞUNUNLA DEVAM ET',
              style: AppTextStyles.caption.copyWith(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
        ],
      ),
    );
  }

  Widget _buildSocialRegister() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton(
            'Google',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBXBkiAPpnUNkHDFE6XTB-ajsYFvO6vFa5YyTQJQHjLiEcix1xcwVr587BTwAI1T2zRNRV2G2v8b34qc7SiHk4YUHEis9yxSODHhA9xwYXcyxU0ahWxgJk9vkZVyetGePvQ2IPUlxRl1bB3-WiBxuN8CdSNCUZozXWeK_9RvD36csWNhcU3l5kF_-whY5CWZGPmjbjqmt5DwsaCf_Sqb6hdxKuTqmNSfSqlLmNPiKcyVb005BrfRZNJTay89oBrvoXBqwAzAbWgaYI',
            () {
              // TODO: Google register
            },
          ),
          const SizedBox(width: 16),
          _buildSocialButton(
            'Apple',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAXBUi0ulVNZWTVvYBAIF5qE5GyxzUihotX3dqsP4TVnxH8rAG0MVMqUSl3DTTulHuzMKm7-MWOtNNV0imnn_z-bk-UlSkEhw-uS5_SU0tMIr4r7srlcbWD3Z0Yd170UpcXLrZyFwMax90X-Wz7NbA3EKW75sd-TRvY9sk6o8e3f6w-fk9YAq7ywjOapkMvLvjfCmgnCr1VDny5hf3ZRKxzIPMxL3A_7IslY5NQC8xVJ3eD8S4LchLrhGsOhCEMUA9KHSY-z3OluMQ',
            () {
              // TODO: Apple register
            },
            invertLogo: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String label, String logoUrl, VoidCallback onTap, {bool invertLogo = false}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1d3629),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: invertLogo
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                child: Image.network(
                  logoUrl,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Zaten hesabınız var mı? ',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey[400],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Giriş Yap',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[300], size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _errorMessage!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.red[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRouteForRole(UserRole role) {
    switch (role) {
      case UserRole.customer:
        return '/customer';
      case UserRole.employee:
        return '/employee';
      case UserRole.business:
        return '/business';
      case UserRole.admin:
        return '/admin';
    }
  }

  Future<void> _handleRegister() async {
    setState(() {
      _errorMessage = null;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Lütfen tüm alanları doldurun';
      });
      return;
    }

    if (!email.contains('@')) {
      setState(() {
        _errorMessage = 'Geçerli bir email adresi girin';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _errorMessage = 'Şifre en az 6 karakter olmalıdır';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Şifreler eşleşmiyor';
      });
      return;
    }

    await ref.read(authProvider.notifier).register(name: name, email: email, password: password);
  }
}
