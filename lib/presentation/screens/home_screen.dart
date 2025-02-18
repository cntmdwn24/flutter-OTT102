import 'package:flutter/material.dart';
import 'package:ott102/presentation/providers/main_provider.dart';
import '../../common/color.dart';
import 'package:ott102/presentation/components/widget/star_reted_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainProvider.addListener(updateScreen);
      mainProvider.loadGenreList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: grayColor,
          title: Image.asset(
            'assets/images/showtime_logo.png',
          ),
          actions: [
            SizedBox(
              width: MediaQuery
                  .sizeOf(context)
                  .width - 60,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: mainProvider.genreList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        mainProvider.genreList[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }),
            )
          ],
        ),
        backgroundColor: backgroundColor,
        body: mainProvider.topRatedMovieList.isNotEmpty ? SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(),
              SizedBox(height: 20,),
              Text('방영 중인 작품',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              StarRatedBar(value: 7),
              SizedBox(height: 12,),
              Text('', style: TextStyle(fontSize: 16, color: Colors.white),)
            ],
          ),
        ));
  }
}
