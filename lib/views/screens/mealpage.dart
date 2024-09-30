import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pr4_appmania/utils/extensions.dart';
import 'package:pr4_appmania/utils/recipe.dart';

class Mealpage extends StatefulWidget {
  const Mealpage({super.key});

  @override
  State<Mealpage> createState() => _MealpageState();
}

class _MealpageState extends State<Mealpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Page"),
      ),
      body: mealItems.isEmpty
          ? Text("You haven't selected meal")
          : SingleChildScrollView(
              child: Column(
                children: mealItems
                    .map(
                      (e) => Container(
                        padding: EdgeInsets.all(16),
                        margin:
                            EdgeInsets.only(right: 16, bottom: 10, left: 10),
                        height: size.height * 0.34,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(e['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            16.w,
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  8.h,
                                  Text(
                                    e['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  6.h,
                                  RatingBar.builder(
                                    itemSize: 20,
                                    initialRating: e['rating'].toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  6.h,
                                  Text(
                                    e['ingredients'].join(", "),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          e['qty']--;
                                          if (e['qty'] == 0) {
                                            mealItems.remove(e);
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(e['qty'].toString()),
                                      IconButton(
                                        onPressed: () {
                                          e['qty']++;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
