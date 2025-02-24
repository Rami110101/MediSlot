import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/components/style/color.dart';

class CustomInputField extends StatefulWidget {
  final String title;
  final bool isPassword;
  final bool isSearchField;
  final bool isDateField;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final VoidCallback? onSearch;

  const CustomInputField({
    Key? key,
    required this.title,
    this.isPassword = false,
    this.isSearchField = false,
    this.isDateField = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onSearch,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPassword;
  }

  Future<void> _pickDate() async {
    if (widget.isDateField) {
      try {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColors.primaryColor,
                hintColor: AppColors.primaryColor,
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(color: Colors.black),
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          setState(() {
            widget.controller.text =
                DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      } catch (e) {
        debugPrint("Error in date picker: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        widget.isDateField
            ? InkWell(
          onTap: _pickDate,
          child: AbsorbPointer(
            child: TextField(
              controller: widget.controller,
              readOnly: true,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Select Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                suffixIcon: _buildSuffixIcon(),
              ),
            ),
          ),
        )
            : TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && !_isPasswordVisible,
          keyboardType: widget.keyboardType,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            suffixIcon: _buildSuffixIcon(),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    } else if (widget.isSearchField) {
      return IconButton(
        icon: const Icon(Icons.search, color: Colors.black),
        onPressed: widget.onSearch,
      );
    } else if (widget.isDateField) {
      return const Icon(Icons.arrow_drop_down_outlined, size: 35,color: Colors.grey);
    }
    return null;
  }
}
