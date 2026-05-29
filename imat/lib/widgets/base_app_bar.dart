import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/pages/log_in_view.dart';
import 'package:imat_app/pages/main_checkout.dart';
import 'package:imat_app/pages/main_view.dart';
import 'package:imat_app/pages/profile_page_view.dart';
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
    final iMat = context.watch<ImatDataHandler>();

    return AppBar(

      backgroundColor: AppTheme.mainColor,
      // ── Title button ────────────────────────────────────
      title: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius * 0.25),
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context) => const MainView(),
            ),
            (route) => false,
          );
        },
        child: Text(
          'IMAT',
          style: AppTheme.titleFont.copyWith(
            color: AppTheme.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      actions: [
        // ── Sign/Log-in button ────────────────────────────
        Padding(
          padding: const EdgeInsets.only(right: AppTheme.paddingSmall,),
          child: ActionChip(
            avatar: Icon(
              // Inloggad? Ja=person-, nej=login-icon
              iMat.isLoggedIn? Icons.person : Icons.login,
              color: AppTheme.whiteColor,
            ),
            label: Text(
              iMat.isLoggedIn?
                'Hej ${iMat.getCustomerForCurrentUser().firstName} ${iMat.getCustomerForCurrentUser().lastName}'
                : 'Logga in',
              style: AppTheme.textFont.copyWith(color: AppTheme.whiteColor),
            ),
            backgroundColor: AppTheme.darkColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder:
                  (context) => iMat.isLoggedIn? ProfilePage() : LogInView(),
                )
              );
            },

          ),
        ),
        // ── Cart button ───────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(right: AppTheme.paddingSmall),
          child: ActionChip(
            avatar: Icon(
              Icons.shopping_cart, 
              color: AppTheme.whiteColor,
            ),
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
        // ── Search field ─────────────────────────────────
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
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
                suffixIcon: _searchController.text.isNotEmpty ?
                  IconButton(
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
                  ) : null,
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
      ],
    );
  }
}
