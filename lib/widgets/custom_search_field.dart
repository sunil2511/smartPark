import 'package:flutter/material.dart';
import 'package:flutter_crud/widgets/svg_picture_widget.dart';

import '../utils/const/image_path_provider.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Color(0xFF808284),
        fontSize: 14,
        fontFamily: 'Graphik',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14),
          filled: true,
          fillColor: Colors.black.withOpacity(0.30000001192092896),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFF2B2E32)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFF2B2E32)),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Search orders or brands',
          hintStyle: const TextStyle(
            color: Color(0xFF808284),
            fontSize: 14,
            fontFamily: 'Graphik',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const SvgPictureWidget(
              url: ImagePathProvider.iconSearch,
            ),
          )),
    );
  }
}
