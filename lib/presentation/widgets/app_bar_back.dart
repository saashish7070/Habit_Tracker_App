import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: ()=> context.pop(),
      ),
      title: Text(
        title, 
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
