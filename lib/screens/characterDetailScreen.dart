import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gameofthrones_app/functions/card.dart';
import 'package:gameofthrones_app/models/character.dart';
import 'package:http/http.dart';
import 'package:image_fade/image_fade.dart';

class Detail extends StatefulWidget {
  final int? id;

  const Detail({Key? key, required this.id}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Character? c = Character();
  bool? loading = false;

  void bringCharacter() async {
    //print(widget.id);
    var url =
        Uri.parse("https://thronesapi.com/api/v2/Characters/${widget.id!}");
    Response res = await get(url);
    var data = await jsonDecode(res.body);
    setState(() {
      c!.fullName = data["fullName"]!;
      c!.imageUrl = data["imageUrl"];
      c!.title = data["title"];
      c!.family = data["family"];
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    bringCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? const Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 150.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TypewriterAnimatedTextKit(
                text: ["${c!.fullName}"],
                repeatForever: true,
                textStyle:
                    const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                speed: const Duration(milliseconds: 100),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ImageFade(
                    image: NetworkImage(c!.imageUrl!),
                    height: 200,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    duration: const Duration(seconds: 2),
                    curve: Curves.bounceInOut,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 250,
                  child: Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                cardCreator("Name: ", c!.fullName!, context),
                cardCreator("Title: ", c!.title!, context),
                cardCreator("Family: ", c!.family!, context),
              ],
            ),
          );
  }
}
