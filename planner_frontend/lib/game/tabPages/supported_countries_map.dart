import 'dart:convert';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:planner_frontend/game/topics/topics.dart';
import 'dart:math';

class SupportedCountriesMap extends StatefulWidget {
  const SupportedCountriesMap({Key? key}) : super(key: key);

  @override
  _SupportedCountriesMapState createState() => _SupportedCountriesMapState();
}

class _SupportedCountriesMapState extends State<SupportedCountriesMap> {
  final _random = Random();

  var _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.grey,
    Colors.blueGrey,
  ];

  List<Color> _countries = List<Color>.filled(136, Colors.green);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InteractiveViewer(
            maxScale: 75.0,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  // Actual widget from the Countries_world_map package.
                  child: SimpleMap(
                    instructions: SMapWorld.instructions,

                    // If the color of a country is not specified it will take in a default color.
                    defaultColor: Colors.grey,
                    // CountryColors takes in 250 different colors that will color each country the color you want. In this example it generates a random color each time SetState({}) is called.
                    callback: (id, name, tapdetails) {
                      goToCountry(id);
                    },
                    countryBorder: CountryBorder(color: Colors.white),
                    colors: SMapWorldColors(
                      eT: _countries[0],
                      aR: _countries[1],
                      aT: _countries[2],
                      aZ: _countries[3],
                      cL: _countries[4],
                      cD: _countries[5],
                      cG: _countries[6],
                      hK: _countries[7],
                      iN: _countries[8],
                      iD: _countries[9],
                      iL: _countries[10],
                      iT: _countries[11],
                      cI: _countries[12],
                      mY: _countries[13],
                      mT: _countries[14],
                      mZ: _countries[15],
                      nA: _countries[16],
                      pS: _countries[17],
                      pE: _countries[18],
                      pH: _countries[19],
                      pR: _countries[20],
                      sL: _countries[21],
                      zA: _countries[22],
                      sD: _countries[23],
                      eS: _countries[24],
                      cH: _countries[25],
                      gB: _countries[26],
                      vE: _countries[27],
                      vN: _countries[28],
                      zM: _countries[29],
                      zW: _countries[30],
                      uS: _countries[31],
                      aD: _countries[32],
                      aO: _countries[33],
                      aM: _countries[34],
                      aU: _countries[35],
                      bS: _countries[36],
                      bH: _countries[37],
                      bD: _countries[38],
                      bY: _countries[39],
                      bE: _countries[40],
                      bT: _countries[41],
                      bO: _countries[42],
                      bW: _countries[43],
                      bR: _countries[44],
                      bN: _countries[45],
                      bG: _countries[46],
                      bF: _countries[47],
                      bI: _countries[48],
                      cV: _countries[49],
                      cM: _countries[50],
                      cA: _countries[51],
                      cF: _countries[52],
                      tD: _countries[53],
                      cN: _countries[54],
                      cO: _countries[55],
                      cR: _countries[56],
                      hR: _countries[57],
                      cU: _countries[58],
                      cY: _countries[59],
                      cZ: _countries[60],
                      dK: _countries[61],
                      dJ: _countries[62],
                      dO: _countries[63],
                      eC: _countries[64],
                      eG: _countries[65],
                      sV: _countries[66],
                      eE: _countries[67],
                      fO: _countries[68],
                      fI: _countries[69],
                      fR: _countries[70],
                      gE: _countries[71],
                      dE: _countries[72],
                      gR: _countries[73],
                      gT: _countries[74],
                      gN: _countries[75],
                      hT: _countries[76],
                      hN: _countries[77],
                      hU: _countries[78],
                      iR: _countries[79],
                      iQ: _countries[80],
                      iE: _countries[81],
                      jM: _countries[82],
                      jP: _countries[83],
                      kZ: _countries[84],
                      kE: _countries[85],
                      xK: _countries[86],
                      kG: _countries[87],
                      lA: _countries[88],
                      lV: _countries[89],
                      lI: _countries[90],
                      lT: _countries[91],
                      lU: _countries[92],
                      mK: _countries[93],
                      mL: _countries[94],
                      mX: _countries[95],
                      mD: _countries[96],
                      mE: _countries[97],
                      mA: _countries[98],
                      mM: _countries[99],
                      nP: _countries[100],
                      nL: _countries[101],
                      nZ: _countries[102],
                      nI: _countries[103],
                      nG: _countries[104],
                      nO: _countries[105],
                      oM: _countries[106],
                      pK: _countries[107],
                      pA: _countries[108],
                      pY: _countries[109],
                      pL: _countries[110],
                      pT: _countries[111],
                      qA: _countries[112],
                      rO: _countries[113],
                      rU: _countries[114],
                      rW: _countries[115],
                      sM: _countries[116],
                      sA: _countries[117],
                      rS: _countries[118],
                      sG: _countries[119],
                      sK: _countries[120],
                      sI: _countries[121],
                      kR: _countries[122],
                      lK: _countries[123],
                      sE: _countries[124],
                      sY: _countries[125],
                      tW: _countries[126],
                      tJ: _countries[127],
                      tH: _countries[128],
                      tR: _countries[129],
                      uG: _countries[130],
                      uA: _countries[131],
                      aE: _countries[132],
                      uY: _countries[133],
                      uZ: _countries[134],
                      yE: _countries[135],
                    ).toMap(),
                  ),
                ),
                // Creates 8% from right side so the map looks more centered.
                Container(width: MediaQuery.of(context).size.width * 0.08),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: Text('Tap / click a country to see its map',
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center)),
        Positioned(
          bottom: 36,
          right: 36,
          child: FloatingActionButton(
              tooltip: 'Randomize',
              onPressed: () {
                _countries = List<Color>.filled(136, Colors.green);
                _countries[_random.nextInt(135)] = Colors.yellow;
                setState(() {});
              },
              child: Icon(Icons.casino)),
        ),
      ],
    );
  }

  void goToCountry(String country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryPage(country: country),
      ),
    );
  }
}

