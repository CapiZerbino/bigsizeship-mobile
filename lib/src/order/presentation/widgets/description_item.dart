import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    required IconData icon,
    required String label,
    required String value,
    bool showIcon = true,
    super.key,
  })  : _label = label,
        _icon = icon,
        _showIcon = showIcon,
        _value = value;

  final IconData _icon;
  final String _label;
  final String _value;
  final bool _showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (_showIcon)
            Icon(
              _icon,
              color: Colours.primaryColour,
            ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    _label,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    _value,
                    textAlign: TextAlign.right,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
