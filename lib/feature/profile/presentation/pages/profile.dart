import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(LoadProfile());
    });
    return Scaffold(
      backgroundColor: AppColor.background,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            final user = state.profile;

            return Column(
              children: [
                _buildHeader(user.username),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        _buildPersonalInfoCard(
                          username: user.username,
                          email: user.email,
                          createdAt: user.createdAt,
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsCard(),
                        const SizedBox(height: 24),
                        _buildLogoutButton(context),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildHeader(String username) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColor.gradientVertical(AppColor.primary, AppColor.primaryMedium),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                username,
                style: tsTitleMediumBold(AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard({
    required String username,
    required String email,
    required String createdAt,
}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pribadi',
            style: tsBodyLargeBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            icon: Icons.person_outline,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: AppColor.blue,
            label: 'Username',
            value: username,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.email_outlined,
            iconBgColor: AppColor.primaryLight,
            iconColor: AppColor.primaryDark,
            label: 'Email',
            value: email,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            iconBgColor: const Color(0xFFFFF4E6),
            iconColor: AppColor.orange,
            label: 'Tanggal Dibuat',
            value: createdAt,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: tsBodySmallRegular(AppColor.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: tsBodyMediumMedium(AppColor.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengaturan',
            style: tsBodyLargeBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 20),
          _buildSettingItem(
            icon: Icons.person_outline,
            iconBgColor: AppColor.primaryLight,
            iconColor: AppColor.primaryDark,
            title: 'Edit Profil',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.settings_outlined,
            iconBgColor: AppColor.silver,
            iconColor: AppColor.grayDark,
            title: 'Pengaturan Akun',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            iconBgColor: AppColor.silver,
            iconColor: AppColor.grayDark,
            title: 'Notifikasi',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.language,
            iconBgColor: AppColor.silver,
            iconColor: AppColor.grayDark,
            title: 'Bahasa',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Indonesia',
                  style: tsBodyMediumRegular(AppColor.gray),
                ),
                const SizedBox(width: 4),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: tsBodyMediumMedium(AppColor.textPrimary),
              ),
            ),
            if (trailing != null) trailing,
            Icon(
              Icons.chevron_right,
              color: AppColor.gray,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.errorTransparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.error.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _showLogoutDialog(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: AppColor.error, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Keluar',
                    style: tsBodyLargeSemiBold(AppColor.error),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Keluar',
          style: tsTitleMediumBold(AppColor.textPrimary),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar?',
          style: tsBodyMediumRegular(AppColor.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: tsBodyMediumSemiBold(AppColor.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Handle logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.error,
              foregroundColor: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'Keluar',
              style: tsBodyMediumSemiBold(AppColor.white),
            ),
          ),
        ],
      ),
    );
  }
}