import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photography_app_ui/data/sample.dart';
import 'package:photography_app_ui/pages/SinglePost.dart';
import 'package:photography_app_ui/pages/single_user.dart';

import 'helpers/colorsys.dart';
import 'models/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorsys.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colorsys.lightGrey,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colorsys.darkGray,
            ),
            onPressed: null),
      ),
      body: Column(
          children: [
            searchBox(),
            SizedBox(
              height: 30,
            ),
             Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("For You", style: TextStyle(color: Colorsys.darkGray, fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Recommended", style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15
                                ),),

                                Container(
                                  width: 50,
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: Colorsys.orange,
                                        width: 3
                                      ))
                                    ),
                                )
                              ],
                            ),

                            SizedBox(width: 20,),
                            Text("Likes", style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15
                            ),)
                          ],
                        ),
                      ),

                    ],
                  ),
              ),
            Expanded(
              child: ListView.builder(
                  itemCount: Sample.getPost.length,
                  itemBuilder: (context, index){
                    return makePost(Sample.getPost[index], index);
                  }),
            )
          ],
        ),

    );
  }

  searchBox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Best Place to \nFind Awesome Photos",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colorsys.darkGray),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 5, top: 2, bottom: 3),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search For Photo",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                )),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colorsys.orange,
                  elevation: 0,
                  minWidth: 50,
                  height: 50,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  makePost(Post post, int index) {
    var user = Sample.getUser[index];
    return Container(
        color: Colors.white,
        height: 350,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingleUser(user: user)),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Hero(
                      tag:post.user.username,
                      transitionOnUserGestures: true,
                      child: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: AssetImage(post.user.profilePicture),
                      ),
                    ),

                    SizedBox(width: 20,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.user.name, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(post.location, style: TextStyle(fontSize: 13),),
                            Text(post.dateAgo, style: TextStyle(fontSize: 13),),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: post.photos.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SinglePost(post: post, image: post.photos[index],)),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1.2/1,
                        child:Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(post.photos[index]),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipRect(
                                          child: BackdropFilter(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(left: 3),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Colors.grey[600].withOpacity(0.1)
                                              ),
                                              child: Center(child: Image.asset("assets/icons/link.png")),
                                            ),
                                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                          )
                                      ),

                                      SizedBox(width: 10,),

                                      ClipRect(
                                          child: BackdropFilter(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(left: 3),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Colors.grey[600].withOpacity(0.1)
                                              ),
                                              child: Center(child: Image.asset("assets/icons/heart.png")),
                                            ),
                                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ) ,
                      ),
                    );
                  }),
            )
          ],
        ),
      );
  }
}































