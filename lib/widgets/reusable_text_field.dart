import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool isPassword;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.isPassword = false,
  });

  @override
  ReusableTextFieldState createState() => ReusableTextFieldState();
}

class ReusableTextFieldState extends State<ReusableTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.manrope(fontSize: 16),
      cursorColor: const Color(0xff404040),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        labelStyle: GoogleFonts.manrope(
          color: const Color(0xff404040),
        ),
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: const Color(0xff757575),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff757575),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
