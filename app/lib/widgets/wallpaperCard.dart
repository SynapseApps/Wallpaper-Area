import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'selectionArea.dart';

class WallpaperCard extends StatefulWidget {
  @override
  _WallpaperCardState createState() => _WallpaperCardState();
}

class _WallpaperCardState extends State<WallpaperCard>
    with SingleTickerProviderStateMixin {
  final String url = "https://vivrti.pythonanywhere.com/api/";
  final String urlCategory = "https://vivrti.pythonanywhere.com/category/";
  List data;
  List Category;

  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    setState(() {
      this.getJsonData();
    });
  }

  Future<String> getJsonData() async {
    // final response = await http.get('https://jsonplaceholder.typicode.com/posts/');
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    final categoryResponse =
        await http.get(urlCategory, headers: {"Accept": "application/json"});

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      var categoryJSON = jsonDecode(categoryResponse.body);
      Category = categoryJSON["results"];
      data = convertDataToJson['results'];
      data = data.reversed.toList();
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: data == null,
      future: getJsonData(),
      builder: (BuildContext ctx, AsyncSnapshot snap) => data == null
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SelectionArea(
                                    categorySelected: Category[index]
                                        ["category_name"],
                                    url: Category[index]["cover_page"],
                                    collection: data,
                                    id: Category[index]["id"],
                                  )));
                    },
                    child: SizedBox(
                      height: 100,
                      child: Hero(
                        tag: Category[index]["category_name"].toString(),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 4.0,
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              fit: StackFit.expand,
                              children: [
                                new Image.network(
                                  Category[index]["cover_page"].toString(),
                                  fit: BoxFit.cover,
                                  color: Colors.black45,
                                  colorBlendMode: BlendMode.darken,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Text(
                                        Category[index]["category_name"],
                                        style: TextStyle(
                                          fontFamily: "FredokaOne",
                                          color: Colors.white,
                                          fontSize: 30.0,
                                        ),
                                      )),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}