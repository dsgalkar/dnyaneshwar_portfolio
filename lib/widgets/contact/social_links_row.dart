import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../data/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/tilt_card.dart';

class _SocialLinkItem {
  final String title;
  final String handle;
  final String url;
  final IconData icon;
  final Color color;

  _SocialLinkItem({
    required this.title,
    required this.handle,
    required this.url,
    required this.icon,
    required this.color,
  });
}

/// Interactive Social & Contact Cards (Email, LinkedIn, GitHub, Twitter)
class SocialLinksRow extends StatelessWidget {
  const SocialLinksRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_SocialLinkItem> items = [
      _SocialLinkItem(
        title: 'Direct Email',
        handle: PortfolioData.email,
        url: 'mailto:${PortfolioData.email}',
        icon: Icons.alternate_email_rounded,
        color: AppColors.primaryIndigo,
      ),
      _SocialLinkItem(
        title: 'LinkedIn',
        handle: 'in/dnyaneshwargalkar',
        url: PortfolioData.linkedinUrl,
        icon: Icons.link_rounded,
        color: AppColors.secondarySky,
      ),
      _SocialLinkItem(
        title: 'GitHub',
        handle: 'github.com/dnyaneshwargalkar',
        url: PortfolioData.githubUrl,
        icon: Icons.code_rounded,
        color: AppColors.mintGreen,
      ),
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TiltCard(
            glowColor: item.color,
            onTap: () {
              if (item.url.startsWith('mailto:')) {
                UrlHelper.sendEmail(PortfolioData.email);
              } else {
                UrlHelper.launchURL(item.url);
              }
            },
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: item.color.withValues(alpha: 0.2)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(item.icon, color: item.color, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                        Text(item.handle, style: AppTypography.codeFont(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
