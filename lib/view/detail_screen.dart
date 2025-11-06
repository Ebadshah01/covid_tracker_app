import 'package:covid_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int cases, deaths, recovered;

  const DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(
            "https://i.pinimg.com/474x/c9/31/9d/c9319db31c9c18f9577cbe191b66dd3b.jpg",
            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS71GXPkWk9pTQehWRlrQuWkAj6_Arm5rITmA&s",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: Colors.black,
          // Colors.grey.withOpacity(0.6),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS71GXPkWk9pTQehWRlrQuWkAj6_Arm5rITmA&s"
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_5s1PZ0YcCiyYEAQo260Dtp77CihNrJBIvw&s",
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ReusableRow(title: "Name", value: widget.name),
                          ReusableRow(
                            title: "Cases",
                            value: widget.cases.toString(),
                          ),
                          ReusableRow(
                            title: "Recovered",
                            value: widget.recovered.toString(),
                          ),
                          ReusableRow(
                            title: "Deaths",
                            value: widget.deaths.toString(),
                          ),
                          ReusableRow(title: "Name", value: widget.name),
                          PieChart(
                            dataMap: {
                              'Total': double.parse(widget.cases.toString()),
                              'Recovered': double.parse(
                                widget.recovered.toString(),
                              ),
                              'Death': double.parse(widget.deaths.toString()),
                            },
                            legendOptions: LegendOptions(
                              legendTextStyle: TextStyle(color: Colors.white),
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(seconds: 1),
                            chartType: ChartType.ring,
                            chartRadius: 100,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(widget.image)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
