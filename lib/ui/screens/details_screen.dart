import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

AudioPlayer audioplayers = AudioPlayer();
bool isPlaying = false;
Duration duration = Duration.zero;
Duration position = Duration.zero;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Info del dispositivo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              CustomRow(text: 'IP:', arguments: arguments, argument: 'ip'),
              CustomRow(
                  argument: 'marca', arguments: arguments, text: 'Marca:'),
              CustomRow(arguments: arguments, text: 'imei:', argument: 'imei'),
              CustomRow(
                  arguments: arguments,
                  text: 'Codigo Postal:',
                  argument: 'Codigo_postal'),
              CustomRow(
                  arguments: arguments, text: 'Latitud:', argument: 'latitud'),
              CustomRow(
                  arguments: arguments,
                  text: 'Longitud:',
                  argument: 'longitud'),
              arguments['tiene_audio'] == 'True'
                  ? CustomReproducer(
                      arguments: arguments,
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Center(
                        child: Text('No hay audio disponible'),
                      ),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
          await audioplayers.stop();
          formatTime(position = Duration.zero);
          formatTime(duration = Duration.zero);
        },
        child: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}

class CustomReproducer extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const CustomReproducer({
    super.key,
    required this.arguments,
  });

  @override
  // ignore: no_logic_in_create_state
  State<CustomReproducer> createState() => _CustomReproducerState(arguments);
}

class _CustomReproducerState extends State<CustomReproducer> {
  final Map<String, dynamic> arguments;
  _CustomReproducerState(this.arguments);
  @override
  void initState() {
    audioplayers = AudioPlayer();
    audioplayers.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
    });

    audioplayers.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioplayers.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioplayers.seek(position);
              await audioplayers.resume();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(formatTime(position)), Text(formatTime(duration))],
          ),
        ),
        CustomButton(
          arguments: arguments,
          icon: Icons.play_arrow,
        )
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final Map<String, dynamic> arguments;
  final IconData icon;
  const CustomButton({
    super.key,
    required this.icon,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: IconButton(
        icon: Icon(isPlaying ? Icons.pause_sharp : Icons.play_arrow_sharp),
        iconSize: 50,
        onPressed: () async {
          if (isPlaying) {
            await audioplayers.pause();
          } else {
            Source url = UrlSource(
                ''
                // data.rutaAudio!
                );
            await audioplayers.play(url);
          }
        },
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.arguments,
    required this.text,
    required this.argument,
  });
  final String text;
  final Map<String, dynamic> arguments;
  final String argument;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(
            arguments[argument],
          ),
        ],
      ),
    );
  }
}


// TODO: Centralziar Row para generar menos codigoW