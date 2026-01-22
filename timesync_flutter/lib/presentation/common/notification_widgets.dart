import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/notification/notification_provider.dart';

/// Notification Badge Widget (for app icons)
class NotificationBadge extends ConsumerWidget {
  final Widget child;
  final VoidCallback onPressed;

  const NotificationBadge({
    required this.child,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadNotificationCountProvider);

    return Stack(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: child,
        ),
        unreadCountAsync.when(
          data: (count) => count > 0
              ? Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red[500],
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          error: (err, stack) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// Notification Bell Widget (for header)
class NotificationBellIcon extends ConsumerWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const NotificationBellIcon({
    required this.onPressed,
    this.color = Colors.white,
    this.size = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadNotificationCountProvider);

    return NotificationBadge(
      onPressed: onPressed,
      child: Icon(
        Icons.notifications_outlined,
        color: color,
        size: size,
      ),
    );
  }
}

/// Notification List Tile (for quick preview)
class NotificationListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timestamp;
  final bool isUnread;
  final VoidCallback onTap;

  const NotificationListTile({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.isUnread,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: isUnread ? AppColors.primary.withValues(alpha: 0.1) : null,
      leading: CircleAvatar(
        backgroundColor: isUnread ? AppColors.primary : Colors.grey[700],
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 16,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timestamp,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11,
            ),
          ),
          if (isUnread)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.circle,
                size: 6,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
