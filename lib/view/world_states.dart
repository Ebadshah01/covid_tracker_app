import 'package:covid_tracker_app/model/world_states_model.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.white,
                         controller: _controller,
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data!.cases!.toString()),
                             "Recover": double.parse(snapshot.data!.recovered!.toString()), 
                             "Deaths": double.parse(snapshot.data!.deaths!.toString())},
                          animationDuration: Duration(seconds: 1),
                          chartType: ChartType.ring,
                          chartRadius: 150,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReusableRow(title: 'Recover', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReusableRow(title: 'Actice', value: snapshot.data!.active.toString()),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()), 

                               
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                          },
                          child: Container(

                            height: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green,),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
