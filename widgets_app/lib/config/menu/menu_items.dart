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
  MenuItems(
    title: 'Progress Indicators',
    subtitle: 'Generales y controlados',
    link: '/progress',
    iconData: Icons.refresh_rounded,
  ),
  MenuItems(
    title: 'Snackbars y diálogos',
    subtitle: 'Indicadores en pantalla',
    link: '/snackbars',
    iconData: Icons.info_outline,
  ),
  MenuItems(
    title: 'Animated container',
    subtitle: 'Stateful widget animado',
    link: '/animated',
    iconData: Icons.check_box_outlined,
  ),
  MenuItems(
    title: 'UI Controls + Tiles',
    subtitle: 'Una serie de controles en Flutter y Tiles',
    link: '/ui-controls',
    iconData: Icons.car_rental_outlined,
  ),
  MenuItems(
    title: 'Introducción a la aplicación',
    subtitle: 'Pequeña introducción a la aplicación',
    link: '/tutorial',
    iconData: Icons.accessibility_rounded,
  ),
];
