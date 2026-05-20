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

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.paddingSmall),
        child: Column(
          children: [
            Text("Kategorier", style: AppTheme.titleFont),
          

            Wrap(
              spacing: AppTheme.paddingSmall,
              runSpacing: AppTheme.paddingSmall,

              children: (
                showAll ? ProductCategory.values: 
                ProductCategory.values.take(5)).map((category){
                return ActionChip(
                  label: Text(category.name),
                  backgroundColor: AppTheme.darkColor,
                  onPressed: () {

                  },
                );
              }).toList(),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Text(
                  showAll ? "USH FY BORT!" : "JAG VILL HA MEERRR!",
                ),
              ),
            ),
          ],
        ),
      )
    );
    
  }
}