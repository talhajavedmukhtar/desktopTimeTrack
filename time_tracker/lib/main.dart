import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      home: TimeTrackerScreen(),
    );
  }
}

class TimeTrackerScreen extends StatefulWidget {
  @override
  _TimeTrackerScreenState createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends State<TimeTrackerScreen> {
  Duration _timeElapsed = Duration.zero;
  List<Duration> _previousTimers = [];
  bool _isTracking = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        backgroundColor: Color(0xFF391E8A),
      ),
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Time Elapsed: ${formatDuration(_timeElapsed)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isTracking = !_isTracking;
                  if (_isTracking) {
                    startTracking();
                  } else {
                    stopTracking();
                  }
                });
              },
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isTracking) {
                    stopTracking();
                  }
                  _previousTimers.add(_timeElapsed);
                  _timeElapsed = Duration.zero;
                });
              },
              child: Text('New Tracker'),
            ),
            SizedBox(height: 20),
            Text(
              'Previous Timers:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: _previousTimers
                  .map((duration) => Text(formatDuration(duration)))
                  .toList(),
            ),
          ],
        ),
      ),*/
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Left Column for Previous Timers List
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Container(
                  width: 200, // Adjust as needed
                  child: Scrollbar(
                    child: ListView(
                      children: _previousTimers
                          .map((duration) => ListTile(
                                title: Text(formatDuration(duration)),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            // Right Column for Buttons and Timer
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Time Elapsed: ${formatDuration(_timeElapsed)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isTracking = !_isTracking;
                        if (_isTracking) {
                          startTracking();
                        } else {
                          stopTracking();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF391E8A),
                    ),
                    child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_isTracking) {
                          stopTracking();
                        }
                        _previousTimers.add(_timeElapsed);
                        _timeElapsed = Duration.zero;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF391E8A),
                    ),
                    child: Text('New Tracker'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void startTracking() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        _timeElapsed += oneSecond;
      });
    });
  }

  void stopTracking() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
