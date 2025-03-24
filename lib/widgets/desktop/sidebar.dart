import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.menu_book,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  label: 'Profile',
                  isSelected: true,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.grid_view_outlined,
                  label: 'Menu',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.mail_outline,
                  label: 'Messages',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.pie_chart_outline,
                  label: 'Analytics',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.flag_outlined,
                  label: 'Reports',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isSelected = false,
  }) {
    return Tooltip(
      message: label,
      preferBelow: false,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Colors.orange.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.grey[600],
            size: 24,
          ),
          tooltip: label,
        ),
      ),
    );
  }
} 