import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parko2/registeration%20screens/SIGNIN/loginpage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Tools/CameraAccess.dart';
import '../Tools/cachehelper.dart';

class MyMapss extends StatefulWidget {
  const MyMapss({Key? key}) : super(key: key);

  @override
  _MyMapssState createState() => _MyMapssState();}

class _MyMapssState extends State<MyMapss> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
  CameraPosition(target: LatLng(30.62103140852295, 32.269721099836914), zoom: 17, );
  Set <Marker> markers = {
    Marker(
        markerId: MarkerId('جراج كلية هندسه'),
        draggable: false,
        onTap: (){
          print("maker tapped");
        },
        position: LatLng(30.624967,32.272549)
    )
  };
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  List<Marker> allMarkers =[
     Marker(
        markerId: MarkerId('جراج كلية هندسه'),

       // draggable: false,
        position: LatLng(30.624967,32.272549),
      infoWindow: InfoWindow(
        title: "جراج كلية الهندسه",

      ),
    ),
  ];

 // late final GoogleMapController _googleMapController;
  late GoogleMapController mapController ;
  Future <void> _MoveToPark ()async{
    const _park = LatLng (30.624967,32.272549);
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(_park, 19));
    setState(() {
      const marker = Marker( markerId: MarkerId('newLocation'),

        position: _park,
        //infoWindow: InfoWindow(title: 'جراج كلية هندسة', snippet: 'The Best Place'),

      ); // Marker

      markers

        ..clear()
        ..add(marker);
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("PARKO"),
        centerTitle: true,
      ),
      drawer:Drawer(

            child:DrawerHeader(
              decoration: const BoxDecoration(

              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ListTile(
                      trailing: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                      title: const Text('Camera',
                      style: TextStyle(
                      fontSize:25,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                      onTap: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CameraPass()));
                      },
                    ),
                    ListTile(
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                      ),
                      title: const Text('Rate App',
                        style: TextStyle(
                        fontSize:25,
                        fontStyle: FontStyle.italic,
                      ),),
                      onTap: () async {
                        Navigator.pop(context);
                        await launchUrl(
                            Uri.parse(
                                'https://play.google.com/store/apps/details?id=com.rokia.parko.eng'),
                            mode: LaunchMode.externalApplication);
                      },
                    ),
               ListTile(
                 trailing: const Icon(Icons.login),
                title: const Text
                 ('Logout',
                style: TextStyle(
                fontSize:25,
                fontStyle: FontStyle.italic,),
                 ),
                 onTap: () {
               GoogleSignIn().signOut();
               CacheHelper.removeData(key: 'token').then((value) {
                 if(value){
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                       builder: (context)=> Login()), (route) => false);
                 }
               });

                    },
      ),
                  ]
              ),
            ),
        ),

      body:
      Stack(

        children: <Widget>[
      GoogleMap(
        // markers : Set.from(allMarkers),
        zoomControlsEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: initialCameraPosition,
        markers: markers,

        mapType: MapType.hybrid,
        onMapCreated:(GoogleMapController controller ) {
         googleMapController = controller;
         // (controller) => googleMapController = controller;
         },


      ),


      Container(
              padding: const EdgeInsets.only(top:24,right: 12,),
              alignment: Alignment.centerRight,
              child: Column(
                children:<Widget> [

                  FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () async {
                       Position position = await _determinePosition();
                       googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                           CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 20)));
                        markers.clear();
                        markers.add(Marker(markerId: const MarkerId('currentLocation'),
                            position: LatLng(position.latitude, position.longitude)));

                        setState(() {});

                      },
                      child: const Icon(Icons.location_on_outlined,size: 30.0,)),
                  SizedBox(height: 10,),
                  FloatingActionButton(
                      onPressed:
                      _MoveToPark,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.local_parking,size: 30.0,)),

                    //label: const Text("Your Location"),
                    //icon: const Icon(Icons.location_on_outlined),

                ],
            ),
          ),
       ],

      ),


    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}