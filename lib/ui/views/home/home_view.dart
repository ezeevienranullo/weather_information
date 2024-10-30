import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_info/ui/common/opensans_text.dart';

import '../../common/app_strings.dart';
import 'home_viewmodel.dart';
import 'package:intl/intl.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TableCalendar(
                focusedDay: viewModel.selectedDay,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarFormat: viewModel.calendarFormat,
                onFormatChanged: (format) {
                  viewModel.setCalendarFormat(format);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  viewModel.setDay(selectedDay);
                },
                selectedDayPredicate: (day) => isSameDay(viewModel.selectedDay, day),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              if (viewModel.isBusy)
                const LinearProgressIndicator(),
              if(viewModel.weatherData['weather'] != null)
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OpenSansText.bold(DateFormat('EEEE, MMM d').format(viewModel.selectedDay), Colors.grey, 16),
                      OpenSansText.medium('${viewModel.weatherData['name']}, ${viewModel.weatherData['sys']['country']}', Colors.grey, 16),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${toBeginningOfSentenceCase(viewModel.weatherData['weather'][0]['description'].toString())}', Colors.black, 14),
                              OpenSansText.regular(str_desc, Colors.grey, 12),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${viewModel.weatherData['main']['temp'] }C', Colors.black, 16),
                              OpenSansText.regular(str_temp, Colors.grey, 12),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${viewModel.weatherData['main']['humidity']}', Colors.black, 16),
                              OpenSansText.regular(str_humidity, Colors.grey, 12),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      OpenSansText.semiBold(str_wind, Colors.grey, 14),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${viewModel.weatherData['wind']['speed']}', Colors.black, 16),
                              OpenSansText.regular(str_speed, Colors.grey, 12),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${viewModel.weatherData['wind']['deg']}', Colors.black, 16),
                              OpenSansText.regular(str_deg, Colors.grey, 12),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OpenSansText.medium('${viewModel.weatherData['wind']['gust']}', Colors.black, 16),
                              OpenSansText.regular(str_gust, Colors.grey, 12),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 15),
              Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: viewModel.notes.isNotEmpty ?
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OpenSansText.semiBold(str_my_notes, Colors.black, 12),
                      const SizedBox(height: 10),
                      ...List.generate(viewModel.notes.length, (index) =>
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                            child: OpenSansText.regular('• ${viewModel.notes[index].content}', Colors.black, 14),
                          )
                      ),
                    ]
                )
                    : OpenSansText.regular(str_no_notes, Colors.orange, 14),
              ),
              ElevatedButton(
                onPressed: ()=> viewModel.showBottomSheet(viewModel.selectedDay),
                child: OpenSansText.regular(str_add_note, Colors.white, 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel(context);

  @override
  void onViewModelReady(HomeViewModel viewModel)=> SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.init(),);
}

