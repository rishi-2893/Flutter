import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trait.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function() onSelectMeal;

  // Getter to get complexity starting with Upper case
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // Getter to get affordability starting with Upper case
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // removes content of child widget which goes outside the shape
      // boundaries of card widget
      clipBehavior: Clip.hardEdge,
      elevation: 2, // give shadow
      child: InkWell(
        onTap: onSelectMeal,
        // Widget stack
        // First child of Stack is the bottom most widget in the stack
        child: Stack(
          children: [
            // Creates a widget that displays a [placeholder] 
            //while an [image] is loading
            FadeInImage(
              // place holder
              placeholder: MemoryImage(kTransparentImage),
              // Get image from the internet using URL
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover, // ensures image is cut if not fitting in card
              height: 200, //
              width: double.infinity,
            ),
            // Used to position Text on top of image in the stack
            Positioned(
              // This container
              bottom: 0, // end to the bottom
              left: 0, // start from the left
              right: 0, // end to the right
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2, // cut off if title more than 2 lines
                      textAlign: TextAlign.center,
                      softWrap: true, // makes sure text is wrapped correctly
                      
                      // If text is cut off due then it ends with "..."
                      overflow: TextOverflow.ellipsis,
                      
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // We are putting a Row() inside another Row()
                    //why so isn't Expanded() needed?
                    //Because Positioned() has set the constraints
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
