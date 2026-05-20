import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';

class FilterControl extends StatelessWidget {
  const FilterControl({super.key});

@override
Widget build(BuildContext context) {

return Card(
child: Padding(
padding:EdgeInsets.all(AppTheme.paddingSmall),
                child:Column                                                      (
children: ProductCategory.values.map((category) {
            return ListTile(
              title:  Text(category.name),
              onTap:                    (){
                                Placeholder();
      },
            );
  }).toList(),
            ),
                                  )
                  );
    
                }
                  }