class CountryPage extends StatefulWidget {
  final String country;

  const CountryPage({required this.country, Key? key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late String state;
  late String instruction;

  late List<Map<String, dynamic>> properties;

  late Map<String, Color?> keyValuesPaires;

  @override
  void initState() {
    instruction = getInstructions(widget.country);
    if (instruction != "NOT SUPPORTED") {
      properties = getProperties(instruction);
      properties.sort((a, b) => a['name'].compareTo(b['name']));
      keyValuesPaires = {};
      properties.forEach((element) {
        keyValuesPaires.addAll({element['id']: element['color']});
      });

      state = 'Tap a state, prefecture or province';
    } else {
      state = 'This country is not supported';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          widget.country.toUpperCase() + ' - ' + state,
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: instruction == "NOT SUPPORTED"
          ? Center(child: Text("This country is not supported"))
          : Column(
              children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                        child: Center(
                            child: SimpleMap(
                      defaultColor: Colors.grey.shade300,
                      key: Key(properties.toString()),
                      colors: keyValuesPaires,
                      instructions: instruction,
                      callback: (id, name, tapDetails) {
                        setState(() {
                          state = name;

                          int i = properties
                              .indexWhere((element) => element['id'] == id);

                          properties[i]['color'] =
                              properties[i]['color'] == Colors.green
                                  ? null
                                  : Colors.green;
                          keyValuesPaires[properties[i]['id']] =
                              properties[i]['color'];
                        });
                      },
                    ))),
                    if (MediaQuery.of(context).size.width > 800)
                      SizedBox(
                          width: 320,
                          height: MediaQuery.of(context).size.height,
                          child: Card(
                            margin: EdgeInsets.all(16),
                            elevation: 8,
                            child: ListView(
                              children: [
                                for (int i = 0; i < properties.length; i++)
                                  ListTile(
                                    title: Text(properties[i]['name']),
                                    leading: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      width: 20,
                                      height: 20,
                                      color: properties[i]['color'] ??
                                          Colors.grey.shade300,
                                    ),
                                    subtitle: Text(properties[i]['id']),
                                    onTap: () {
                                      setState(() {
                                        properties[i]['color'] = properties[i]
                                                    ['color'] ==
                                                Colors.green
                                            ? null
                                            : Colors.green;
                                        keyValuesPaires[properties[i]['id']] =
                                            properties[i]['color'];
                                      });
                                    },
                                  )
                              ],
                            ),
                          )),
                  ]),
                ),
                if (MediaQuery.of(context).size.width < 800)
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Card(
                        margin: EdgeInsets.all(16),
                        elevation: 8,
                        child: ListView(
                          children: [
                            for (int i = 0; i < properties.length; i++)
                              ListTile(
                                title: Text(properties[i]['name']),
                                leading: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width: 20,
                                  height: 20,
                                  color: properties[i]['color'] ??
                                      Colors.grey.shade300,
                                ),
                                subtitle: Text(properties[i]['id']),
                                onTap: () {
                                  setState(() {
                                    properties[i]['color'] =
                                        properties[i]['color'] == Colors.green
                                            ? null
                                            : Colors.green;
                                    keyValuesPaires[properties[i]['id']] =
                                        properties[i]['color'];
                                  });
                                },
                              )
                          ],
                        ),
                      )),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopicsScreen(countryId: widget.country)),
          );
        },
        child: const Icon(Icons.psychology_alt_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Map<String, dynamic>> getProperties(String input) {
    Map<String, dynamic> instructions = json.decode(input);

    List paths = instructions['i'];

    List<Map<String, dynamic>> properties = [];

    paths.forEach((element) {
      properties.add({
        'name': element['n'],
        'id': element['u'],
        'color': null,
      });
    });

    return properties;
  }

  String getInstructions(String id) {
    switch (id) {
      case 'ar':
        return SMapArgentina.instructions;

      case 'at':
        return SMapAustria.instructions;

      case 'ad':
        return SMapAndorra.instructions;

      case 'ao':
        return SMapAngola.instructions;

      case 'am':
        return SMapArmenia.instructions;

      case 'au':
        return SMapAustralia.instructions;

      case 'az':
        return SMapAzerbaijan.instructions;

      case 'bs':
        return SMapBahamas.instructions;

      case 'bh':
        return SMapBahrain.instructions;

      case 'bd':
        return SMapBangladesh.instructions;

      case 'by':
        return SMapBelarus.instructions;

      case 'be':
        return SMapBelgium.instructions;

      case 'bt':
        return SMapBhutan.instructions;

      case 'bo':
        return SMapBolivia.instructions;

      case 'bw':
        return SMapBotswana.instructions;

      case 'br':
        return SMapBrazil.instructions;

      case 'bn':
        return SMapBrunei.instructions;

      case 'bg':
        return SMapBulgaria.instructions;

      case 'bf':
        return SMapBurkinaFaso.instructions;

      case 'bi':
        return SMapBurundi.instructions;

      case 'ca':
        return SMapCanada.instructions;

      case 'cm':
        return SMapCameroon.instructions;

      case 'cf':
        return SMapCentralAfricanRepublic.instructions;

      case 'cv':
        return SMapCapeVerde.instructions;

      case 'td':
        return SMapChad.instructions;

      case 'cn':
        return SMapChina.instructions;

      case 'ch':
        return SMapSwitzerland.instructions;

      case 'cd':
        return SMapCongoDR.instructions;

      case 'cg':
        return SMapCongoBrazzaville.instructions;

      case 'co':
        return SMapColombia.instructions;

      case 'cr':
        return SMapCostaRica.instructions;

      case 'hr':
        return SMapCroatia.instructions;

      case 'cu':
        return SMapCuba.instructions;

      case 'cl':
        return SMapChile.instructions;

      case 'ci':
        return SMapIvoryCoast.instructions;

      case 'cy':
        return SMapCyprus.instructions;

      case 'cz':
        return SMapCzechRepublic.instructions;

      case 'dk':
        return SMapDenmark.instructions;

      case 'dj':
        return SMapDjibouti.instructions;

      case 'do':
        return SMapDominicanRepublic.instructions;

      case 'ec':
        return SMapEcuador.instructions;

      case 'es':
        return SMapSpain.instructions;

      case 'eg':
        return SMapEgypt.instructions;

      case 'et':
        return SMapEthiopia.instructions;

      case 'sv':
        return SMapElSalvador.instructions;

      case 'ee':
        return SMapEstonia.instructions;

      case 'fo':
        return SMapFaroeIslands.instructions;

      case 'fi':
        return SMapFinland.instructions;

      case 'fr':
        return SMapFrance.instructions;

      case 'gb':
        return SMapUnitedKingdom.instructions;

      case 'ge':
        return SMapGeorgia.instructions;

      case 'de':
        return SMapGermany.instructions;

      case 'gr':
        return SMapGreece.instructions;

      case 'gt':
        return SMapGuatemala.instructions;

      case 'gn':
        return SMapGuinea.instructions;

      case 'hi':
        return SMapHaiti.instructions;

      case 'hk':
        return SMapHongKong.instructions;

      case 'hn':
        return SMapHonduras.instructions;

      case 'hu':
        return SMapHungary.instructions;

      case 'in':
        return SMapIndia.instructions;

      case 'id':
        return SMapIndonesia.instructions;

      case 'il':
        return SMapIsrael.instructions;

      case 'ir':
        return SMapIran.instructions;

      case 'iq':
        return SMapIraq.instructions;

      case 'ie':
        return SMapIreland.instructions;

      case 'it':
        return SMapItaly.instructions;

      case 'jm':
        return SMapJamaica.instructions;

      case 'jp':
        return SMapJapan.instructions;

      case 'kz':
        return SMapKazakhstan.instructions;

      case 'ke':
        return SMapKenya.instructions;

      case 'xk':
        return SMapKosovo.instructions;

      case 'kg':
        return SMapKyrgyzstan.instructions;

      case 'la':
        return SMapLaos.instructions;

      case 'lv':
        return SMapLatvia.instructions;

      case 'li':
        return SMapLiechtenstein.instructions;

      case 'lt':
        return SMapLithuania.instructions;

      case 'lu':
        return SMapLuxembourg.instructions;

      case 'mk':
        return SMapMacedonia.instructions;

      case 'ml':
        return SMapMali.instructions;

      case 'mt':
        return SMapMalta.instructions;

      case 'mz':
        return SMapMozambique.instructions;

      case 'mx':
        return SMapMexico.instructions;

      case 'md':
        return SMapMoldova.instructions;

      case 'me':
        return SMapMontenegro.instructions;

      case 'ma':
        return SMapMorocco.instructions;

      case 'mm':
        return SMapMyanmar.instructions;

      case 'my':
        return SMapMalaysia.instructions;

      case 'na':
        return SMapNamibia.instructions;

      case 'np':
        return SMapNepal.instructions;

      case 'nl':
        return SMapNetherlands.instructions;

      case 'nz':
        return SMapNewZealand.instructions;

      case 'ni':
        return SMapNicaragua.instructions;

      case 'ng':
        return SMapNigeria.instructions;

      case 'no':
        return SMapNorway.instructions;

      case 'om':
        return SMapOman.instructions;

      case 'ps':
        return SMapPalestine.instructions;

      case 'pk':
        return SMapPakistan.instructions;

      case 'ph':
        return SMapPhilippines.instructions;

      case 'pa':
        return SMapPanama.instructions;

      case 'pe':
        return SMapPeru.instructions;

      case 'pr':
        return SMapPuertoRico.instructions;

      case 'py':
        return SMapParaguay.instructions;

      case 'pl':
        return SMapPoland.instructions;

      case 'pt':
        return SMapPortugal.instructions;

      case 'qa':
        return SMapQatar.instructions;

      case 'ro':
        return SMapRomania.instructions;

      case 'ru':
        return SMapRussia.instructions;

      case 'rw':
        return SMapRwanda.instructions;

      case 'sa':
        return SMapSaudiArabia.instructions;

      case 'rs':
        return SMapSerbia.instructions;

      case 'sd':
        return SMapSudan.instructions;

      case 'sg':
        return SMapSingapore.instructions;

      case 'sl':
        return SMapSierraLeone.instructions;

      case 'sk':
        return SMapSlovakia.instructions;

      case 'si':
        return SMapSlovenia.instructions;

      case 'kr':
        return SMapSouthKorea.instructions;

      case 'lk':
        return SMapSriLanka.instructions;

      case 'se':
        return SMapSweden.instructions;

      case 'sy':
        return SMapSyria.instructions;

      case 'tw':
        return SMapTaiwan.instructions;

      case 'tj':
        return SMapTajikistan.instructions;

      case 'th':
        return SMapThailand.instructions;

      case 'tr':
        return SMapTurkey.instructions;

      case 'ug':
        return SMapUganda.instructions;

      case 'ua':
        return SMapUkraine.instructions;

      case 'ae':
        return SMapUnitedArabEmirates.instructions;

      case 'us':
        return SMapUnitedStates.instructions;

      case 'uy':
        return SMapUruguay.instructions;

      case 'uz':
        return SMapUzbekistan.instructions;

      case 've':
        return SMapVenezuela.instructions;

      case 'vn':
        return SMapVietnam.instructions;

      case 'ye':
        return SMapYemen.instructions;

      case 'za':
        return SMapSouthAfrica.instructions;

      case 'zm':
        return SMapZambia.instructions;

      case 'zw':
        return SMapZimbabwe.instructions;

      default:
        return 'NOT SUPPORTED';
    }
  }
}
