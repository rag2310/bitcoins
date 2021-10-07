# bitcoins

> Prueba para la Empresa Teku
> Asignado a Rodolfo Alfredo Gutierrez Ortega @mention
> Desarrollador Android - Ingeniero en Computacion
> fecha de asignacion de TAREA 2021-10-04 14:23
> Fecha de entrega 2021-10-09 14:00

```batch
    Android Studio Arctic Fox | 2020.3.1 Patch 2
    Build #AI-203.7717.56.2031.7678000, built on August 26, 2021
    Runtime version: 11.0.10+0-b96-7249189 amd64
    VM: OpenJDK 64-Bit Server VM by Oracle Corporation
    Windows 10 10.0
    GC: G1 Young Generation, G1 Old Generation
    Memory: 1280M
    Cores: 4
    Registry: external.system.auto.import.disabled=true
    Non-Bundled Plugins: Dart, org.jetbrains.kotlin, io.flutter V_61.2.2
```

## Api

* [coinbase](https://developers.coinbase.com/api/v2)

## Tecnologias y Librerias Usadas

> En este proyecto se usa **Bloc** para manejar los estados del aplicativo,
> asi como **EQUATABLE** para la comparacion de dos objetos que es un complemento para *Bloc*
> **http** para realizar las peticiones de manera nativa
> **font_awesome_flutter** para los iconos como el del bitcoins
> **intl** para el formato de las fechas

* [Flutter v_2.5.2](https://flutter.dev/docs/get-started/install/windows)
* [http](https://pub.dev/packages/http)
* [flutter_bloc](https://pub.dev/packages/flutter_bloc)
* [equatable](https://pub.dev/packages/equatable)
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
* [intl](https://pub.dev/packages/intl)

## Pantallas

![Home Page](/screen/screen_main.png)

> Muestra las listas  de precios de dos semanas y el precio actual

![Details Page](/screen/screen_details.png)

> Pantalla con el detalle de los precios de las 3 divisas USD, EUR Y COP

## TEST

> Para realizar las pruebas unitarias ejecute el siguiente comando

```batch
    flutter test test/api_client_test.dart
```

![Home Page](/screen/test.png)
