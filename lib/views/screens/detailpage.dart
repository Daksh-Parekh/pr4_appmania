import 'package:flutter/material.dart';
import 'package:pr4_appmania/utils/extensions.dart';
import 'package:pr4_appmania/utils/recipe.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Map<String, dynamic> meals =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var time = meals['cookTimeMinutes'] + meals['prepTimeMinutes'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailpage"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'favourite_page');
            },
            icon: Icon(Icons.favorite_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'meal_page');
            },
            icon: Icon(Icons.restaurant_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meals['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              15.h,
              Container(
                height: size.height * 0.4,
                width: double.infinity,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(meals['image']),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (!mealItems.contains(meals)) {
                          mealItems.add(meals);
                          meals['qty'] = 1;
                        }
                      },
                      color: Colors.white,
                      child: Text(
                        "Add To Meals",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              15.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Rating"),
                      Row(
                        children: [
                          Icon(Icons.star),
                          Text(meals['rating'].toString()),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Calories"),
                      Row(
                        children: [
                          Text("${meals['caloriesPerServing']} Cal"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Time"),
                      Row(
                        children: [
                          Icon(Icons.timer),
                          Text("$time"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              15.h,
              Column(
                children: List.generate(
                  meals['ingredients'].length,
                  (index) => Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.shade300,
                          offset: Offset(2, 2),
                        ),
                      ],
                      color: Colors.blue.withOpacity(0.7),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      meals['ingredients'][index],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // Text(meals['ingredients'].join('\n'))
            ],
          ),
        ),
      ),
    );
  }
}
