import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';

class FilterControl extends StatefulWidget {
  const FilterControl({super.key});

  @override
  State<FilterControl> createState() => _FilterControlState();
}

class _FilterControlState extends State<FilterControl>{
  bool showAll = false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingSmall),
      child: Column(
        children: [
          Text("Kategorier", style: AppTheme.titleFont),
        
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 8.0;

              final itemWidth = (constraints.maxWidth - (spacing * 2)) / 3;

              final categories = showAll ? ProductCategory.values:
                                ProductCategory.values.take(6).toList();

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: categories.map((category) {
                  return SizedBox(
                    width: itemWidth,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.darkColor,
                        foregroundColor: AppTheme.whiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {

                      },
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: AppTheme.textFont.copyWith(
                          color: AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),  
              );
            },
          ),
          /*GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showAll ? ProductCategory.values.length: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final category = ProductCategory.values[index];

              return SizedBox.expand(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.darkColor,
                    foregroundColor: AppTheme.whiteColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onPressed: () {
                    // press
                  },
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: AppTheme.textFont.copyWith(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              );
            },
          ),*/
          /*Wrap(
            spacing: AppTheme.paddingSmall,
            runSpacing: AppTheme.paddingSmall,
            alignment: WrapAlignment.center,
            children: (
              showAll ? ProductCategory.values: 
                ProductCategory.values.take(6)).map((category){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.darkColor,
                        foregroundColor: AppTheme.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        )
                      ),
                      onPressed: () {

                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          category.name,
                          style: AppTheme.textFont.copyWith(
                            color: AppTheme.whiteColor
                          ),
                        ),
                      ),
                    ),


                  );
                }).toList(),
          ),*/
          SizedBox(height: AppTheme.paddingMediumSmall,),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.darkColor,
                foregroundColor: AppTheme.whiteColor,
                padding: EdgeInsets.all(AppTheme.paddingSmall),
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