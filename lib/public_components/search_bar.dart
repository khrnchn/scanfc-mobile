import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function onTap;
  final bool readOnly;

  const SearchBar({
    Key? key,
    required this.onTap,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: kGrey.shade100,
          child: TextField(
            onTap: () {
              onTap();
            },
            clipBehavior: Clip.none,
            decoration: InputDecoration(
              suffixIcon: const IconTheme(
                data: IconThemeData(color: kTextGray),
                child: Icon(
                  Icons.search,
                ),
              ),
              hintText: "Search",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
                gapPadding: 0,
              ),
              contentPadding: const EdgeInsets.all(16.0),
            ),
            style: const TextStyle(fontSize: 14),
            readOnly: readOnly,
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
