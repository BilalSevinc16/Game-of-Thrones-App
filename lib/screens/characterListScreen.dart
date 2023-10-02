import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gameofthrones_app/models/character.dart';
import 'package:gameofthrones_app/screens/characterDetailScreen.dart';
import 'package:http/http.dart';

class GoTCharacters extends StatefulWidget {
  const GoTCharacters({Key? key}) : super(key: key);

  @override
  State<GoTCharacters> createState() => _GoTCharactersState();
}

class _GoTCharactersState extends State<GoTCharacters> {
  List<Character?> characterList = <Character>[];

  void bringCharacters() async {
    var url = Uri.parse("https://thronesapi.com/api/v2/Characters");
    Response res = await get(url);
    //print(res.body);
    var data = await jsonDecode(res.body);
    //print(data[0]["firstName"]);
    setState(() {
      for (var i = 0; i < data.length; i++) {
        Character c = Character();
        c.id = data[i]["id"];
        c.fullName = data[i]["fullName"];
        c.imageUrl = data[i]["imageUrl"];
        characterList.add(c);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bringCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game of Thrones"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).scaffoldBackgroundColor,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: ListView.builder(
          itemCount: characterList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Detail(
                      id: characterList[index]!.id,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  characterList[index]!.fullName!,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    characterList[index]!.imageUrl!,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

