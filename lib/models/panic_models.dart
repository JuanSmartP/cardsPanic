import 'dart:convert';

class Panic {
  final String? status;
  final List<Info>? info;
  final String? mensaje;

  Panic({
    this.status,
    this.info,
    this.mensaje,
  });

  factory Panic.fromRawJson(String str) => Panic.fromJson(json.decode(str));

  factory Panic.fromJson(Map<String, dynamic> json) => Panic(
        status: json["Status"],
        info: json["info"] == null
            ? []
            : List<Info>.from(json["info"]!.map((x) => Info.fromJson(x))),
        mensaje: json["mensaje"],
      );
}

class Info {
  final String? pkPanico;
  final String? latitud;
  final String? longitud;
  final String? codigoDepartamento;
  final String? nombreDepartamento;
  final String? codigoMunicipio;
  final String? nombreMunicipio;
  final String? codigoPostal;
  final String? barrio;
  final String? direccion;
  final String? numero;
  final String? fecha;
  final String? hora;
  final String? accion;
  final String? tieneAudio;
  final String? rutaAudio;
  final String? ipDispositivo;
  final String? imei;
  final String? marca;
  final String? modelo;

  Info({
    this.pkPanico,
    this.latitud,
    this.longitud,
    this.codigoDepartamento,
    this.nombreDepartamento,
    this.codigoMunicipio,
    this.nombreMunicipio,
    this.codigoPostal,
    this.barrio,
    this.direccion,
    this.numero,
    this.fecha,
    this.hora,
    this.accion,
    this.tieneAudio,
    this.rutaAudio,
    this.ipDispositivo,
    this.imei,
    this.marca,
    this.modelo,
  });

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        pkPanico: json["pk_panico"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        codigoDepartamento: json["codigo_departamento"],
        nombreDepartamento: json["nombre_departamento"],
        codigoMunicipio: json["codigo_municipio"],
        nombreMunicipio: json["nombre_municipio"],
        codigoPostal: json["codigo_postal"],
        barrio: json["barrio"],
        direccion: json["direccion"],
        numero: json["numero"],
        fecha: json["fecha"],
        hora: json["hora"],
        accion: json["accion"],
        tieneAudio: json["tiene_audio"],
        rutaAudio: json["ruta_audio"],
        ipDispositivo: json["ip_dispositivo"],
        imei: json["imei"],
        marca: json["marca"],
        modelo: json["modelo"],
      );
}
