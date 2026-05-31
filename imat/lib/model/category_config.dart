import 'package:imat_app/model/imat/product.dart';

class CategoryGroup {
  final String id;
  final String displayName;
  final List<ProductCategory> categories;

  const CategoryGroup({
    required this.id,
    required this.displayName,
    required this.categories,
  });
}

class CategoryConfig {
  static const List<CategoryGroup> groups = [

    CategoryGroup(
      id: 'vegetables',
      displayName: 'Grönsaker',
      categories: [
        ProductCategory.ROOT_VEGETABLE,
        ProductCategory.CABBAGE,
        ProductCategory.HERB,
        ProductCategory.VEGETABLE_FRUIT,
      ],
    ),

    CategoryGroup(
      id: 'meat_fish',
      displayName: 'Kött och Fisk',
      categories: [
        ProductCategory.MEAT,
        ProductCategory.FISH,
      ],
    ),

    CategoryGroup(
      id: 'dairy',
      displayName: 'Mejeri',
      categories: [
        ProductCategory.DAIRIES,
      ],
    ),

    CategoryGroup(
      id: 'carbs',
      displayName: 'Basvaror',
      categories: [
        ProductCategory.BREAD,
        ProductCategory.PASTA,
        ProductCategory.POTATO_RICE,
        ProductCategory.FLOUR_SUGAR_SALT,
      ],
    ),

    CategoryGroup(
      id: 'fruit',
      displayName: 'Frukt och bär',
      categories: [
        ProductCategory.FRUIT,
        ProductCategory.CITRUS_FRUIT,
        ProductCategory.EXOTIC_FRUIT,
        ProductCategory.BERRY,
        ProductCategory.MELONS,
      ],
    ),

    CategoryGroup(
      id: 'nuts',
      displayName: 'Nötter',
      categories: [
        ProductCategory.NUTS_AND_SEEDS,
      ],
    ),

    CategoryGroup(
      id: 'drinks',
      displayName: 'Drycker',
      categories: [
        ProductCategory.COLD_DRINKS,
        ProductCategory.HOT_DRINKS,
      ],
    ),

    CategoryGroup(
      id: 'snacks',
      displayName: 'Sötsaker',
      categories: [
        ProductCategory.SWEET,
      ],
    ),

    CategoryGroup(
      id: 'pod', 
      displayName: 'Baljväxter', 
      categories: [
        ProductCategory.POD,
      ]
    ),
  ];
}