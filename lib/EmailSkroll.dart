import 'package:flutter/material.dart';
import 'EmailScreen.dart';
import 'EmailMenu.dart';

void main() {
  runApp(const EmailApp());
}

class EmailApp extends StatelessWidget {
  const EmailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EmailScroll(),
    );
  }
}

class EmailScroll extends StatelessWidget {
  const EmailScroll({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF24160F);
    const cardColor = Color(0xFF1B110B);
    const accentColor = Color(0xFFD39A64);
    const textPrimary = Colors.white;
    const textSecondary = Color(0xFFB8A89C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailMenu(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34241A),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Поиск в почте',
                        style: TextStyle(
                          color: Color(0xFFB8A89C),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Неотсортированные',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.touch_app_outlined, color: accentColor, size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Чтобы выбрать цепочку писем,\nнажмите на фото отправителя.',
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 15,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Text(
                          'Скрыть',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _EmailTile(
                    avatar: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    sender: 'GitLab',
                    title: 'gitlab.com sign-in from new location',
                    subtitle: 'Someone signed in to your gitlab.com ac...',
                    time: '10:14',
                    unreadDot: true,
                    clickable: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailScreen(),
                        ),
                      );
                    },
                  ),

                  _NotificationTile(),

                  _EmailTile(
                    avatar: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.apple, color: Colors.black, size: 30),
                    ),
                    sender: 'App Store Connect',
                    title: 'The uploaded build for Diwo App has o...',
                    subtitle: 'Hello, We noticed one or more issues wit...',
                    time: '00:22',
                    unreadDot: true,
                    clickable: false,
                  ),

                  _EmailTile(
                    avatar: ClipOval(
                      child: Container(
                        width: 48,
                        height: 48,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Text(
                          'in',
                          style: TextStyle(
                            color: Color(0xFF0A66C2),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    sender: 'LinkedIn',
                    title: 'Оповещение, связанное с безопасно...',
                    subtitle: 'Оповещение, связанное с безопасност...',
                    time: '9 апр.',
                    unreadDot: true,
                    clickable: false,
                  ),

                  _EmailTile(
                    avatar: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.apple, color: Colors.black, size: 30),
                    ),
                    sender: 'App Store Connect',
                    title: 'The uploaded build for Tel Med Doc ha...',
                    subtitle: 'Hello, We noticed one or more issues wit...',
                    time: '9 апр.',
                    unreadDot: true,
                    clickable: false,
                  ),

                  _EmailTile(
                    avatar: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.apple, color: Colors.black, size: 30),
                    ),
                    sender: 'App Store Connect',
                    title: 'The uploaded build for Pain Statistics...',
                    subtitle: 'Hello, We noticed one or more issues wit...',
                    time: '8 апр.',
                    unreadDot: true,
                    clickable: false,
                  ),

                  _EmailTile(
                    avatar: ClipOval(
                      child: Container(
                        width: 48,
                        height: 48,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Text(
                          'in',
                          style: TextStyle(
                            color: Color(0xFF0A66C2),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    sender: 'LinkedIn',
                    title: 'Dominik Roszkowski и другие участн...',
                    subtitle: '',
                    time: '',
                    unreadDot: false,
                    clickable: false,
                  ),

                  const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.mail_outline,
                          color: accentColor,
                          size: 28,
                        ),
                        Positioned(
                          right: -10,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '99+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.videocam_outlined,
                      color: Color(0xFFC8B7AA),
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF9E683B),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.edit_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Написать',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailTile extends StatelessWidget {
  final Widget avatar;
  final String sender;
  final String title;
  final String subtitle;
  final String time;
  final bool unreadDot;
  final bool clickable;
  final VoidCallback? onTap;

  const _EmailTile({
    required this.avatar,
    required this.sender,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.unreadDot,
    required this.clickable,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF1B110B);
    const textPrimary = Colors.white;
    const textSecondary = Color(0xFFB8A89C);

    final content = Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (unreadDot)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD39A64),
                        shape: BoxShape.circle,
                      ),
                    ),
                  const SizedBox(width: 14),
                  const Icon(
                    Icons.star_border,
                    color: Color(0xFFC8B7AA),
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    if (clickable) {
      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}

class _NotificationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF1B110B);
    const textPrimary = Colors.white;
    const accentColor = Color(0xFFD39A64);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: accentColor, size: 30),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Оповещения',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Оповещения о вакансиях Linked...',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              '75 нов.',
              style: TextStyle(
                color: Color(0xFF2A180F),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}