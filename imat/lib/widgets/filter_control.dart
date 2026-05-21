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
        

          Wrap(
            spacing: AppTheme.paddingSmall,
            runSpacing: AppTheme.paddingSmall,
            alignment: WrapAlignment.center,
            children: (
              showAll ? ProductCategory.values: 
              ProductCategory.values.take(5)).map((category){
                return ActionChip(
                  label: Text(
                    category.name, 
                    style: TextStyle(color: AppTheme.whiteColor), 
                  ),
                  labelStyle: AppTheme.textFont,
                  backgroundColor: AppTheme.darkColor,
                  onPressed: () {

                  },
                );
              }).toList(),
          ),
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