import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Mangcoding'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Schedule',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ScheduleCard(
                  date: 'Sun, 20/1/2023',
                  time: '10.00 AM - 01.00 PM',
                  title:
                      'Development of software for the protection of information resources',
                  urgent: true,
                ),
                ScheduleCard(
                  date: 'Sun, 20/1/2023',
                  time: '10.00 AM - 01.00 PM',
                  title:
                      'Development of software for the protection of information resources',
                  urgent: false,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.schedule, title: 'Schedule'),
          TabItem(icon: Icons.calendar_today, title: 'Calendar'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex, // optional, default as 0
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final bool urgent;

  ScheduleCard(
      {required this.date,
      required this.time,
      required this.title,
      this.urgent = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(title),
        subtitle: Text('$date\n$time'),
        trailing:
            urgent ? Text('Urgent', style: TextStyle(color: Colors.red)) : null,
      ),
    );
  }
}
