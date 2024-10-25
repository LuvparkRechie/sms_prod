// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'custom_widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final List<Widget>? actions;
  final Widget? child;
  final Widget? leading;
  final Color? leadingColor;
  const CustomAppBar(
      {super.key,
      this.preferredSize = const Size.fromHeight(kToolbarHeight),
      this.title,
      this.child,
      this.leading,
      this.leadingColor,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: leading,
        leadingWidth: 50,
        title: CustomTitle(title: title ?? ""),
        actions: actions ?? [],
      ),
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
