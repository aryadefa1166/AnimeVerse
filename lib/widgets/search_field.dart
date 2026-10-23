import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool showClear;
  final String hintText;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.showClear = false,
    this.hintText = 'Anime Title',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.075),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: screenWidth * 0.02,
              offset: Offset(0, screenHeight * 0.005),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: screenWidth * 0.04,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: screenWidth * 0.06,
            ),
            // Tombol X muncul kalau ada teks
            suffixIcon: showClear
                ? IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
                size: screenWidth * 0.06,
              ),
              onPressed: onClear,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.075),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.075),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.075),
              borderSide: const BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: const Color(0xFF0b395e),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.015,
            ),
          ),
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}