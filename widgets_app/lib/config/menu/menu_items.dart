import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final String subtitle;
  final String link;
  final IconData iconData;

  const MenuItems({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.iconData,
  });
}

const appMenuItems = <MenuItems>[
  MenuItems(
    title: 'Botones',
    subtitle: 'Varios botones',
    link: '/buttons',
    iconData: Icons.smart_button_outlined,
  ),
  MenuItems(
    title: 'Tarjetas',
    subtitle: 'Un contenedor estilizado',
    link: '/cards',
    iconData: Icons.credit_card,
  ),
];
