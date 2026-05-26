import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/pages/main_checkout.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BaseAppBar({super.key});

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BaseAppBarState extends State<BaseAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.read<ImatDataHandler>();

    return AppBar(
      backgroundColor: AppTheme.mainColor,
      title: Text(
        'IMAT',
        style: AppTheme.titleFont.copyWith(
          color: AppTheme.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      actions: [
        // ── Search field ─────────────────────────────────
        SizedBox(
          width: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: TextField(
              controller: _searchController,
              style: AppTheme.textFont.copyWith(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Sök produkt...',
                hintStyle: AppTheme.textFont.copyWith(color: Colors.black38),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 20,
                ),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black54,
                            size: 18,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                            iMat.selectAllProducts();
                          },
                        )
                        : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
                if (value.isEmpty) {
                  iMat.selectAllProducts();
                } else {
                  iMat.selectSelection(iMat.findProducts(value));
                }
              },
            ),
          ),
        ),

        // ── Cart button ───────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ActionChip(
            label: Text(
              'Kassa',
              style: AppTheme.textFont.copyWith(color: AppTheme.whiteColor),
            ),
            backgroundColor: AppTheme.darkColor,
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => MainCheckout()),
              );
            },
          ),
        ),
      ],
    );
  }
}
