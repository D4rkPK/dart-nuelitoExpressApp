import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nuelitoexpress/bloc.navigation_bloc/naviation_bloc.dart';
import 'package:nuelitoexpress/bloc/cartlistBloc.dart';
import 'package:nuelitoexpress/bloc/listTileColorBloc.dart';
import 'cart.dart';
import 'package:nuelitoexpress/model/food_item.dart';

var nameList = fooditemList;
class HomePage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        //Bloques de control
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ],
      child: MaterialApp(
        title: "Nuelito Express",
        home: HomePageBuild(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/refresh': (BuildContext context) => new HomePageBuild(),
        },
      ),
    );
  }
}

class HomePageBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: ListView(
              children: <Widget>[
                FirstHalf(),
                SizedBox(height: 45),
              for (var foodItem in nameList.foodItems)
                Builder(
                  builder: (context) {
                  return ItemContainer(foodItem: foodItem);
                },
               ),
              ],
            ),
          )),
    );
  }
}

class ItemContainer extends StatelessWidget {

  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();


  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackBar = SnackBar(
          content: Text('${foodItem.title} añadido al carrito'),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2) == 0 ? true : false,
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {
  const FirstHalf({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          //you could also use the spacer widget to give uneven distances, i just decided to go with a sizebox
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
          SizedBox(height: 45),
          categories(),
        ],
      ),
    );
  }
}

class categories extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            onTap: () {
              nameList = fooditemList;
              Navigator.of(context).pushNamed('/refresh');
            },
            child: CategoryListItem(
              imgUrl:
              "https://firebasestorage.googleapis.com/v0/b/nuelito-927e8.appspot.com/o/FotosNegocios%2Fsubwayr-restaurants-reveals-bold-new-logo-and-symbol-null-hr.jpg?alt=media&token=f0f84c31-1572-4296-ab6b-20c177ff4475",
              categoryName: "Subway",
              selected: false,
            ),),

          InkWell(
            onTap: () {
              nameList = fooditemListdos;
              Navigator.of(context).pushNamed('/refresh');
            },
            child: CategoryListItem(
              imgUrl:
              "https://firebasestorage.googleapis.com/v0/b/nuelito-927e8.appspot.com/o/FotosNegocios%2Fsubwayr-restaurants-reveals-bold-new-logo-and-symbol-null-hr.jpg?alt=media&token=f0f84c31-1572-4296-ab6b-20c177ff4475",
              categoryName: "Mc Donald",
              selected: false,
            ),),
        ],
      ),
    );
  }
}

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: leftAligned ? 20 : 0,
                    right: leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(itemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Text("\Q$itemPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                                children: [
                                  TextSpan(text: "de "),
                                  TextSpan(
                                      text: hotel,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                ]),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.imgUrl,
    @required this.categoryName,
    @required this.selected,
  }) : super(key: key);

  final String imgUrl;
  final String categoryName;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Colors.orange[900] : Colors.white,
        border: Border.all(
            color: selected ? Colors.transparent : Colors.grey[200],
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(15, 0),
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey[200],
                    width: 1.5)),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
                height: 30,
              ),
            ),
          /*Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey[200],
                    width: 1.5)),
            child: Image.network(
              imgUrl,
            ),
          ),*/
          SizedBox(height: 10),
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),
      SizedBox(width: 20),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Buscar",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(
                color: Colors.black87,
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red))),
        ),
      ),
    ],
  );
}

Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 45),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Ordene",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          Text(
            "Aquí",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          ),
        ],
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(length.toString()),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.orange[900], borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

