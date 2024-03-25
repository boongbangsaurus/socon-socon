import 'package:flutter/material.dart';


class Dropdown extends StatefulWidget {
  final String title;
  final List<String> dropdownItems;
  final Function(String?) onItemSelected;

  const Dropdown({Key? key, required this.title, required this.dropdownItems, required this.onItemSelected}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<String>(
          value: _selectedItem,
          hint: Text(widget.title),
          items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
            widget.onItemSelected(newValue);
          },
        ),
      ],
    );
  }
}