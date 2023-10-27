'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4b313132e25fa2e11da2060764bd1876",
"assets/AssetManifest.json": "7a05791a9083c512f6cbddcf197350c4",
"assets/assets/images/2.0x/flutter_logo.png": "4efb9624185aff46ca4bf5ab96496736",
"assets/assets/images/3.0x/flutter_logo.png": "b8ead818b15b6518ac627b53376b42f2",
"assets/assets/images/Airplanes/Aerospatiale-BAC_Concorde.jpg": "f8d3e171bb7e22b14f7496d9d205609c",
"assets/assets/images/Airplanes/Aerospatiale-BAC_Concorde.jpg.Attribution.txt": "b16550d8c19d75db2c42ce88f9f01115",
"assets/assets/images/Airplanes/Airbus_A300B1.jpg": "9c5738ef10b0da035d47e629fb00b8f4",
"assets/assets/images/Airplanes/Airbus_A300B1.jpg.Attribution.txt": "4713370941a3f43bb91c2566e735f251",
"assets/assets/images/Airplanes/Airbus_A310-200.jpg": "decec294c3f5e23e812024a3a43c7376",
"assets/assets/images/Airplanes/Airbus_A310-200.jpg.Attribution.txt": "115a4c1651670d95201766e9556a12cf",
"assets/assets/images/Airplanes/Airbus_A318.jpg": "8d9ee3a22c0d5d1ce952bf2678f2209a",
"assets/assets/images/Airplanes/Airbus_A318.jpg.Attribution.txt": "579977f365928d473c91c0ffcc8915d3",
"assets/assets/images/Airplanes/Airbus_A319neo.jpg": "e17c76b1dd423875a62859d188b792e1",
"assets/assets/images/Airplanes/Airbus_A319neo.jpg.Attribution.txt": "a922d8ff141bad2cdecb4912ee3f86bb",
"assets/assets/images/Airplanes/Airbus_A320neo.jpg": "439f06e144794e871f90a218e22e801e",
"assets/assets/images/Airplanes/Airbus_A320neo.jpg.Attribution.txt": "13d668559a04b9ea0f133d7935e73c2d",
"assets/assets/images/Airplanes/Airbus_A321neo.jpg": "86ec50ecf1ab98cc6ad8c0b3f0e9a1a8",
"assets/assets/images/Airplanes/Airbus_A321neo.jpg.Attribution.txt": "8d8794dbd2630f7f0968f07d5693258d",
"assets/assets/images/Airplanes/Airbus_A330-900.jpg": "37b98eb6d5713f0614170efbf975ad89",
"assets/assets/images/Airplanes/Airbus_A330-900.jpg.Attribution.txt": "238967dec014961333cd2bd4317309d6",
"assets/assets/images/Airplanes/Airbus_A340-600.jpg": "cbfd1c62bc8ba579a02213554318409c",
"assets/assets/images/Airplanes/Airbus_A340-600.jpg.Attribution.txt": "fbdad9b540aa05eebf276e2850d3f3b7",
"assets/assets/images/Airplanes/Airbus_A350-1000.jpg": "10fd205cd02efdcb0892430dbaaaad56",
"assets/assets/images/Airplanes/Airbus_A350-1000.jpg.Attribution.txt": "48376a8c5844b5f872d9a10ed6b8f37d",
"assets/assets/images/Airplanes/Airbus_A380.jpg": "e9226ea80990921a64327866c6b8aae1",
"assets/assets/images/Airplanes/Airbus_A380.jpg.Attribution.txt": "37421c760a984c783d2b5fe7da902563",
"assets/assets/images/Airplanes/Airbus_A400M.jpg": "d6f68629c9cb28eb8fe0d6062cf57ed5",
"assets/assets/images/Airplanes/Airbus_A400M.jpg.Attribution.txt": "fbdad9b540aa05eebf276e2850d3f3b7",
"assets/assets/images/Airplanes/Airbus_Beluga.jpg": "3c61882cbd2a065e172a393c8ed2594e",
"assets/assets/images/Airplanes/Airbus_Beluga.jpg.Attribution.txt": "f1b3a454bc51094f9c125e2a68fa3c8a",
"assets/assets/images/Airplanes/Antonov_An-225.jpg": "3a71c4010206fb2aea933daf51b201ab",
"assets/assets/images/Airplanes/Antonov_An-225.jpg.Attribution.txt": "9d413b5c782db0958e93959084724c79",
"assets/assets/images/Airplanes/background.jpg": "9200277390a6986bfb015294e3b8b3f8",
"assets/assets/images/Airplanes/Bell_Boeing_CV-22B_Osprey.jpg": "e0e65c7a2e55abf43783737e8c501fc3",
"assets/assets/images/Airplanes/Bell_Boeing_CV-22B_Osprey.jpg.Attribution.txt": "3564008d52fd990f5ce363a6630f12ba",
"assets/assets/images/Airplanes/Bell_X-1.jpg": "dafc50803158a4a1109840d8f74b2208",
"assets/assets/images/Airplanes/Bell_X-1.jpg.Attribution.txt": "1c04353b29d643ad69b5a600730a01c6",
"assets/assets/images/Airplanes/Bleriot.jpg": "48bde33096355ab864d92c3722108941",
"assets/assets/images/Airplanes/Bleriot.jpg.Attribution.txt": "97d857592e9b9b72d37ea934333135a9",
"assets/assets/images/Airplanes/Boeing_707.jpg": "d115a7ba3139b493c95b8fb9b68f1ad0",
"assets/assets/images/Airplanes/Boeing_707.jpg.Attribution.txt": "779acf07e02f11b4e731a243b67f535b",
"assets/assets/images/Airplanes/Boeing_727.jpg": "d2c769e6ffdad2287634d5e5dffa11f9",
"assets/assets/images/Airplanes/Boeing_727.jpg.Attribution.txt": "2ead796b361d30a0f24ddb765dad6e78",
"assets/assets/images/Airplanes/Boeing_737-9_MAX.jpg": "610518ec156b0dcfa5c2a6b13a618a44",
"assets/assets/images/Airplanes/Boeing_737-9_MAX.jpg.Attribution.txt": "bfa5aaeb430ff73ee8887e4365b9cd33",
"assets/assets/images/Airplanes/Boeing_747-8.jpg": "191e38d60879ccf2bfc971a44e6058d3",
"assets/assets/images/Airplanes/Boeing_747-8.jpg.Attribution.txt": "cba686a1278b279122b97bda73ebfc91",
"assets/assets/images/Airplanes/Boeing_757.jpg": "41b956c5d47dfc21a57f33bfd529de95",
"assets/assets/images/Airplanes/Boeing_757.jpg.Attribution.txt": "9d6982ed72bf645d8815bb5ceb6da3c0",
"assets/assets/images/Airplanes/Boeing_767-200.jpg": "0d95a9e22d9c5f55a9943cb5ce53af3e",
"assets/assets/images/Airplanes/Boeing_767-200.jpg.Attribution.txt": "4f25f1a140fa92d965c939108552b5af",
"assets/assets/images/Airplanes/Boeing_77-300.jpg": "65c303552e2d21d7af873c15c7ccb23f",
"assets/assets/images/Airplanes/Boeing_77-300.jpg.Attribution.txt": "4f25f1a140fa92d965c939108552b5af",
"assets/assets/images/Airplanes/Boeing_787.jpg": "0ae681936e734d94afb2509f6b772078",
"assets/assets/images/Airplanes/Boeing_787.jpg.Attribution.txt": "ed29cffc990e5cf9483245bb8a8cbb73",
"assets/assets/images/Airplanes/Boeing_B-29.jpg": "9ad43476afe13df075c69aed9cd6ddad",
"assets/assets/images/Airplanes/Boeing_B-29.jpg.Attribution.txt": "63430882f142c85397b61ebbec56a2e4",
"assets/assets/images/Airplanes/Boeing_B-52.jpg": "2659246b0200b877c5decdb1dd42e6b2",
"assets/assets/images/Airplanes/Boeing_B-52.jpg.Attribution.txt": "da67426c451b1501cd16d13380e26fd1",
"assets/assets/images/Airplanes/Boeing_C-17.jpg": "496fd929004716a873b2f45b8c863370",
"assets/assets/images/Airplanes/Boeing_C-17.jpg.Attribution.txt": "22aa9071587e84f6b4fc7aa65fdc55af",
"assets/assets/images/Airplanes/Bombardier_CRJ-100.jpg": "f27e826faf00d77e740e2ebfc3ace095",
"assets/assets/images/Airplanes/Bombardier_CRJ-100.jpg.Attribution.txt": "579977f365928d473c91c0ffcc8915d3",
"assets/assets/images/Airplanes/Cessna_172.jpg": "06107cb33c2b2e3beaae3ecc5f90c656",
"assets/assets/images/Airplanes/Cessna_172.jpg.Attribution.txt": "6153d4d649153646bc3abc6200eab17c",
"assets/assets/images/Airplanes/Cessna_Citation.jpg": "77a5ecc730fbc4d2fe9baae1bbe4a99c",
"assets/assets/images/Airplanes/Cessna_Citation.jpg.Attribution.txt": "492e607d986b6c00a1f71c31dba24c5e",
"assets/assets/images/Airplanes/COMAC_C919.jpg": "902abb5943727ad0ce66780dc6bb672d",
"assets/assets/images/Airplanes/COMAC_C919.jpg.Attribution.txt": "9eba282a5d9cdbf8706804880aee5d37",
"assets/assets/images/Airplanes/Dassault_Falcon_7X.jpg": "c7836c9d3a497bc8238d66c08beecc9b",
"assets/assets/images/Airplanes/Dassault_Falcon_7X.jpg.Attribution.txt": "34564f5c87e7c5db987ea046c509e834",
"assets/assets/images/Airplanes/De_Havilland_Canada_DHC-8-400.jpg": "4337ca44de9c7446c226f9ca6c4bfcfc",
"assets/assets/images/Airplanes/De_Havilland_Canada_DHC-8-400.jpg.Attribution.txt": "a5badf29ae73a1b1415f13f05e392a10",
"assets/assets/images/Airplanes/DH_Comet.jpg": "84c228fce19819a273eff4f17ec56682",
"assets/assets/images/Airplanes/DH_Comet.jpg.Attribution.txt": "ceb51050424f34c95828f22b81af89d4",
"assets/assets/images/Airplanes/Dornier_Do-X.jpg": "31e8e557e746d5c3f1a62ae0a7659ff0",
"assets/assets/images/Airplanes/Dornier_Do-X.jpg.Attribution.txt": "c4c94337285fc865e630b900d1c8b71c",
"assets/assets/images/Airplanes/Douglas_DC-3.JPG": "7218694e804f4f05b4794877fd6c6138",
"assets/assets/images/Airplanes/Douglas_DC-3.JPG.Attribution.txt": "30a39a8523f31e4d3d0c57f9753a5ed3",
"assets/assets/images/Airplanes/Embraer_E-Jet.jpg": "597449cbf3ad8620f1391be10e1f52d5",
"assets/assets/images/Airplanes/Embraer_E-Jet.jpg.Attribution.txt": "5fac18215700f71801f8d65d67e3c6db",
"assets/assets/images/Airplanes/Eurofighter_Typhoon.jpg": "de4e16c25b22d79e1598de7a2fd91cc0",
"assets/assets/images/Airplanes/Eurofighter_Typhoon.jpg.Attribution.txt": "22271872a5270d1d449bfdb299583643",
"assets/assets/images/Airplanes/F-22.jpg": "c91a23d8b2122edd83688676647daeb4",
"assets/assets/images/Airplanes/F-22.jpg.Attribution.txt": "2d3f9ead29085beb21731333630706da",
"assets/assets/images/Airplanes/Gulfstream_G600.jpg": "82f4391bee5eb02999f5e7f639503389",
"assets/assets/images/Airplanes/Gulfstream_G600.jpg.Attribution.txt": "a7e7990d3c8cb99ca94859d6b23bdcb5",
"assets/assets/images/Airplanes/Iljuschin_Il-62.jpg": "1a82beda79a2d65b6927142c7f63fbc7",
"assets/assets/images/Airplanes/Iljuschin_Il-62.jpg.Attribution.txt": "a5d8181909203bff5cc43d970ba36bd1",
"assets/assets/images/Airplanes/Iljuschin_Il-96.jpg": "4be653bfb9cd3f42a7e95aafa61e2dac",
"assets/assets/images/Airplanes/Iljuschin_Il-96.jpg.Attribution.txt": "22271872a5270d1d449bfdb299583643",
"assets/assets/images/Airplanes/Ju52.JPG": "98fd0389206ebb13bee33a665568a08f",
"assets/assets/images/Airplanes/Ju52.JPG.Attribution.txt": "d05e22ba5c25e43176dd02d7e7344e9b",
"assets/assets/images/Airplanes/Learjet_23.jpg": "d6d66839214f2e2db014e9246ff3580c",
"assets/assets/images/Airplanes/Learjet_23.jpg.Attribution.txt": "3b8fbac73940c24131c14bb8ef2e3931",
"assets/assets/images/Airplanes/MD-11.JPG": "81bd395e062b23a37f1c68fad7d39d67",
"assets/assets/images/Airplanes/MD-11.JPG.Attribution.txt": "fce4a1499d67aa3d1ca7da7231e606ca",
"assets/assets/images/Airplanes/Messerschmitt_Me-262.jpg": "c71d48cb08d4e0db3d341c4733f098d5",
"assets/assets/images/Airplanes/Messerschmitt_Me-262.jpg.Attribution.txt": "f749e9d8921b77a66401b35fd33bbb40",
"assets/assets/images/Airplanes/MiG-21.jpg": "36c06cc7ddab5a7284abb21870c3a98b",
"assets/assets/images/Airplanes/MiG-21.jpg.Attribution.txt": "b3e558e5db796820dd15c3938b4250e3",
"assets/assets/images/Airplanes/Spirit_of_St._Louis.jpg": "8a7b9cb662153e57c31d301c428edf1b",
"assets/assets/images/Airplanes/Spirit_of_St._Louis.jpg.Attribution.txt": "be12fc62bc2a48d685d8a23b9529a732",
"assets/assets/images/Airplanes/Spitfire.jpg": "bc622e8bda30896c09a43251eba2d840",
"assets/assets/images/Airplanes/Spitfire.jpg.Attribution.txt": "0c9d9a3ac0669ec4f22b9008f8455470",
"assets/assets/images/Airplanes/SR-71.jpg": "d39e1247d19f51f842497f36f85fac15",
"assets/assets/images/Airplanes/SR-71.jpg.Attribution.txt": "51255f3d874e21a7f72b0e622ce80598",
"assets/assets/images/Airplanes/Tupolev_Tu-104.jpg": "85e02c93a235a66641d2d48f58582be3",
"assets/assets/images/Airplanes/Tupolev_Tu-104.jpg.Attribution.txt": "cdefa333175be0d36716e74ce1ab5c05",
"assets/assets/images/Airplanes/Tupolev_Tu-144.jpg": "00653d1e00edd7d935fa77c1bdbea501",
"assets/assets/images/Airplanes/Tupolev_Tu-144.jpg.Attribution.txt": "b16550d8c19d75db2c42ce88f9f01115",
"assets/assets/images/Airplanes/Tupolev_Tu-154.jpg": "103ad9d8748119dd5bd0af96486b183e",
"assets/assets/images/Airplanes/Tupolev_Tu-154.jpg.Attribution.txt": "22271872a5270d1d449bfdb299583643",
"assets/assets/images/Airplanes/Tupolev_Tu-95.jpg": "1ea628a82a7381e1dc4b00cf11be4649",
"assets/assets/images/Airplanes/Tupolev_Tu-95.jpg.Attribution.txt": "63430882f142c85397b61ebbec56a2e4",
"assets/assets/images/Airplanes/wright-flyer.jpg": "6e08f05fad5fcc366007e1933bcbb8fb",
"assets/assets/images/Cars/AR8C-Competizione.jpg": "51a708b6f14a0cb9e0e3abf84bad2eaa",
"assets/assets/images/Cars/AR8C-Competizione.jpg.Attribution.txt": "90b7c8d63d35958a451f5de76e056d14",
"assets/assets/images/Cars/aston-martin-one-77.jpg": "9d402752b28d00f9e39c02a46c281183",
"assets/assets/images/Cars/aston-martin-one-77.jpg.Attribution.txt": "e468acab1073794fb12fc409a8a8ac3f",
"assets/assets/images/Cars/Aston_Martin_DB5_Vantage.jpg": "1561bb0426960ffb73e95d57895fa18d",
"assets/assets/images/Cars/Aston_Martin_DB5_Vantage.jpg.Attribution.txt": "72261d69f77ace3a772bf619849f7d6e",
"assets/assets/images/Cars/Aston_Martin_V8_Vantage.jpg": "8fce3fffb178ef04a1fad5ae2d43653e",
"assets/assets/images/Cars/Aston_Martin_V8_Vantage.jpg.Attribution.txt": "4521b622be5c0add58032ba50e7e3c60",
"assets/assets/images/Cars/audi_Q8_e-tron.jpg": "d8d92628fed038235f77ae29f239e814",
"assets/assets/images/Cars/audi_Q8_e-tron.jpg.Attribution.txt": "bcba7a0932cfc3e98caf738e423cc8c7",
"assets/assets/images/Cars/audi_quattro.jpg": "a94c47baa4ca87d1e900eaf6425b3f09",
"assets/assets/images/Cars/audi_quattro.jpg.Attribution.txt": "986392cada5f1563a90cb884534f17e0",
"assets/assets/images/Cars/Audi_R18_e-tron_quattro.jpg": "05212ea912a39f5e3273f0ff2497876e",
"assets/assets/images/Cars/Audi_R18_e-tron_quattro.jpg.Attribution.txt": "a3bae2ada257910f14bbb6786db235ca",
"assets/assets/images/Cars/background.jpg": "f1d7b48a183ef48e07287f9b2fffc7ea",
"assets/assets/images/Cars/belAir.jpg": "94cbd08c7bb657a20d1114b27aa7f42a",
"assets/assets/images/Cars/belAir.jpg.Attribution.txt": "93b393b7b1eef82fef0dee1e7fb3273c",
"assets/assets/images/Cars/Bentley_Continental_GT.jpg": "8e51f6e8d7a9c9b9d37c2ceecb984dc1",
"assets/assets/images/Cars/Bentley_Continental_GT.jpg.Attribution.txt": "9fd1157b63206d800bd3a2826d906364",
"assets/assets/images/Cars/Benz-Patent-Motorwagen.jpg": "38856d5ae3e669b6cd2634a15ffdd694",
"assets/assets/images/Cars/Benz-Patent-Motorwagen.jpg.Attribution.txt": "fce4a1499d67aa3d1ca7da7231e606ca",
"assets/assets/images/Cars/BMWi3.jpg": "d62999288f17bd5d81333e09e40675ec",
"assets/assets/images/Cars/BMWi3.jpg.Attribution.txt": "b70de312a7fd1b8db6e63a0f1ae822fb",
"assets/assets/images/Cars/BMW_2002_Turbo.jpg": "e32c50bb66f515e83d2b0388fe33d32b",
"assets/assets/images/Cars/BMW_2002_Turbo.jpg.Attribution.txt": "ab339ade54f5d5dec835b7b1f102b4ba",
"assets/assets/images/Cars/BMW_507.jpg": "88067e930ee332e25c8d465bcb48b369",
"assets/assets/images/Cars/BMW_507.jpg.Attribution.txt": "019e3de904dc4f46d6de525009beda9f",
"assets/assets/images/Cars/BMW_M1.jpg": "c3f1a790182067b55ed5af33efbe15f6",
"assets/assets/images/Cars/BMW_M1.jpg.Attribution.txt": "6153d4d649153646bc3abc6200eab17c",
"assets/assets/images/Cars/BMW_M3_GTS.jpg": "44ffa9b2cac763d955486d52f9397f90",
"assets/assets/images/Cars/BMW_M3_GTS.jpg.Attribution.txt": "5fed015e207166a51951f2c0238d3dca",
"assets/assets/images/Cars/bugatti.jpg": "38f0da0c86a5b185432a5829b5aba28b",
"assets/assets/images/Cars/bugatti.jpg.Attribution.txt": "69b999a8f680524b379fe804b5ec319d",
"assets/assets/images/Cars/BYD_Qin.jpg": "c82dc8ad68fb6a27f2ca31638cd29584",
"assets/assets/images/Cars/BYD_Qin.jpg.Attribution.txt": "49447909cf706a905a5e819f041404df",
"assets/assets/images/Cars/cadillac_escalade.jpg": "353de65706fe9079dcc5975fadfd1b57",
"assets/assets/images/Cars/cadillac_escalade.jpg.Attribution.txt": "292b840edaa4002e0458e48fd04406ef",
"assets/assets/images/Cars/Chevrolet_Camaro.jpg": "aab97b4c5a0b51374af2be8cd226e924",
"assets/assets/images/Cars/Chevrolet_Camaro.jpg.Attribution.txt": "71b3cc67b4e431c5009e604958dde856",
"assets/assets/images/Cars/Citroen_DS.jpg": "b9b45645c664ddefbe36bf4136f52af6",
"assets/assets/images/Cars/Citroen_DS.jpg.Attribution.txt": "fce4a1499d67aa3d1ca7da7231e606ca",
"assets/assets/images/Cars/corvette.webp": "fb87da78539cf435b86009cd378a74ce",
"assets/assets/images/Cars/corvette.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/dacia_duster.jpg": "770e87d8f51b0f323d6a760079ee263e",
"assets/assets/images/Cars/dacia_duster.jpg.Attribution.txt": "1b6b16901abca153ce58bb928f0ef610",
"assets/assets/images/Cars/DeLorean_DMC.jpg": "a14305655741bbe552dba427ad565424",
"assets/assets/images/Cars/DeLorean_DMC.jpg.Attribution.txt": "beab8a5c685b3df62477d2c3f3e1e906",
"assets/assets/images/Cars/Dodge_Ram.jpg": "6f5ebde2dfa57b2159a44a3f98228616",
"assets/assets/images/Cars/Dodge_Ram.jpg.Attribution.txt": "db3aba38cba5e8ea2429562f0e1176e3",
"assets/assets/images/Cars/f1.webp": "cf7f32994bf2596e6cce872b5c5b3daa",
"assets/assets/images/Cars/f1.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/Ferrari_F40.jpg": "bb9c8cdba01c56b8388a9d4d8825a1e0",
"assets/assets/images/Cars/Ferrari_F40.jpg.Attribution.txt": "5083ef432adca9b5490de9afe24aeb1a",
"assets/assets/images/Cars/fiat500.jpg": "719e6bfae02fc5ff45d64065852cdee3",
"assets/assets/images/Cars/fiat500.jpg.Attribution.txt": "94536f2c8e63571bd10f00bca675ba61",
"assets/assets/images/Cars/Fiat_Multipla.jpg": "91fd1aa504ce53ebe233c0656240ca1c",
"assets/assets/images/Cars/Fiat_Multipla.jpg.Attribution.txt": "671bf1950c9137d10f14c28ff7c7dbd8",
"assets/assets/images/Cars/Ford_GT.jpg": "7441386906d7ef773f982767e44b29b9",
"assets/assets/images/Cars/Ford_GT.jpg.Attribution.txt": "62c2ad40f9d0db907f3853074fd192d0",
"assets/assets/images/Cars/Ford_Model_T.jpg": "e2e891dabb71bb49451660032fe39e15",
"assets/assets/images/Cars/Ford_Model_T.jpg.Attribution.txt": "b56af6c4a75f962619a88d8086b8e118",
"assets/assets/images/Cars/Ford_Shelby_GT350.jpg": "042261b1f2ca5077de315188b121db16",
"assets/assets/images/Cars/Ford_Shelby_GT350.jpg.Attribution.txt": "f7d79e727fb0de4d4bc01b018ac77bf0",
"assets/assets/images/Cars/Honda_NSX.jpg": "fd7e4ab94c843c531fe2325b7cc9496e",
"assets/assets/images/Cars/Honda_NSX.jpg.Attribution.txt": "a77c249634a6911f0126985b45bfb4f9",
"assets/assets/images/Cars/hummer_h1.jpg": "4bc36db9a804eaf461e3260d8062cf1a",
"assets/assets/images/Cars/hummer_h1.jpg.Attribution.txt": "2d1dd8d3fcad139046c703dba1c58730",
"assets/assets/images/Cars/Hyundai_Ioniq_5.jpg": "9535401deba25891dfedbbface5765a4",
"assets/assets/images/Cars/Hyundai_Ioniq_5.jpg.Attribution.txt": "e5febb06fee2766d7f3112604783c43d",
"assets/assets/images/Cars/jaguar.webp": "231280bb5bc1c4f7ab9f20fbab7e0072",
"assets/assets/images/Cars/jaguar.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/Jeep_Wrangler.jpg": "9c6321eb90ec50da9f1b4996dc99c8e8",
"assets/assets/images/Cars/Jeep_Wrangler.jpg.Attribution.txt": "cbe150985851f93ee5692cdb17d95c92",
"assets/assets/images/Cars/koenigsegg.jpg": "c31832e8b4a4c46bbf73bef614407e66",
"assets/assets/images/Cars/koenigsegg.jpg.Attribution.txt": "811587694841eff6bc7e0e0d4af843d7",
"assets/assets/images/Cars/LaFerrari.jpg": "f294d9a02575245079083d63dd809f5c",
"assets/assets/images/Cars/LaFerrari.jpg.Attribution.txt": "f6ff31a87dabbc4fb35f831d02c32975",
"assets/assets/images/Cars/Lamborghini_Countach.jpg": "791b3c024bf592e007ecd01ec80a2f53",
"assets/assets/images/Cars/Lamborghini_Countach.jpg.Attribution.txt": "c31f93f727177b5f4fc543da093b998f",
"assets/assets/images/Cars/Lamborghini_Murcielago.webp": "e5eedc732b833188f85ed65ed2e18cc2",
"assets/assets/images/Cars/Lamborghini_Murcielago.webp.Attribution.txt": "7aff64a03ed828cb0c098526b33c5926",
"assets/assets/images/Cars/landrover.jpg": "3f8e42d5da961e38286ca28710091bb9",
"assets/assets/images/Cars/landrover.jpg.Attribution.txt": "7aa618271a9cd19986900d7dde2e7b96",
"assets/assets/images/Cars/LexusLFA.jpg": "cec3e99306698d7f6fddc9c5a50eeaf6",
"assets/assets/images/Cars/LexusLFA.jpg.Attribution.txt": "1c8aae24f0225bbae301b7cf7494f5de",
"assets/assets/images/Cars/Maserati_Ghibli.jpg": "90bc5d001b83e58e3d42a4b6c2e839c3",
"assets/assets/images/Cars/Maserati_Ghibli.jpg.Attribution.txt": "ff3a5ec6792d92efa4839eb34b9a0cbd",
"assets/assets/images/Cars/Maybach_62_S.jpg": "f35c396155195287283883be4c2d2117",
"assets/assets/images/Cars/Maybach_62_S.jpg.Attribution.txt": "ffd4a589050ab1b6a152b247455d5277",
"assets/assets/images/Cars/mazda.jpg": "7c92f9bcdf2109acff4f7972e7571fa9",
"assets/assets/images/Cars/mazda.jpg.Attribution.txt": "306e320a6a18420a65efd9200a8721be",
"assets/assets/images/Cars/McLaren.jpg": "c216360f91988016b8c0531813fd4b1e",
"assets/assets/images/Cars/McLaren.jpg.Attribution.txt": "5325f976734493f3807329d437947a2c",
"assets/assets/images/Cars/Mercedes-AMG_GT_R.webp": "a7bdd444e42b3af4239157f41c279e2a",
"assets/assets/images/Cars/Mercedes-AMG_GT_R.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/Mercedes-Benz_600.jpg": "e334ec913e71d00637e362560d98bfd2",
"assets/assets/images/Cars/Mercedes-Benz_600.jpg.Attribution.txt": "0b1a7f7b974ba4af9bb72974b20069e1",
"assets/assets/images/Cars/Mercedes-Benz_SLS_Electric_Drive.jpg": "95c1b6e04aeece7f6b0715721a7bf290",
"assets/assets/images/Cars/Mercedes-Benz_SLS_Electric_Drive.jpg.Attribution.txt": "41f6699168a898e13b715cc667cb8b80",
"assets/assets/images/Cars/Mercedes_300_SL.JPG": "27820e2c4cfe65f721178c05d8e653af",
"assets/assets/images/Cars/Mercedes_300_SL.JPG.Attribution.txt": "23c92993a68026bb2373bf903503bcfa",
"assets/assets/images/Cars/Mercedes_G_6x6.webp": "09342e4d9e17bb762cb715e34f6ee497",
"assets/assets/images/Cars/Mercedes_G_6x6.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/Mini.jpg": "01825b778f4ae4bce48fcdfd86448fe0",
"assets/assets/images/Cars/Mini.jpg.Attribution.txt": "07c77cb4b35112e5c531aca4fa881745",
"assets/assets/images/Cars/Mitsubishi_Evo.jpg": "794f8e3ca4753ff476f0de330c7deec7",
"assets/assets/images/Cars/Mitsubishi_Evo.jpg.Attribution.txt": "5f129a982022805acc69bc6ecc50e258",
"assets/assets/images/Cars/nissan.jpg": "18095d11f9e1f20f5ccd1293e4f7b43c",
"assets/assets/images/Cars/nissan.jpg.Attribution.txt": "d96ba3620f86087c9f39a077a96cc164",
"assets/assets/images/Cars/Nissan350Z.jpg": "0a740bb5322f7db51d1ac0461dbfa617",
"assets/assets/images/Cars/Nissan350Z.jpg.Attribution.txt": "9db93a496925969e834273aa8fa81ef1",
"assets/assets/images/Cars/opelManta.jpg": "91c99401543a794b678567d8277779c2",
"assets/assets/images/Cars/opelManta.jpg.Attribution.txt": "45f80b9f76ca16797d3ff293194f0557",
"assets/assets/images/Cars/porsche911.jpg": "afc64c1f6049123c629f20338d317f47",
"assets/assets/images/Cars/porsche911.jpg.Attribution.txt": "b1f96a7067b69d3b9b3bdd6a7efc1dff",
"assets/assets/images/Cars/porsche959.jpg": "809a471ad35b46860be6b0163818cc58",
"assets/assets/images/Cars/porsche959.jpg.Attribution.txt": "a0bbe87d1895bd4d226d22c6d85f0b96",
"assets/assets/images/Cars/Porsche_Cayenne.jpg": "0bc37948a25ba333c14248a54fe288b7",
"assets/assets/images/Cars/Porsche_Cayenne.jpg.Attribution.txt": "2e7333d3ce06af9ed050e17b656ec6ab",
"assets/assets/images/Cars/Porsche_Taycan.webp": "85cfe15c1cfe9ff42e88a220dd3a8835",
"assets/assets/images/Cars/Porsche_Taycan.webp.Attribution.txt": "bcba7a0932cfc3e98caf738e423cc8c7",
"assets/assets/images/Cars/Range_Rover.jpg": "7b39ce56754eb26f6ff1677e0e6f81b0",
"assets/assets/images/Cars/Range_Rover.jpg.Attribution.txt": "98ecc2f882cd97edf379aad2bd9f0510",
"assets/assets/images/Cars/renault.jpg": "ae4b4e6c96480ff32c771033e4994711",
"assets/assets/images/Cars/RimacNevera.jpg": "9af623bc544279d3bb742a22857d6fb3",
"assets/assets/images/Cars/RimacNevera.jpg.Attribution.txt": "eb645979efa334d68aa60dcdeeb37837",
"assets/assets/images/Cars/Rolls-Royce_Ghost.webp": "7c5b8e9d96a61037daa35455738f18b0",
"assets/assets/images/Cars/Rolls-Royce_Ghost.webp.Attribution.txt": "11461ee888f8369ce88b07cd028cb198",
"assets/assets/images/Cars/smart.webp": "bc272b9add9da05befdc0c885694e1fe",
"assets/assets/images/Cars/smart.webp.Attribution.txt": "1126d02f14fab1699b3313a9e7723d0d",
"assets/assets/images/Cars/tata-nano.JPG": "d1dae4d4312775f73138d9b4098976f4",
"assets/assets/images/Cars/tata-nano.JPG.Attribution.txt": "fba09609b0d14e202ca585d4a5a0501e",
"assets/assets/images/Cars/tesla-plaid.jpg": "a704dd766ae8cdf78920cb879701f9ac",
"assets/assets/images/Cars/tesla-plaid.jpg.Attribution.txt": "2cc4962e8bbfc6d1ceb6640e029833ab",
"assets/assets/images/Cars/Tesla_Roadster.jpg": "48ff752c333dc86536bd52cc695faeca",
"assets/assets/images/Cars/Tesla_Roadster.jpg.Attribution.txt": "a37fedfb5ec5e31a0105ab841775952e",
"assets/assets/images/Cars/Toyota_Land_Cruiser_70.jpg": "91a92f8fa066d9e7d2105659b4eb9ed8",
"assets/assets/images/Cars/Toyota_Land_Cruiser_70.jpg.Attribution.txt": "ca63bdb07417c54f901477814f3b7d29",
"assets/assets/images/Cars/Toyota_Mirai.jpg": "4519887ae83846775c1f6843e5716b7e",
"assets/assets/images/Cars/Toyota_Mirai.jpg.Attribution.txt": "4083a25ed7796a9654dd0fd2f4dc3802",
"assets/assets/images/Cars/Toyota_Supra.jpg": "39929ef07fb178c538088557b200af59",
"assets/assets/images/Cars/Toyota_Supra.jpg.Attribution.txt": "4acf70925a8d47f38f3ef38a0c0f7e52",
"assets/assets/images/Cars/vw-golf.jpg": "2b5d68dada76cc2abeb54fce83e05e47",
"assets/assets/images/Cars/vw-golf.jpg.Attribution.txt": "91d153ee777d7ce35c44f97a52c6f116",
"assets/assets/images/Cars/vw-t6.jpg": "65a01c11b26c5fbadcf220c8d9d5664f",
"assets/assets/images/Cars/vw-t6.jpg.Attribution.txt": "46e380e8173d3850b87d257cbc6afdbe",
"assets/assets/images/Cars/VW_Kaefer.jpg": "b04189349282ffbab3f29d7056e0c73f",
"assets/assets/images/Cars/VW_Kaefer.jpg.Attribution.txt": "3eb1e0879f0830f9239f14738c7c8b82",
"assets/assets/images/Cars/Wiesmann.jpg": "5b3f5e159ed8a2635f5cd8fc4c588dc9",
"assets/assets/images/Cars/Wiesmann.jpg.Attribution.txt": "ff3a5ec6792d92efa4839eb34b9a0cbd",
"assets/assets/images/Cars/Zenvo_ST1.jpg": "5d28bd8e07f38aa17babe6ea0a0251cf",
"assets/assets/images/Cars/Zenvo_ST1.jpg.Attribution.txt": "2bc3b3ed3eda36d4b068d3b92e488a6f",
"assets/assets/images/flutter_logo.png": "478970b138ad955405d4efda115125bf",
"assets/assets/images/game-over.png": "288b35a01eb7845261a8740309d5854e",
"assets/assets/images/placeholder.png": "ea52ec10580e866f138fd60d0c06e5e2",
"assets/assets/images/Rockets/Angara-A5.jpg": "ffbebf03b697d3beae49779be05b22e0",
"assets/assets/images/Rockets/Angara-A5.jpg.Attribution.txt": "0b53857ba54db7d62e6082b1f21725ac",
"assets/assets/images/Rockets/Ariane_1.jpg": "6ed6c270f4c7d9015c8bacd77703a6ad",
"assets/assets/images/Rockets/Ariane_1.jpg.Attribution.txt": "65ffa68a806a4c407df5b0e030672987",
"assets/assets/images/Rockets/Ariane_5.jpg": "07245f5104b5b0d613d29c9b2ac5a4c3",
"assets/assets/images/Rockets/Ariane_5.jpg.Attribution.txt": "909f2ed2de399069e896e2f27276fc08",
"assets/assets/images/Rockets/Atlas_III.jpg": "eb4d8216bc7d0f9048314101da887665",
"assets/assets/images/Rockets/Atlas_III.jpg.Attribution.txt": "da9d9b720ee510f34f4ee2f01f331c6c",
"assets/assets/images/Rockets/Atlas_V.jpg": "fa437ff9b34b312b7af10fde52b75b2a",
"assets/assets/images/Rockets/Atlas_V.jpg.Attribution.txt": "da9d9b720ee510f34f4ee2f01f331c6c",
"assets/assets/images/Rockets/background.jpg": "7f1cd58775cc61761616502dd924a288",
"assets/assets/images/Rockets/black_arrow.JPG": "a30cbf5ebbd9ca9a4fc57aa1e2633c89",
"assets/assets/images/Rockets/black_arrow.JPG.Attribution.txt": "d6aa81c18ecbf493d3d3a71cd8b73532",
"assets/assets/images/Rockets/Changzheng-1.jpg": "45affbe40181868711a4c223c1c8d8dd",
"assets/assets/images/Rockets/Changzheng-1.jpg.Attribution.txt": "fce25190e7a3961aeacac3b5b414140a",
"assets/assets/images/Rockets/Delta_IV_Heavy.jpg": "3fe59f96427b89375f91326a1f05766e",
"assets/assets/images/Rockets/Delta_IV_Heavy.jpg.Attribution.txt": "909f2ed2de399069e896e2f27276fc08",
"assets/assets/images/Rockets/Diamant.jpg": "d1cd9168aacd5dfea31a84515fbc70a3",
"assets/assets/images/Rockets/Diamant.jpg.Attribution.txt": "c60e454f25c87517f86f8c88699384de",
"assets/assets/images/Rockets/electron.jpg": "a432f863ad9a8be5eae70b571751b23c",
"assets/assets/images/Rockets/electron.jpg.Attribution.txt": "a8504e983955885039d40780cee7ed44",
"assets/assets/images/Rockets/energia.JPEG": "b21bab3610020562d538b22eea220b33",
"assets/assets/images/Rockets/energia.JPEG.Attribution.txt": "63430882f142c85397b61ebbec56a2e4",
"assets/assets/images/Rockets/Falcon_1.jpg": "6d3f611caba9714a4ad81f04f7ca83e8",
"assets/assets/images/Rockets/Falcon_1.jpg.Attribution.txt": "d20f7c820f2208ddd6217137955b7c0d",
"assets/assets/images/Rockets/Falcon_9_1.jpg": "19b47aaa62d172923d2ae412aa6fe5dc",
"assets/assets/images/Rockets/Falcon_9_1.jpg.Attribution.txt": "1c04353b29d643ad69b5a600730a01c6",
"assets/assets/images/Rockets/Falcon_9_Block_5.jpg": "d310f488d3acf1cba49ba240247b2b05",
"assets/assets/images/Rockets/Falcon_9_Block_5.jpg.Attribution.txt": "2d64caf0353b9e50e1e7cfa8ac1156d3",
"assets/assets/images/Rockets/Falcon_Heavy.jpg": "0688b44d436926f9447393119a28c95e",
"assets/assets/images/Rockets/Falcon_Heavy.jpg.Attribution.txt": "d20f7c820f2208ddd6217137955b7c0d",
"assets/assets/images/Rockets/Firefly_Alpha.jpg": "ea477e04577c4fc817ffbc0fd7e73e5b",
"assets/assets/images/Rockets/Firefly_Alpha.jpg.Attribution.txt": "5dbde4fdbbb1acaf00ebfd5f4965c426",
"assets/assets/images/Rockets/H-IIA.jpg": "6d253f2338a4b12c5db9f87ab7da8cbe",
"assets/assets/images/Rockets/H-IIA.jpg.Attribution.txt": "143f0d86f7dc78c72deeb246fdc2f8f9",
"assets/assets/images/Rockets/Long_March.jpg": "86d6d881d7d73dd1efe3209c60238cd8",
"assets/assets/images/Rockets/Long_March.jpg.Attribution.txt": "2188f1eff3ca4295e47bd94eb769789f",
"assets/assets/images/Rockets/LVM3.png": "995ee2b3fa2fd5eccb15b6bad33958d3",
"assets/assets/images/Rockets/LVM3.png.Attribution.txt": "4c3e5a6c8033fd2113e58cf69cf74b07",
"assets/assets/images/Rockets/N1.jpg": "630f5c9c4e333a8acba55e2cb18f28d3",
"assets/assets/images/Rockets/N1.jpg.Attribution.txt": "b94671f631e3731e871b4b26cb1f7d94",
"assets/assets/images/Rockets/New_Shepard.jpg": "f33e31f1f146f4547d972a868a3c181c",
"assets/assets/images/Rockets/New_Shepard.jpg.Attribution.txt": "5b5abef42012fe1d23eff3c78e379922",
"assets/assets/images/Rockets/Saturn_IB.jpg": "bfbecf925f1a9d5e2df2db94c595416b",
"assets/assets/images/Rockets/Saturn_IB.jpg.Attribution.txt": "e966b3aba803e9db3498980cb99c5ed6",
"assets/assets/images/Rockets/Saturn_V.jpg": "af9827c8f8f7ff7ed8dc660bc1bbc8a8",
"assets/assets/images/Rockets/SLS_Block_1.jpg": "e7990beb2d1f0ae0db30b1a6ae2448e8",
"assets/assets/images/Rockets/SLS_Block_1.jpg.Attribution.txt": "1ed3edfbdfba59b7f994e13e6eb96bd4",
"assets/assets/images/Rockets/Soyuz.jpg": "8a213a76c8ded099d1ce8a8f4c19f744",
"assets/assets/images/Rockets/Soyuz.jpg.Attribution.txt": "1c04353b29d643ad69b5a600730a01c6",
"assets/assets/images/Rockets/Space_Shuttle.jpg": "cd62f4641ea7893de66b885e6341b469",
"assets/assets/images/Rockets/Space_Shuttle.jpg.Attribution.txt": "1c04353b29d643ad69b5a600730a01c6",
"assets/assets/images/Rockets/Sputnik.jpg": "0f960ea729288bb5860e710d97e49e47",
"assets/assets/images/Rockets/Sputnik.jpg.Attribution.txt": "1c04353b29d643ad69b5a600730a01c6",
"assets/assets/images/Rockets/starship.jpg": "a1f6493daec67336e96398b1ae834048",
"assets/assets/images/Rockets/starship.jpg.Attribution.txt": "5f88f5cfc05dc14f267e689c67722fd4",
"assets/assets/images/Rockets/Titan_2.JPG": "cb46a820553416bc137ff58167c2f9dd",
"assets/assets/images/Rockets/Titan_2.JPG.Attribution.txt": "7cf57cd122345f98baaaa785d334bb86",
"assets/assets/images/Rockets/vostok.jpg": "754295d8b0a15a07737481a60e904e2e",
"assets/assets/images/Rockets/vostok.jpg.Attribution.txt": "c563c204db6136bc8bcd987d9cbece9e",
"assets/assets/images/Rockets/Zenit-2.jpg": "9326261b93c2e30fbcb5f87e8cea83d6",
"assets/assets/images/Rockets/Zenit-2.jpg.Attribution.txt": "83c10a51359476f26a7fea58726d5207",
"assets/assets/images/trophy.png": "b6439747e33eec5ef89f3d0628211972",
"assets/assets/images/trump-cards-logo-shadow.png": "3bccf18d826a1407ef7b6a5e2ae5ba39",
"assets/assets/translations/ar.json": "dade29e7ecf5c7cbc10160a3abe81df8",
"assets/assets/translations/de.json": "66bff3178e30d438d3782d1f6cf5b85c",
"assets/assets/translations/en.json": "5d7a8cd60118b0f862958267accb74b6",
"assets/assets/translations/es.json": "6b86e7d4a25293410501aa1efbc67131",
"assets/assets/translations/fr.json": "70298e2fe5ce22f81fc1f245f8d6733f",
"assets/assets/translations/hi.json": "b2f9f84ee8352cf62ebfe8fd89fcce59",
"assets/assets/translations/ja.json": "506b888358ea8334df8f24d35735e382",
"assets/assets/translations/ko.json": "ba29c697ac1ec6122a44f5c43c807267",
"assets/assets/translations/pt.json": "c6d821133c5d1cdf744c1781b1a7c03e",
"assets/assets/translations/ru.json": "03ed90d0987caa4f8aa88728f917f4c1",
"assets/assets/translations/zh.json": "f53d43606bc7e431399ad1ad14daf8fc",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "9fcc48126953fa10282ffff66350f9fc",
"assets/NOTICES": "15bd07e1487a6df188908633b64aba84",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "9c01e90db0eb1ea06c3e3511b529646f",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "fe16176f405d241cf5a7ac281080471d",
"icons/Icon-512.png": "e79e77bb9ba6881cba18c972cb4bbadb",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a4ad3819f56296891f0ce1c8535ec1cf",
"/": "a4ad3819f56296891f0ce1c8535ec1cf",
"main.dart.js": "c5065adba9430b5007b4db490cd25ac4",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "7752603a4a26051205b45b317d0174a9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
