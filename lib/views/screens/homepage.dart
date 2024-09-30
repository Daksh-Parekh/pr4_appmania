import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pr4_appmania/utils/recipe.dart';
import 'package:pr4_appmania/utils/extensions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selected = "All";
  String tagsSelected = "All";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'meal_page');
            },
            icon: Icon(Icons.restaurant_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'favourite_page');
            },
            icon: Icon(Icons.favorite_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    value: selected,
                    // focusColor: Colors.amber,
                    dropdownColor: Colors.white,
                    padding: EdgeInsets.all(5),
                    iconSize: 40,
                    borderRadius: BorderRadius.circular(10),

                    items: [
                      DropdownMenuItem(
                        value: "All",
                        child: Text("All"),
                      ),
                      ...uniquemeal.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      selected = val.toString();
                      setState(() {});
                    },
                  ),

                  //tags
                  Visibility(
                    visible: selected != "All",
                    child: DropdownButton(
                      value: tagsSelected,
                      items: [
                        DropdownMenuItem(
                          value: "All",
                          child: Text("All"),
                        ),
                        ...tags
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                      ],
                      onChanged: (val) {
                        tagsSelected = val.toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: allRecipies
                    .where(
                      (e) => selected == "All" && tagsSelected == "All"
                          ? true
                          : (e['mealType'] as List<String>)
                                  .contains(selected) &&
                              (e['tags'] as List<String>)
                                  .contains(tagsSelected),
                    )
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            'detail_page',
                            arguments: e,
                          );
                        },
                        child: Container(
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
                                child: Stack(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(e['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (!favItems.contains(e)) {
                                          favItems.add(e);
                                        }
                                      },
                                      alignment: Alignment.topLeft,
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!mealItems.contains(e)) {
                                            mealItems.add(e);
                                            e['qty'] = 1;
                                          }
                                        },
                                        child: Text("Add to Meal"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
