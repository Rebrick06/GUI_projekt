import 'package:imat_app/model/category_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class FilterControl extends StatefulWidget {
  const FilterControl({super.key});

  @override
  State<FilterControl> createState() => _FilterControlState();
}

class _FilterControlState extends State<FilterControl>{
  bool showAll = false;
  String selectedCategory = 'Alla';

  @override
  Widget build(BuildContext context) {
      final iMat = context.read<ImatDataHandler>();

    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingSmall),
      child: Column(
        children: [
          Text(
            "Kategorier", 
            style: AppTheme.titleFont.copyWith(
              fontSize: 24
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 8.0;

              final itemWidth = (constraints.maxWidth - (spacing * 2)) / 3;

              final categories = showAll ? 
                  CategoryConfig.groups
                  : CategoryConfig.groups.take(4).toList();


              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedCategory == 'Alla'
                          ? AppTheme.mainColor
                          : AppTheme.darkColor,
                        foregroundColor: AppTheme.whiteColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius / 1.5,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'Alla';
                        });
                        iMat.selectAllProducts();
                      },
                      child: Text(
                        'Alla',
                        textAlign: TextAlign.center,
                        style: AppTheme.textFont.copyWith(
                          color: AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedCategory == 'Favoriter'
                            ? AppTheme.mainColor
                            : AppTheme.darkColor,
                        foregroundColor: AppTheme.whiteColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius / 1.5,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'Favoriter';
                        });

                        iMat.selectFavorites();
                      },
                      child: Text(
                        "Favoriter",
                        style: AppTheme.textFont.copyWith(
                          color: selectedCategory == 'Favoriter'
                              ? Colors.black
                              : AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  ...categories.map((group) {
                    final isSelected = selectedCategory == group.displayName;

                    return SizedBox(
                      width: itemWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: isSelected
                              ? AppTheme.mainColor
                              : AppTheme.darkColor,
                          foregroundColor: AppTheme.whiteColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radius / 1.5,
                            ),
                          ),
                        ),

                        onPressed: () {
                          setState(() {
                            selectedCategory = group.displayName;
                          });
                          final filter = iMat.findProductsByGroup(group);
                          iMat.selectSelection(filter);
                        },

                        child: Text(
                          group.displayName,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: AppTheme.textFont.copyWith(
                            color: isSelected
                                ? Colors.black
                                : AppTheme.whiteColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),  
                ]
              );
            },
          ),
          SizedBox(height: AppTheme.paddingMediumSmall,),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.darkColor,
                foregroundColor: AppTheme.whiteColor,
                padding: EdgeInsets.all(AppTheme.paddingSmall),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(AppTheme.radius / 1.5),
                ),
              ),
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
              },
              child: Text(
                showAll ? "Visa färre" : "Visa fler",
                style: AppTheme.textFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}