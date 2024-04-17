import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_panic_button/models/panic_models.dart';
import 'package:widget_panic_button/domain/bloc/card_bloc_bloc.dart';
import 'package:widget_panic_button/domain/repositorie/repositoreies.dart';

class CardPanicScren extends StatelessWidget {
  const CardPanicScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RepositoryProvider(
          create: (context) => DataRepository(), child: const CustomCard()),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardBlocBloc(RepositoryProvider.of<DataRepository>(context))
            ..add(LoadData()),
      child:
          BlocBuilder<CardBlocBloc, CardBlocInitial>(builder: (context, state) {
        if (state is DataLoading) {
          return loadingData();
        }

        if (state is DataLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Botones de panico',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('(${state.users.length.toString()})'),
                  ],
                ),
              ),
              CardBody(users: state.users),
            ],
          );
        }
        if (state is DataError) {
          return const Center(
            child: Text('No Internet connection, or something :( '),
          );
        }

        return Container();
      }),
    );
  }
}

// https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3
// 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'

class CardBody extends StatelessWidget {
  const CardBody({super.key, required this.users});
  final List<Info> users;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final containerHeight = screenHeight * 0.78;

    List<Info> dataList = users;
    return SizedBox(
      height: containerHeight,
      width: double.infinity,
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final data = dataList[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              elevation: 19,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data.pkPanico!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        Expanded(
                          child: Tooltip(
                            message: 'Mas informacion',
                            child: IconButton(
                              alignment: Alignment.bottomRight,
                              onPressed: () {
                                // Navigator.pushNamed(context, 'details',
                                // arguments: {
                                //   "ip": data.ipDispositivo,
                                //   "marca": data.marca,
                                //   "imei": data.imei,
                                //   "Codigo_postal": data.codigoPostal,
                                //   "audio": data.rutaAudio,
                                //   "tiene_audio": data.tieneAudio,
                                //   "latitud": data.latitud,
                                //   "longitud": data.longitud
                                // }

                                // );

                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const ListTile(
                                            title: Text('Accion'),
                                          ),
                                          ListTile(
                                            title: const Text('Mas detales'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, 'details',
                                                  arguments: {
                                                    "ip": data.ipDispositivo,
                                                    "marca": data.marca,
                                                    "imei": data.imei,
                                                    "Codigo_postal":
                                                        data.codigoPostal,
                                                    "audio": data.rutaAudio,
                                                    "tiene_audio":
                                                        data.tieneAudio,
                                                    "latitud": data.latitud,
                                                    "longitud": data.longitud
                                                  });
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_vert_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Departamento:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.nombreDepartamento ?? 'NO DATA',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Municipio:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.nombreMunicipio ?? 'NO DATA',
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Barrio:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.barrio ?? 'NO DATA',
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Telefono:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.numero ?? 'No registra',
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Direccion:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.direccion ?? 'No registra',
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Fecha y hora:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Text(
                              data.fecha!.substring(5),
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.hora ?? 'no registra',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'Estado:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(data.accion ?? 'No Info')
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget loadingData() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
