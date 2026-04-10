import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  final String iconPath;
  final String symbol;
  final String name;
  final String price;
  final String? change;
  final String? subvalue;
  final bool? isUp;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const CoinTile({
    super.key,
    this.change,
    required this.iconPath,
    this.isUp,
    required this.name,
    required this.price,
    this.subvalue,
    required this.symbol,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: Image.asset(iconPath, width: 50, height: 50),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        symbol,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onFavoriteToggle != null)
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.redAccent : Colors.grey,
              ),
              onPressed: onFavoriteToggle,
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              if (change != null)
                Text(
                  change!,
                  style: TextStyle(
                    color: isUp == true
                        ? const Color(0xFF5CE1AD)
                        : Colors.redAccent,
                    fontSize: 14,
                  ),
                ),
              if (subvalue != null)
                Text(
                  subvalue!,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
