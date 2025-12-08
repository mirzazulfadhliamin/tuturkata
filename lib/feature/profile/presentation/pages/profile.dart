import 'package:flutter/material.dart';

import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              color: AppColor.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildPersonalInfo(),
                    const SizedBox(height: 32),
                    _buildSettingsSection(),
                    const SizedBox(height: 24),
                    _buildLogoutButton(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColor.gradientVertical(AppColor.primary, AppColor.primaryDark),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
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
                  size: 40,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Aisyah Aisyara Putri',
                style: tsTitleLargeBold(AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pribadi',
            style: tsTitleMediumBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            icon: Icons.person_outline,
            iconColor: AppColor.blue,
            iconBgColor: AppColor.infoTransparent,
            label: 'Username',
            value: 'aisyah_putri',
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            icon: Icons.email_outlined,
            iconColor: AppColor.primary,
            iconBgColor: AppColor.primaryTransparent,
            label: 'Email',
            value: 'aisyah.putri@email.com',
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            icon: Icons.calendar_today_outlined,
            iconColor: AppColor.orange,
            iconBgColor: AppColor.warningTransparent,
            label: 'Tanggal Dibuat',
            value: '15 Januari 2024',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(12),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tsBodySmallRegular(AppColor.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: tsBodyMediumMedium(AppColor.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengaturan',
            style: tsTitleMediumBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.person_outline,
            iconColor: AppColor.primary,
            iconBgColor: AppColor.primaryTransparent,
            title: 'Edit Profil',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            icon: Icons.settings_outlined,
            iconColor: AppColor.gray,
            iconBgColor: AppColor.silver,
            title: 'Pengaturan Akun',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            iconColor: AppColor.gray,
            iconBgColor: AppColor.silver,
            title: 'Notifikasi',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            icon: Icons.language_outlined,
            iconColor: AppColor.gray,
            iconBgColor: AppColor.silver,
            title: 'Bahasa',
            trailing: Text(
              'Indonesia',
              style: tsBodyMediumRegular(AppColor.textSecondary),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: tsBodyMediumMedium(AppColor.textPrimary),
              ),
            ),
            if (trailing != null) trailing,
            const SizedBox(width: 8),
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
      child: OutlinedButton(
        onPressed: () {
          _showLogoutDialog(context);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: AppColor.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
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