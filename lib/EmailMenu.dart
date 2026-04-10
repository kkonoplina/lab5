import 'package:flutter/material.dart';
import 'EmailSkroll.dart';
import 'EmailScreen.dart';

class EmailMenu extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const EmailMenu({super.key, required this.isOpen, required this.onClose});

  @override
  State<EmailMenu> createState() => _EmailMenuState();
}

class _EmailMenuState extends State<EmailMenu> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'Несортированные';
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isOpen) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(EmailMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen && !oldWidget.isOpen) {
      _animationController.forward();
    } else if (!widget.isOpen && oldWidget.isOpen) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF2C241F),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {},
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildMainCategories(),
                      _buildDivider(),
                      Expanded(
                        child: _buildAllLabels(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onClose,
            icon: Icon(Icons.close, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text(
            'Gmail',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCategories() {
    return Column(
      children: [
        _buildCategoryItem(
          icon: Icons.inbox,
          title: 'Несортированные',
          badge: '99+',
          badgeColor: Color(0xFF5D4E3D),
          isSelected: _selectedCategory == 'Несортированные',
          onTap: () {
            setState(() {
              _selectedCategory = 'Несортированные';
            });
            widget.onClose();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmailScroll()),
            );
          },
        ),
        _buildCategoryItem(
          icon: Icons.local_offer_outlined,
          title: 'Промоакции',
          badge: '44 нов.',
          badgeColor: Color(0xFF6B9B6C),
          isSelected: _selectedCategory == 'Промоакции',
          onTap: () {
            setState(() {
              _selectedCategory = 'Промоакции';
            });
          },
        ),
        _buildCategoryItem(
          icon: Icons.people_outline,
          title: 'Соцсети',
          badge: '5 нов.',
          badgeColor: Color(0xFF7EB5F5),
          isSelected: _selectedCategory == 'Соцсети',
          onTap: () {
            setState(() {
              _selectedCategory = 'Соцсети';
            });
          },
        ),
        _buildCategoryItem(
          icon: Icons.info_outline,
          title: 'Оповещения',
          badge: '75 нов.',
          badgeColor: Color(0xFFE8A87C),
          isSelected: _selectedCategory == 'Оповещения',
          onTap: () {
            setState(() {
              _selectedCategory = 'Оповещения';
            });
          },
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: Text(
        'Все ярлыки',
        style: TextStyle(
          fontSize: 13,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildAllLabels() {
    return ListView(
      children: [
        _buildLabelItem(
          icon: Icons.star_outline,
          title: 'Помеченные',
          onTap: () {
            setState(() {
              _selectedCategory = 'Помеченные';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.access_time,
          title: 'Отложенные',
          onTap: () {
            setState(() {
              _selectedCategory = 'Отложенные';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.label_important_outline,
          title: 'Важные',
          count: '84',
          onTap: () {
            setState(() {
              _selectedCategory = 'Важные';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.shopping_bag_outlined,
          title: 'Покупки',
          count: '58',
          onTap: () {
            setState(() {
              _selectedCategory = 'Покупки';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.send_outlined,
          title: 'Отправленные',
          onTap: () {
            setState(() {
              _selectedCategory = 'Отправленные';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.schedule_outlined,
          title: 'Запланированные',
          onTap: () {
            setState(() {
              _selectedCategory = 'Запланированные';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.outbox_outlined,
          title: 'Исходящие',
          onTap: () {
            setState(() {
              _selectedCategory = 'Исходящие';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.drafts_outlined,
          title: 'Черновики',
          count: '5',
          onTap: () {
            setState(() {
              _selectedCategory = 'Черновики';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.mail_outline,
          title: 'Вся почта',
          count: '99+',
          onTap: () {
            setState(() {
              _selectedCategory = 'Вся почта';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.report_outlined,
          title: 'Спам',
          count: '718',
          onTap: () {
            setState(() {
              _selectedCategory = 'Спам';
            });
          },
        ),
        _buildLabelItem(
          icon: Icons.delete_outline,
          title: 'Корзина',
          onTap: () {
            setState(() {
              _selectedCategory = 'Корзина';
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String title,
    String? badge,
    String? count,
    Color? badgeColor,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF3D342D) : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            if (count != null)
              Text(
                count,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelItem({
    required IconData icon,
    required String title,
    String? count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            if (count != null)
              Text(
                count,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }
}