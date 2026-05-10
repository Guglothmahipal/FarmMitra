import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/features/farmer/presentation/widgets/farmer_section_header.dart';
import 'package:flutter/material.dart';

class AgricultureCategoriesSection extends StatelessWidget {
  const AgricultureCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FarmerSectionHeader(
          title: 'Agriculture Categories',
          icon: Icons.category_outlined,
        ),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: farmerCategories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = farmerCategories[index];
              return SizedBox(
                width: 108,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon),
                        const SizedBox(height: 8),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
