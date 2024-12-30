'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1b2e2ff4bbd84044ad539e7754440a48",
"assets/AssetManifest.bin.json": "5a7d2baa2d80e01ae73d1ca61509a844",
"assets/AssetManifest.json": "cb42cf7dce08fd3df19d3ca4b85eed1c",
"assets/assets/carddecks/airplanes.json": "2aedba158b7fabc29d7ce33aa4cebb5f",
"assets/assets/carddecks/cars.json": "24f3243a699132004c127e7a583a16f6",
"assets/assets/carddecks/localCardDecks.json": "4da5e206eb1c0ac0c1130caec7d6e595",
"assets/assets/carddecks/rockets.json": "db1e49a74c7ba7a9864a12ef61bfd1d7",
"assets/assets/images/2.0x/flutter_logo.png": "4efb9624185aff46ca4bf5ab96496736",
"assets/assets/images/3.0x/flutter_logo.png": "b8ead818b15b6518ac627b53376b42f2",
"assets/assets/images/Airplanes/Aerospatiale-BAC_Concorde.jpg": "f8d3e171bb7e22b14f7496d9d205609c",
"assets/assets/images/Airplanes/Airbus_A220-300.jpg": "1cf4e3c0814e15ccc317dd2084cab80a",
"assets/assets/images/Airplanes/Airbus_A300B1.jpg": "9c5738ef10b0da035d47e629fb00b8f4",
"assets/assets/images/Airplanes/Airbus_A310-200.jpg": "decec294c3f5e23e812024a3a43c7376",
"assets/assets/images/Airplanes/Airbus_A318.jpg": "8d9ee3a22c0d5d1ce952bf2678f2209a",
"assets/assets/images/Airplanes/Airbus_A319neo.jpg": "e17c76b1dd423875a62859d188b792e1",
"assets/assets/images/Airplanes/Airbus_A320neo.jpg": "439f06e144794e871f90a218e22e801e",
"assets/assets/images/Airplanes/Airbus_A321neo.jpg": "86ec50ecf1ab98cc6ad8c0b3f0e9a1a8",
"assets/assets/images/Airplanes/Airbus_A330-900.jpg": "37b98eb6d5713f0614170efbf975ad89",
"assets/assets/images/Airplanes/Airbus_A340-600.jpg": "cbfd1c62bc8ba579a02213554318409c",
"assets/assets/images/Airplanes/Airbus_A350-1000.jpg": "10fd205cd02efdcb0892430dbaaaad56",
"assets/assets/images/Airplanes/Airbus_A380.jpg": "e9226ea80990921a64327866c6b8aae1",
"assets/assets/images/Airplanes/Airbus_A400M.jpg": "d6f68629c9cb28eb8fe0d6062cf57ed5",
"assets/assets/images/Airplanes/Airbus_Beluga.jpg": "3c61882cbd2a065e172a393c8ed2594e",
"assets/assets/images/Airplanes/airplanes_background.jpg": "9200277390a6986bfb015294e3b8b3f8",
"assets/assets/images/Airplanes/airplanes_thumbnail.png": "38fb4cd832e53c8af712c9749badaf28",
"assets/assets/images/Airplanes/Antonov_An-2.jpg": "65f6346faeca4d7529a40af947401229",
"assets/assets/images/Airplanes/Antonov_An-225.jpg": "3a71c4010206fb2aea933daf51b201ab",
"assets/assets/images/Airplanes/Bell_Boeing_CV-22B_Osprey.jpg": "e0e65c7a2e55abf43783737e8c501fc3",
"assets/assets/images/Airplanes/Bell_X-1.jpg": "dafc50803158a4a1109840d8f74b2208",
"assets/assets/images/Airplanes/Bleriot.jpg": "48bde33096355ab864d92c3722108941",
"assets/assets/images/Airplanes/Boeing_307.jpg": "2fbb9bb151a1a405d9b408d5d37407e0",
"assets/assets/images/Airplanes/Boeing_707.jpg": "d115a7ba3139b493c95b8fb9b68f1ad0",
"assets/assets/images/Airplanes/Boeing_727.jpg": "d2c769e6ffdad2287634d5e5dffa11f9",
"assets/assets/images/Airplanes/Boeing_737-9_MAX.jpg": "610518ec156b0dcfa5c2a6b13a618a44",
"assets/assets/images/Airplanes/Boeing_747-8.jpg": "191e38d60879ccf2bfc971a44e6058d3",
"assets/assets/images/Airplanes/Boeing_757.jpg": "41b956c5d47dfc21a57f33bfd529de95",
"assets/assets/images/Airplanes/Boeing_767-200.jpg": "0d95a9e22d9c5f55a9943cb5ce53af3e",
"assets/assets/images/Airplanes/Boeing_77-300.jpg": "65c303552e2d21d7af873c15c7ccb23f",
"assets/assets/images/Airplanes/Boeing_787.jpg": "0ae681936e734d94afb2509f6b772078",
"assets/assets/images/Airplanes/Boeing_B-29.jpg": "9ad43476afe13df075c69aed9cd6ddad",
"assets/assets/images/Airplanes/Boeing_B-52.jpg": "2659246b0200b877c5decdb1dd42e6b2",
"assets/assets/images/Airplanes/Boeing_C-17.jpg": "496fd929004716a873b2f45b8c863370",
"assets/assets/images/Airplanes/Bombardier_CRJ-100.jpg": "f27e826faf00d77e740e2ebfc3ace095",
"assets/assets/images/Airplanes/British_Aerospace-146-100.jpg": "944d255c617c833f5fd3911f1a0dd2de",
"assets/assets/images/Airplanes/CConvair_XFY_Pogo.jpg": "4bdb62dc84059ce2f421eac2b0cedb48",
"assets/assets/images/Airplanes/Cessna_172.jpg": "06107cb33c2b2e3beaae3ecc5f90c656",
"assets/assets/images/Airplanes/Cessna_Citation.jpg": "77a5ecc730fbc4d2fe9baae1bbe4a99c",
"assets/assets/images/Airplanes/Cirrus_SR22.jpg": "980dd909f9ab8571a031d74638d3a916",
"assets/assets/images/Airplanes/COMAC_C919.jpg": "902abb5943727ad0ce66780dc6bb672d",
"assets/assets/images/Airplanes/Convair_880.jpg": "a7cf28316e9040f98628a5a2effdaffd",
"assets/assets/images/Airplanes/Convair_XFY_Pogo.jpg": "5de4edecf89eaae430da7c1cde8d16e9",
"assets/assets/images/Airplanes/Dassault_Falcon_7X.jpg": "c7836c9d3a497bc8238d66c08beecc9b",
"assets/assets/images/Airplanes/Dassault_Mercure.jpg": "d693a4467a30c228f5c1c380c136cbcc",
"assets/assets/images/Airplanes/De_Havilland_Canada_DHC-8-400.jpg": "4337ca44de9c7446c226f9ca6c4bfcfc",
"assets/assets/images/Airplanes/DH_Comet.jpg": "84c228fce19819a273eff4f17ec56682",
"assets/assets/images/Airplanes/Dornier_Do-X.jpg": "31e8e557e746d5c3f1a62ae0a7659ff0",
"assets/assets/images/Airplanes/Dornier_Do_31.jpg": "107ea736f9f3e67adef1a380116b4e21",
"assets/assets/images/Airplanes/Douglas_DC-3.JPG": "7218694e804f4f05b4794877fd6c6138",
"assets/assets/images/Airplanes/Douglas_DC-8.jpg": "e473308defe2dcc2387d10eb6600dfd5",
"assets/assets/images/Airplanes/Embraer_E-Jet.jpg": "597449cbf3ad8620f1391be10e1f52d5",
"assets/assets/images/Airplanes/Eurofighter_Typhoon.jpg": "de4e16c25b22d79e1598de7a2fd91cc0",
"assets/assets/images/Airplanes/F-22.jpg": "c91a23d8b2122edd83688676647daeb4",
"assets/assets/images/Airplanes/F4U_Corsair.jpg": "d7bf4948e34ce6ad33e07082b076b160",
"assets/assets/images/Airplanes/Focke-Wulf_Fw_200.jpg": "e50a7aceed0457c77048b3d97527fc7e",
"assets/assets/images/Airplanes/Fokker_100.jpg": "bb625d8ec29cfe442f61ab5e847e2727",
"assets/assets/images/Airplanes/General_Atomics_MQ-1.jpg": "dc73ac6acf02d9ecbf8be1c5f09c7a69",
"assets/assets/images/Airplanes/Gulfstream_G600.jpg": "1d88df81b768f3230dd8cb1baeccedc4",
"assets/assets/images/Airplanes/Harrier_jump_jet.jpg": "7da346ac447ec509557a7663af02ebd5",
"assets/assets/images/Airplanes/Heinkel_He_178.jpg": "4e2831135f2f9464d7d5e1080a6150e3",
"assets/assets/images/Airplanes/Iljuschin_Il-62.jpg": "1a82beda79a2d65b6927142c7f63fbc7",
"assets/assets/images/Airplanes/Iljuschin_Il-96.jpg": "4be653bfb9cd3f42a7e95aafa61e2dac",
"assets/assets/images/Airplanes/Ju52.JPG": "98fd0389206ebb13bee33a665568a08f",
"assets/assets/images/Airplanes/Learjet_23.jpg": "32c584030df92fb1693b5aa955657cf4",
"assets/assets/images/Airplanes/LICENSE.txt": "ec0711b93c4cee7db5bf5a32e458454f",
"assets/assets/images/Airplanes/Lockheed_Constellation.jpg": "9d574de69ab41da2390ee51fa1a131fc",
"assets/assets/images/Airplanes/Lockheed_F-117.jpg": "e5c6a9f9911c9ad4dff7d8ed4b3e9815",
"assets/assets/images/Airplanes/MacCready_Gossamer_Albatross.jpg": "277caae96976daeae8cded3eba325df6",
"assets/assets/images/Airplanes/McDonnell_Douglas_DC-9.jpg": "2e4372f81887a91a589bd6be6de779ab",
"assets/assets/images/Airplanes/MD-11.JPG": "81bd395e062b23a37f1c68fad7d39d67",
"assets/assets/images/Airplanes/Messerschmitt_Me-262.jpg": "c71d48cb08d4e0db3d341c4733f098d5",
"assets/assets/images/Airplanes/MiG-21.jpg": "36c06cc7ddab5a7284abb21870c3a98b",
"assets/assets/images/Airplanes/Northrop_B-2.jpg": "0c897ba448183b00ed85fb13605c1651",
"assets/assets/images/Airplanes/Piaggio_P-180_Avanti.jpg": "df8cdc00313d4737f01b98c1342791aa",
"assets/assets/images/Airplanes/Piper_J-3_Cub.jpg": "3ddda4425f126c8aaa30d75255da5654",
"assets/assets/images/Airplanes/Rutan%2520Voyager.jpg": "2986a5e559467bbbcaf4c31b13459626",
"assets/assets/images/Airplanes/Spirit_of_St._Louis.jpg": "8a7b9cb662153e57c31d301c428edf1b",
"assets/assets/images/Airplanes/Spitfire.jpg": "bc622e8bda30896c09a43251eba2d840",
"assets/assets/images/Airplanes/SR-71.jpg": "d39e1247d19f51f842497f36f85fac15",
"assets/assets/images/Airplanes/Sud_Aviation_Caravelle.jpg": "048c77d746fd3eb1be4a5c03abd2d454",
"assets/assets/images/Airplanes/Tupolev_Tu-104.jpg": "85e02c93a235a66641d2d48f58582be3",
"assets/assets/images/Airplanes/Tupolev_Tu-144.jpg": "00653d1e00edd7d935fa77c1bdbea501",
"assets/assets/images/Airplanes/Tupolev_Tu-154.jpg": "103ad9d8748119dd5bd0af96486b183e",
"assets/assets/images/Airplanes/Tupolev_Tu-95.jpg": "1ea628a82a7381e1dc4b00cf11be4649",
"assets/assets/images/Airplanes/Vickers_VC10.jpg": "7e2babcf0eceb66af26c181c9daf48ad",
"assets/assets/images/Airplanes/wright-flyer.jpg": "6e08f05fad5fcc366007e1933bcbb8fb",
"assets/assets/images/Airplanes/Yakovlev_Yak-40.jpg": "76086bf558d00a82e84bcbf8af2fafaa",
"assets/assets/images/animals/animals_background.jpg": "40cf2a150f662c01ca6894fb82fb170e",
"assets/assets/images/animals/animals_thumbnail.png": "a6e2ed220816b832d47939f5a54f49ef",
"assets/assets/images/black-yellow.png": "872eafa2ea049c5a52598007700c6a31",
"assets/assets/images/Cars/Alfa_Romeo_Montreal.jpg": "6339b2c6df88413ab82d8e1427aeb0c1",
"assets/assets/images/Cars/Apollo_IE.jpg": "30c8e82179006f1de270f3c7b29d296f",
"assets/assets/images/Cars/AR8C-Competizione.jpg": "51a708b6f14a0cb9e0e3abf84bad2eaa",
"assets/assets/images/Cars/aston-martin-one-77.jpg": "9d402752b28d00f9e39c02a46c281183",
"assets/assets/images/Cars/Aston_Martin_DB5_Vantage.jpg": "1561bb0426960ffb73e95d57895fa18d",
"assets/assets/images/Cars/Aston_Martin_V8_Vantage.jpg": "6429a900844b47cb0b1638d8ac06fa21",
"assets/assets/images/Cars/audi_Q8_e-tron.jpg": "d8d92628fed038235f77ae29f239e814",
"assets/assets/images/Cars/audi_quattro.jpg": "a94c47baa4ca87d1e900eaf6425b3f09",
"assets/assets/images/Cars/Audi_R18_e-tron_quattro.jpg": "05212ea912a39f5e3273f0ff2497876e",
"assets/assets/images/Cars/Audi_R8.jpg": "d8beacaf6ecdc8d6d5ce36d15cc4c8e7",
"assets/assets/images/Cars/Audi_TT_8N.jpg": "e9d0a6b69cc0fe8255c06861395df0d0",
"assets/assets/images/Cars/belAir.jpg": "94cbd08c7bb657a20d1114b27aa7f42a",
"assets/assets/images/Cars/Bentley_Continental_GT.jpg": "8e51f6e8d7a9c9b9d37c2ceecb984dc1",
"assets/assets/images/Cars/Benz-Patent-Motorwagen.jpg": "38856d5ae3e669b6cd2634a15ffdd694",
"assets/assets/images/Cars/BMWi3.jpg": "9b46507376cf5facd3a39b8b914a5c5f",
"assets/assets/images/Cars/BMW_2002_Turbo.jpg": "e32c50bb66f515e83d2b0388fe33d32b",
"assets/assets/images/Cars/BMW_3.0_CSL.jpg": "756d4b1642cdc8d0801ca36f4b28cdee",
"assets/assets/images/Cars/BMW_507.jpg": "88067e930ee332e25c8d465bcb48b369",
"assets/assets/images/Cars/BMW_M3_GTS.jpg": "44ffa9b2cac763d955486d52f9397f90",
"assets/assets/images/Cars/BMW_M5_CS.jpg": "8a3f7da7b2a435b2b804c957bb85d8ed",
"assets/assets/images/Cars/BMW_Z8.jpg": "ec0050bad49cca4073480c46ae612171",
"assets/assets/images/Cars/bugatti.jpg": "38f0da0c86a5b185432a5829b5aba28b",
"assets/assets/images/Cars/Bugatti_Royale.jpg": "fb6c05ae82fcab63932a02ebd93894b8",
"assets/assets/images/Cars/Bugatti_Type_57_Atlantic.jpg": "6bf6e2da195c96903868c56ec8b9b579",
"assets/assets/images/Cars/Bugatti_Veyron.jpg": "984a1e29151c574c9527609e79aed0ed",
"assets/assets/images/Cars/BYD_Qin.jpg": "c82dc8ad68fb6a27f2ca31638cd29584",
"assets/assets/images/Cars/cadillac_escalade.jpg": "353de65706fe9079dcc5975fadfd1b57",
"assets/assets/images/Cars/cars_background.jpg": "f1d7b48a183ef48e07287f9b2fffc7ea",
"assets/assets/images/Cars/cars_thumbnail.png": "5a27133d51aa380136858ceba71d619c",
"assets/assets/images/Cars/Chevrolet_Camaro.jpg": "aab97b4c5a0b51374af2be8cd226e924",
"assets/assets/images/Cars/Chrysler_PT_Cruiser.jpg": "42eb6211bce053110af15c476e410066",
"assets/assets/images/Cars/Citroen_DS.jpg": "b9b45645c664ddefbe36bf4136f52af6",
"assets/assets/images/Cars/corvette.webp": "fb87da78539cf435b86009cd378a74ce",
"assets/assets/images/Cars/dacia_duster.jpg": "770e87d8f51b0f323d6a760079ee263e",
"assets/assets/images/Cars/Datsun_240Z.jpg": "969b7c293ac456f2eef36b56ebf29ed9",
"assets/assets/images/Cars/DeLorean_DMC.jpg": "a14305655741bbe552dba427ad565424",
"assets/assets/images/Cars/De_Tomaso_Mangusta.jpg": "fced622f07bfde543b45988e9c00821f",
"assets/assets/images/Cars/Dodge_Charger.jpg": "ef1e44a0cd94d424fe2b390f8c5544eb",
"assets/assets/images/Cars/Dodge_Ram.jpg": "6f5ebde2dfa57b2159a44a3f98228616",
"assets/assets/images/Cars/Dodge_Viper.jpg": "bf35268bed0258b29183f9af37559fd7",
"assets/assets/images/Cars/f1.webp": "cf7f32994bf2596e6cce872b5c5b3daa",
"assets/assets/images/Cars/Ferrari_250_GTO.jpg": "d2ababe9cec27ea22c037aa0c101036d",
"assets/assets/images/Cars/Ferrari_330_P3.jpg": "435ff6414651910562055af3e188e98d",
"assets/assets/images/Cars/Ferrari_F40.jpg": "bb9c8cdba01c56b8388a9d4d8825a1e0",
"assets/assets/images/Cars/fiat500.jpg": "719e6bfae02fc5ff45d64065852cdee3",
"assets/assets/images/Cars/Fiat_Multipla.jpg": "91fd1aa504ce53ebe233c0656240ca1c",
"assets/assets/images/Cars/Fisker_Karma.jpg": "b49a1e634969077d06a08177a41b6e72",
"assets/assets/images/Cars/Ford_GT.jpg": "7441386906d7ef773f982767e44b29b9",
"assets/assets/images/Cars/Ford_Model_T.jpg": "e2e891dabb71bb49451660032fe39e15",
"assets/assets/images/Cars/Ford_Shelby_GT350.jpg": "042261b1f2ca5077de315188b121db16",
"assets/assets/images/Cars/Honda_NSX.jpg": "d624c2789083fcaedccd4210f7edb08c",
"assets/assets/images/Cars/hummer_h1.jpg": "4bc36db9a804eaf461e3260d8062cf1a",
"assets/assets/images/Cars/Hyundai_Ioniq_5.jpg": "9535401deba25891dfedbbface5765a4",
"assets/assets/images/Cars/jaguar.webp": "231280bb5bc1c4f7ab9f20fbab7e0072",
"assets/assets/images/Cars/Jaguar_E-Type.jpg": "d4b8a552741acd0dcb91e787f5b1bb5e",
"assets/assets/images/Cars/Jaguar_F_Type_SVR.jpg": "974f59d65e3780434b7b63690d1287e9",
"assets/assets/images/Cars/Jeep_Wrangler.jpg": "9c6321eb90ec50da9f1b4996dc99c8e8",
"assets/assets/images/Cars/koenigsegg.jpg": "c31832e8b4a4c46bbf73bef614407e66",
"assets/assets/images/Cars/LaFerrari.jpg": "f294d9a02575245079083d63dd809f5c",
"assets/assets/images/Cars/Lamborghini_Countach.jpg": "791b3c024bf592e007ecd01ec80a2f53",
"assets/assets/images/Cars/Lamborghini_Miura.jpg": "01ecaaa999ce9be4ebb839f15cc5e84b",
"assets/assets/images/Cars/Lamborghini_Murcielago.webp": "e5eedc732b833188f85ed65ed2e18cc2",
"assets/assets/images/Cars/Lancia_Stratos.jpg": "f4d16de01b41cd6ed182ee7e156a51e3",
"assets/assets/images/Cars/landrover.jpg": "3f8e42d5da961e38286ca28710091bb9",
"assets/assets/images/Cars/LexusLFA.jpg": "cec3e99306698d7f6fddc9c5a50eeaf6",
"assets/assets/images/Cars/Lexus_LC500.jpg": "61d67a2cab9df4a6734dfb5b2fd2257b",
"assets/assets/images/Cars/LICENSE.txt": "a7bc05277dc64380299876b8df5b8ada",
"assets/assets/images/Cars/London-Taxi_LTI_TX1.jpg": "b15c0d3a34ddb5c9b7fbc2c348279c2a",
"assets/assets/images/Cars/Lucid_Air.jpg": "9f91ed30a8762674f04b9817825bec85",
"assets/assets/images/Cars/Maserati_A6GCS.jpg": "0cf8486e1751c411f2e4603940bbc85b",
"assets/assets/images/Cars/Maserati_Ghibli.jpg": "90bc5d001b83e58e3d42a4b6c2e839c3",
"assets/assets/images/Cars/Maybach_62_S.jpg": "f35c396155195287283883be4c2d2117",
"assets/assets/images/Cars/mazda.jpg": "7c92f9bcdf2109acff4f7972e7571fa9",
"assets/assets/images/Cars/McLaren.jpg": "c216360f91988016b8c0531813fd4b1e",
"assets/assets/images/Cars/McLaren_F1.jpg": "c3a8bf190c16c9f84860137a200903cb",
"assets/assets/images/Cars/McMurtry_Speirling.jpg": "2f2280a2907f9233fe750f2064a6500d",
"assets/assets/images/Cars/Mercedes-AMG_GT_R.webp": "a7bdd444e42b3af4239157f41c279e2a",
"assets/assets/images/Cars/Mercedes-Benz_600.jpg": "e334ec913e71d00637e362560d98bfd2",
"assets/assets/images/Cars/Mercedes-Benz_SLS_Electric_Drive.jpg": "95c1b6e04aeece7f6b0715721a7bf290",
"assets/assets/images/Cars/Mercedes_300_SL.JPG": "27820e2c4cfe65f721178c05d8e653af",
"assets/assets/images/Cars/Mercedes_G_6x6.webp": "09342e4d9e17bb762cb715e34f6ee497",
"assets/assets/images/Cars/Mini.jpg": "01825b778f4ae4bce48fcdfd86448fe0",
"assets/assets/images/Cars/Mitsubishi_Evo.jpg": "794f8e3ca4753ff476f0de330c7deec7",
"assets/assets/images/Cars/nissan.jpg": "18095d11f9e1f20f5ccd1293e4f7b43c",
"assets/assets/images/Cars/Nissan350Z.jpg": "0a740bb5322f7db51d1ac0461dbfa617",
"assets/assets/images/Cars/opelManta.jpg": "91c99401543a794b678567d8277779c2",
"assets/assets/images/Cars/Peel_P50.jpg": "bdce1346e92da497fbbe3a993233347d",
"assets/assets/images/Cars/Plymouth_Voyager.jpg": "3e35ded725c5c461512b2e8732b3351c",
"assets/assets/images/Cars/Pontiac_Firebird.jpg": "b645099df232d65ce48d4d10beb4a91b",
"assets/assets/images/Cars/porsche911.jpg": "afc64c1f6049123c629f20338d317f47",
"assets/assets/images/Cars/porsche959.jpg": "809a471ad35b46860be6b0163818cc58",
"assets/assets/images/Cars/Porsche_964_Turbo.jpg": "be6b6c25ef363e9a9b55c594c00742fe",
"assets/assets/images/Cars/Porsche_Cayenne.jpg": "0bc37948a25ba333c14248a54fe288b7",
"assets/assets/images/Cars/Porsche_Taycan.webp": "85cfe15c1cfe9ff42e88a220dd3a8835",
"assets/assets/images/Cars/Range_Rover.jpg": "7b39ce56754eb26f6ff1677e0e6f81b0",
"assets/assets/images/Cars/renault.jpg": "ae4b4e6c96480ff32c771033e4994711",
"assets/assets/images/Cars/RimacNevera.jpg": "9af623bc544279d3bb742a22857d6fb3",
"assets/assets/images/Cars/Rivian_R1T.jpg": "93a0953026a5ea7038d746b2056dd1e0",
"assets/assets/images/Cars/Rolls-Royce_Ghost.webp": "7c5b8e9d96a61037daa35455738f18b0",
"assets/assets/images/Cars/Saab_900_Turbo.jpg": "512899985536d2fee1b5a7e8c0a39cca",
"assets/assets/images/Cars/Seat_Leon_2012.jpg": "80e77a417ce2fabbc9374a486540cee3",
"assets/assets/images/Cars/Shelby_427_Cobra.jpg": "b3222130966de6fa332d9589431ef6f4",
"assets/assets/images/Cars/Skoda_Octavia.jpg": "9181a674535f84735f79d1a84ec60c85",
"assets/assets/images/Cars/smart.webp": "bc272b9add9da05befdc0c885694e1fe",
"assets/assets/images/Cars/Subaru_Sambar.jpg": "ca335d6fe563edad5759b5e8a165afa2",
"assets/assets/images/Cars/tata-nano.JPG": "d1dae4d4312775f73138d9b4098976f4",
"assets/assets/images/Cars/tesla-plaid.jpg": "a704dd766ae8cdf78920cb879701f9ac",
"assets/assets/images/Cars/Tesla_Cybertruck.jpg": "c4273af7501087cada8c840e3160d843",
"assets/assets/images/Cars/Tesla_Roadster.jpg": "48ff752c333dc86536bd52cc695faeca",
"assets/assets/images/Cars/ThrustSSC.jpg": "cf7da3d336d2e82074ccdabe47d3970a",
"assets/assets/images/Cars/Toyota_Land_Cruiser_70.jpg": "91a92f8fa066d9e7d2105659b4eb9ed8",
"assets/assets/images/Cars/Toyota_Mirai.jpg": "4519887ae83846775c1f6843e5716b7e",
"assets/assets/images/Cars/Toyota_Supra.jpg": "39929ef07fb178c538088557b200af59",
"assets/assets/images/Cars/Vector_W8.jpg": "21526b3b93efaad9a10dcfefe9ac6b97",
"assets/assets/images/Cars/vw-golf.jpg": "2b5d68dada76cc2abeb54fce83e05e47",
"assets/assets/images/Cars/vw-t6.jpg": "65a01c11b26c5fbadcf220c8d9d5664f",
"assets/assets/images/Cars/VW_Kaefer.jpg": "b04189349282ffbab3f29d7056e0c73f",
"assets/assets/images/Cars/Wiesmann.jpg": "5b3f5e159ed8a2635f5cd8fc4c588dc9",
"assets/assets/images/Cars/Xiaomi_SU7_Ultra.jpg": "fb5ca432d662b33495019ba5700abacb",
"assets/assets/images/Cars/Zenvo_ST1.jpg": "5d28bd8e07f38aa17babe6ea0a0251cf",
"assets/assets/images/colored.jpg": "cfe37eae7ab5152e6c40df3787aaa47e",
"assets/assets/images/dinosaurs/dinosaurs_background.jpg": "0946cbbab70fe03dbea63a0d54df0294",
"assets/assets/images/dinosaurs/dinosaurs_thumbnail.png": "206f8656ea1e8d90842b64c520334b9b",
"assets/assets/images/extremeSports/extremeSports_background.jpg": "6d13558795f7f075447ff83c2f23ba35",
"assets/assets/images/extremeSports/extremeSports_thumbnail.png": "1f569ed930063fac41edab3d9d48b23f",
"assets/assets/images/flutter_logo.png": "478970b138ad955405d4efda115125bf",
"assets/assets/images/galaxy.jpg": "2e850fc6ebd47394133caf506aba2504",
"assets/assets/images/game-over.png": "288b35a01eb7845261a8740309d5854e",
"assets/assets/images/megaCities/megaCities_background.jpg": "5f2f00a0289092f0a614458eaa2c3a57",
"assets/assets/images/megaCities/megaCities_thumbnail.png": "3dd6852b69335eaee9b01713d8ede7f1",
"assets/assets/images/paper.png": "5962011d4e04868306ff89b85f7a0db7",
"assets/assets/images/placeholder.png": "ea52ec10580e866f138fd60d0c06e5e2",
"assets/assets/images/Rockets/Angara-A5.jpg": "ffbebf03b697d3beae49779be05b22e0",
"assets/assets/images/Rockets/Antares.jpg": "fbda609d582bb35635d0dcfa281ab460",
"assets/assets/images/Rockets/Ariane_1.jpg": "6ed6c270f4c7d9015c8bacd77703a6ad",
"assets/assets/images/Rockets/Ariane_5.jpg": "07245f5104b5b0d613d29c9b2ac5a4c3",
"assets/assets/images/Rockets/Ariane_6.jpg": "0ca1fc7b3dcd65ae3f147aecb1d1c6a5",
"assets/assets/images/Rockets/Atlas_III.jpg": "eb4d8216bc7d0f9048314101da887665",
"assets/assets/images/Rockets/Atlas_V.jpg": "fa437ff9b34b312b7af10fde52b75b2a",
"assets/assets/images/Rockets/black_arrow.JPG": "a30cbf5ebbd9ca9a4fc57aa1e2633c89",
"assets/assets/images/Rockets/Changzheng-1.jpg": "45affbe40181868711a4c223c1c8d8dd",
"assets/assets/images/Rockets/Cyclone-3.jpg": "be6c60c8a70de06f9104a93bd1532351",
"assets/assets/images/Rockets/Delta_II.jpg": "2081fd4a87fb46e5d6a902066042d5e8",
"assets/assets/images/Rockets/Delta_IV_Heavy.jpg": "3fe59f96427b89375f91326a1f05766e",
"assets/assets/images/Rockets/Diamant.jpg": "d1cd9168aacd5dfea31a84515fbc70a3",
"assets/assets/images/Rockets/electron.jpg": "a432f863ad9a8be5eae70b571751b23c",
"assets/assets/images/Rockets/energia.JPEG": "b21bab3610020562d538b22eea220b33",
"assets/assets/images/Rockets/Falcon_1.jpg": "6d3f611caba9714a4ad81f04f7ca83e8",
"assets/assets/images/Rockets/Falcon_9_1.jpg": "19b47aaa62d172923d2ae412aa6fe5dc",
"assets/assets/images/Rockets/Falcon_9_Block_5.jpg": "d310f488d3acf1cba49ba240247b2b05",
"assets/assets/images/Rockets/Falcon_Heavy.jpg": "0688b44d436926f9447393119a28c95e",
"assets/assets/images/Rockets/Firefly_Alpha.jpg": "ea477e04577c4fc817ffbc0fd7e73e5b",
"assets/assets/images/Rockets/GSLV-F10.jpg": "ee4b9c4d3d61dae963a2540062d720b0",
"assets/assets/images/Rockets/H-IIA.jpg": "6d253f2338a4b12c5db9f87ab7da8cbe",
"assets/assets/images/Rockets/Juno_I.jpg": "1c2e12d09adfd052c5c5478ce2893f1a",
"assets/assets/images/Rockets/LICENSE.txt": "0f1313e90458ef84d0da4d91736d3e65",
"assets/assets/images/Rockets/Long_March.jpg": "86d6d881d7d73dd1efe3209c60238cd8",
"assets/assets/images/Rockets/Long_March_2D.jpg": "21259bedc6e8a3d7263bd65a1ebd756b",
"assets/assets/images/Rockets/Long_March_3B.jpg": "242eccffcc58d094613fcb62affa2b46",
"assets/assets/images/Rockets/Long_March_5.jpg": "3514b096ee9af16a36c24980c4b0f6b2",
"assets/assets/images/Rockets/LVM3.jpg": "454189f33144b68aed37ace64b90d733",
"assets/assets/images/Rockets/Molniya.jpg": "ea71c0821b049b1f52a97ceedd22fe57",
"assets/assets/images/Rockets/N1.jpg": "630f5c9c4e333a8acba55e2cb18f28d3",
"assets/assets/images/Rockets/New_Shepard.jpg": "f33e31f1f146f4547d972a868a3c181c",
"assets/assets/images/Rockets/Pegasus.jpg": "decc38505672cdd1910df4061084bedb",
"assets/assets/images/Rockets/Proton-K.jpg": "c9cd6069f79b5143e757f037e32f01f3",
"assets/assets/images/Rockets/PSLV_C45_EMISAT_campaign_22.jpg": "b0273cf92bca4c26f5f8ae96fe0b6383",
"assets/assets/images/Rockets/rockets_background.jpg": "7f1cd58775cc61761616502dd924a288",
"assets/assets/images/Rockets/rockets_thumbnail.png": "d6222f733cdfafe486d9fe8fcca8e2e5",
"assets/assets/images/Rockets/Saturn_IB.jpg": "bfbecf925f1a9d5e2df2db94c595416b",
"assets/assets/images/Rockets/Saturn_SA5.jpg": "677c8c810cdaef4137f4e2ea84cac941",
"assets/assets/images/Rockets/Saturn_V.jpg": "af9827c8f8f7ff7ed8dc660bc1bbc8a8",
"assets/assets/images/Rockets/SLS_Block_1.jpg": "e7990beb2d1f0ae0db30b1a6ae2448e8",
"assets/assets/images/Rockets/Soyuz.jpg": "8a213a76c8ded099d1ce8a8f4c19f744",
"assets/assets/images/Rockets/SpaceShipTwo.jpg": "f7a2464f6554f5c7078d50b612543589",
"assets/assets/images/Rockets/Space_Shuttle.jpg": "cd62f4641ea7893de66b885e6341b469",
"assets/assets/images/Rockets/Sputnik.jpg": "0f960ea729288bb5860e710d97e49e47",
"assets/assets/images/Rockets/starship.jpg": "a1f6493daec67336e96398b1ae834048",
"assets/assets/images/Rockets/The_V2_Rocket.jpg": "5f2b17f0dc69e8a3b869fdfd785b9e8f",
"assets/assets/images/Rockets/Thor-Agena_D.jpg": "c121bb9042e2f24888505530eb92bd08",
"assets/assets/images/Rockets/Titan_2.JPG": "cb46a820553416bc137ff58167c2f9dd",
"assets/assets/images/Rockets/Vega.jpg": "cf59e35d06911211185adbd51adbfddd",
"assets/assets/images/Rockets/vostok.jpg": "754295d8b0a15a07737481a60e904e2e",
"assets/assets/images/Rockets/Zenit-2.jpg": "9326261b93c2e30fbcb5f87e8cea83d6",
"assets/assets/images/thumbnail.png": "bea3714f499145799e37620356bd8b9a",
"assets/assets/images/trophy.png": "b6439747e33eec5ef89f3d0628211972",
"assets/assets/images/trump-cards-logo-shadow.png": "3bccf18d826a1407ef7b6a5e2ae5ba39",
"assets/assets/images/worldFootballStars/worldFootballStars_background.jpg": "c6eb19d3e03c685e01d2ac08fd1ff118",
"assets/assets/images/worldFootballStars/worldFootballStars_thumbnail.png": "e9a2010939b1c11990998b474ae1d057",
"assets/assets/images/worldTennisStars/worldTennisStars_background.jpg": "07f12b9a460891d87280324379e42693",
"assets/assets/images/worldTennisStars/worldTennisStars_thumbnail.png": "7dd58dc0b6b4137bf6c35b3c33b99a5b",
"assets/assets/translations/ar.json": "e025c699dd7d535057c49473f7cdb51e",
"assets/assets/translations/de.json": "cdec03eb720a60e539a04f7bdeac0795",
"assets/assets/translations/en.json": "3d9a59d0744abd11ed80049451a6af3a",
"assets/assets/translations/es.json": "1eaca94181cddd1eb1bda46d0477c14b",
"assets/assets/translations/fr.json": "797bd227cbb86eb4f1ad94e3cbf0f395",
"assets/assets/translations/hi.json": "dd1032df354291e45c685d862cf96ee6",
"assets/assets/translations/it.json": "a1cd06440ace59ea02165afce587d365",
"assets/assets/translations/ja.json": "0fd6a17a4565852cd70c25f6ed7db752",
"assets/assets/translations/ko.json": "0f4e473e415db74fc4b2d877cc2d61d2",
"assets/assets/translations/pt.json": "4cbcd4dcf7774cf0c452c3cf86807d0c",
"assets/assets/translations/ru.json": "8dbfb3ee5302cdc5d7a36ade6994461b",
"assets/assets/translations/zh.json": "8d6b0f0d84564987e95cee0fd99c2783",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "c481772facd23e502bec17b41e4a0d54",
"assets/NOTICES": "134205d96491678cde17030415a2c978",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon-16.png": "9c01e90db0eb1ea06c3e3511b529646f",
"favicon-32.png": "247006ed394aaa5d0ad58dc59bc802db",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "f04b249f59247faf5dbde1bbb2001b83",
"icons/Icon-180.png": "280d7d97b076089b152f9ecf74be5700",
"icons/Icon-192.png": "fe16176f405d241cf5a7ac281080471d",
"icons/Icon-512.png": "e79e77bb9ba6881cba18c972cb4bbadb",
"icons/Icon-maskable-192.png": "5f793511d6c9acada0b766143effcd29",
"icons/Icon-maskable-512.png": "1188059251deacacdbd3b10c0da558a3",
"index.html": "21add91ca34cd48b6b5c5f5460a018e0",
"/": "21add91ca34cd48b6b5c5f5460a018e0",
"main.dart.js": "d168593753b3280a8bce9b5f8b64bf05",
"manifest.json": "8bf4d3d6a9d4d3cbb837b53fe8c3a5b2",
"version.json": "6f8b14319879677a3e8675b49d804544"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
