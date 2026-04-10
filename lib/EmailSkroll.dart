import 'package:flutter/material.dart';

void main() {
  runApp(const EmailApp());
}

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text("EmailScreen")));
}

class EmailMenu extends StatelessWidget {
  const EmailMenu({super.key, required this.closeMenu});
  final VoidCallback closeMenu;
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text("EmailMenu")));
}

class EmailApp extends StatelessWidget {
  const EmailApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: EmailScroll());
}

class EmailScroll extends StatefulWidget {
  const EmailScroll({super.key});

  @override
  State<EmailScroll> createState() => _EmailScrollState();
}

class _EmailScrollState extends State<EmailScroll> with SingleTickerProviderStateMixin {
  // Состояние для меню (открыто/закрыто)
  bool isMenuOpen = false;

  // Анимация для меню
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Плавность анимации
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Слева за экраном
      end: const Offset(0.0, 0.0),    // На месте
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
    if (isMenuOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1917), // Темный фон как на скриншоте
      body: Stack(
        children: [
          // 1. ОСНОВНОЙ ЭКРАН (EmailScroll Content)
          Column(
            children: [
              // Верхняя панель (Поиск, Бургер, Аватар)
              _buildTopBar(),
              
              // Основной список (Скролл)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80.0), // Отступ под FAB
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Заголовок секции
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                          child: Text(
                            "Несортированные",
                            style: TextStyle(color: Colors.grey[400], fontSize: 16),
                          ),
                        ),

                        // Баннер-подсказка
                        _buildInfoBanner(),

                        // Список писем
                        _buildEmailList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. МЕНЮ (EmailMenu) - Поверх экрана
          // Меню выезжает слева, но не перекрывает весь экран (ширина ~70%)
          if (isMenuOpen) ...[
            // Затемнение фона (клик вне меню закрывает его)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(color: Colors.black54),
            ),
            // Само меню
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75, // 75% ширины
                height: double.infinity,
                child: EmailMenu(closeMenu: toggleMenu), // Ваш экран меню
              ),
            ),
          ]
        ],
      ),
      // Кнопка "Написать" (FAB)
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4E342E), // Коричневатый оттенок
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {}, // Действие
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit, color: Colors.white),
            const SizedBox(width: 8),
            Text("Написать", style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
      // Нижняя навигация
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- ВЕРХНЯЯ ПАНЕЛЬ ---
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 10), // Отступ сверху для статус бара
      child: Row(
        children: [
          // Бургер меню
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: toggleMenu,
          ),
          const SizedBox(width: 12),
          // Поиск
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF292524),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(Icons.search, color: Colors.grey[400]),
                  const SizedBox(width: 12),
                  Text(
                    "Поиск в почте",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Аватар
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[700],
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"), // Заглушка аватара
          ),
        ],
      ),
    );
  }

  // --- БАННЕР ПОДСКАЗКИ ---
  Widget _buildInfoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF292524),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, color: Colors.orange[200], size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Чтобы выбрать цепочку писем, нажмите на фото отправителя.",
                style: TextStyle(color: Colors.grey[300], fontSize: 14, height: 1.3),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Скрыть", style: TextStyle(color: Colors.orangeAccent)),
            ),
          ],
        ),
      ),
    );
  }

  // --- СПИСОК ПИСЕМ ---
  Widget _buildEmailList() {
    // Данные для списка (имитация)
    final emails = [
      {
        'icon': Icons.person,
        'name': 'GitLab',
        'subject': 'gitlab.com sign-in from new location',
        'preview': 'Someone signed in to your gitlab.com ac...',
        'time': '10:14',
        'unread': true,
        'starred': false,
        'isFirst': true, // Флаг первого письма
      },
      {
        'icon': Icons.info_outline,
        'name': 'Оповещения',
        'subject': 'Оповещения о вакансиях Linked...',
        'badge': '75 нов.',
        'preview': '',
        'time': '',
        'unread': false,
        'starred': false,
        'isFirst': false,
      },
      {
        'icon': Icons.apple,
        'name': 'App Store Connect',
        'subject': 'The uploaded build for Diwo App has o...',
        'preview': 'Hello, We noticed one or more issues wit...',
        'time': '00:22',
        'unread': true,
        'starred': false,
        'isFirst': false,
      },
      {
        'icon': Icons.work, // LinkedIn logo replacement
        'name': 'LinkedIn',
        'subject': 'Оповещение, связанное с безопасно...',
        'preview': 'Оповещение, связанное с безопасност...',
        'time': '9 апр.',
        'unread': true,
        'starred': false,
        'isFirst': false,
      },
       {
        'icon': Icons.apple,
        'name': 'App Store Connect',
        'subject': 'The uploaded build for Tel Med Doc ha...',
        'preview': 'Hello, We noticed one or more issues wit...',
        'time': '9 апр.',
        'unread': true,
        'starred': false,
        'isFirst': false,
      },
    ];

    return Column(
      children: emails.map((email) => _buildEmailCard(email)).toList(),
    );
  }

  // --- КАРТОЧКА ПИСЬМА ---
  Widget _buildEmailCard(Map<String, dynamic> email) {
    bool isFirst = email['isFirst'] ?? false;
    
    return GestureDetector(
      // КЛИКАБЕЛЬНОСТЬ: Только первое письмо
      onTap: isFirst ? () {
        // Навигация на EmailScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmailScreen()),
        );
      } : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1917), // Цвет карточки (на скрине чуть темнее фона списка или такой же)
          // Если на скрине карточки выделяются рамкой или цветом фона, можно добавить здесь border или другой color.
          // Сейчас они выглядят просто как разделенные элементы на темном фоне.
          // Для эффекта "карточки" добавим легкий border:
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Иконка отправителя
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[800],
              child: Icon(email['icon'], color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            
            // Контент (Тексты)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          email['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (email['time'].toString().isNotEmpty)
                        Text(
                          email['time'],
                          style: TextStyle(color: Colors.grey[400], fontSize: 12),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          email['subject'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (email['badge'] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            email['badge'],
                            style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (email['preview'].toString().isNotEmpty)
                    Text(
                      email['preview'],
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Звездочка (если есть)
            Column(
              children: [
                Icon(
                  email['starred'] ? Icons.star : Icons.star_border_outlined,
                  color: email['starred'] ? Colors.orange : Colors.grey[500],
                ),
                const SizedBox(height: 4),
                // Точка непрочитанного
                if (email['unread'] == true)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- НИЖНЯЯ НАВИГАЦИЯ ---
  Widget _buildBottomNav() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFF1C1917),
        border: Border(top: BorderSide(color: Color(0xFF292524))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Кнопка Входящие (с бейджем 99+)
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.mail, color: Colors.white, size: 28),
                onPressed: () {},
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "99+",
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          
          // Кнопка Видеозвонок/Камера
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.grey, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}