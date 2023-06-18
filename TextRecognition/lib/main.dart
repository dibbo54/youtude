// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// void main() {
//   runApp(MyHomePage());
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   File? _image;
//   String result = '';
//   late ImagePicker imagePicker;
//   dynamic textRecognizer;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     imagePicker = ImagePicker();
//
//     //TODO initialize detector
//      textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//
//   }
//
//   _imgFromCamera() async {
//     XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
//     File image = File(pickedFile!.path);
//     setState(() {
//       _image = image;
//       if (_image != null) {
//         doTextRecognition();
//       }
//     });
//   }
//
//   _imgFromGallery() async {
//     XFile? pickedFile =
//     await imagePicker.pickImage(source: ImageSource.gallery);
//     File image = File(pickedFile!.path);
//     setState(() {
//       _image = image;
//       if (_image != null) {
//         doTextRecognition();
//       }
//     });
//   }
//
//   //TODO perform text recognition
//   doTextRecognition() async {
//     InputImage inputImage=InputImage.fromFile(_image!);
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//
//     String text = recognizedText.text;
//     setState(() {
//       result=text;
//     });
//
//     for (TextBlock block in recognizedText.blocks) {
//       final Rect rect = block.boundingBox;
//       final List<Point<int>> cornerPoints = block.cornerPoints;
//       final String text = block.text;
//       final List<String> languages = block.recognizedLanguages;
//
//       for (TextLine line in block.lines) {
//         // Same getters as TextBlock
//         for (TextElement element in line.elements) {
//           // Same getters as TextBlock
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('images/bg2.jpg'), fit: BoxFit.cover),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(
//                 width: 100,
//               ),
//               Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('images/notebook.png'),
//                       fit: BoxFit.cover),
//                 ),
//                 height: 280,
//                 width: 250,
//                 margin: const EdgeInsets.only(top: 70),
//                 padding: const EdgeInsets.only(left: 28, bottom: 5, right: 18),
//                 child: SingleChildScrollView(
//                     child: Text(
//                       result,
//                       textAlign: TextAlign.justify,
//                       style: const TextStyle(fontSize: 20),
//                     ),),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20, right: 140),
//                 child: Stack(children: <Widget>[
//                   Center(
//                     child: Image.asset(
//                       'images/clipboard.png',
//                       height: 240,
//                       width: 240,
//                     ),
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: _imgFromGallery,
//                       onLongPress: _imgFromCamera,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent),
//                       child: Container(
//                         margin: const EdgeInsets.only(top: 25),
//                         child: _image != null
//                             ? Image.file(
//                           _image!,
//                           width: 140,
//                           height: 192,
//                           fit: BoxFit.fill,
//                         )
//                             : Container(
//                           width: 140,
//                           height: 150,
//                           child: Icon(
//                             Icons.find_in_page,
//                             color: Colors.grey[800],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:math';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
//
// late List<CameraDescription> cameras;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(
//         title: 'screen',
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   dynamic controller;
//   bool isBusy = false;
//   dynamic textRecognizer;
//   late Size size;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }
//
//   //TODO code to initialize the camera feed
//   initializeCamera() async {
//     //TODO initialize detector
//     textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//
//     controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
//     await controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       controller.startImageStream((image) => {
//         if (!isBusy)
//           {isBusy = true, img = image, doTextRecognitionOnFrame()}
//       });
//     });
//   }
//
//   //close all resources
//   @override
//   void dispose() {
//     controller?.dispose();
//     //textRecognizer.close();
//     super.dispose();
//   }
//
//   //TODO object detection on a frame
//   dynamic _scanResults;
//   CameraImage? img;
//   doTextRecognitionOnFrame() async {
//     var frameImg = getInputImage();
//     RecognizedText recognizedText = await textRecognizer.processImage(frameImg);
//     print(recognizedText.text);
//     setState(() {
//       _scanResults = recognizedText;
//       isBusy = false;
//     });
//
//   }
//
//   InputImage getInputImage() {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (final Plane plane in img!.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();
//     final Size imageSize = Size(img!.width.toDouble(), img!.height.toDouble());
//     final camera = cameras[0];
//     final imageRotation =
//     InputImageRotationValue.fromRawValue(camera.sensorOrientation);
//     // if (imageRotation == null) return;
//
//     final inputImageFormat =
//     InputImageFormatValue.fromRawValue(img!.format.raw);
//     // if (inputImageFormat == null) return null;
//
//     final planeData = img!.planes.map(
//           (Plane plane) {
//         return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width,
//         );
//       },
//     ).toList();
//
//     final inputImageData = InputImageData(
//       size: imageSize,
//       imageRotation: imageRotation!,
//       inputImageFormat: inputImageFormat!,
//       planeData: planeData,
//     );
//
//     final inputImage =
//     InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
//
//     return inputImage;
//   }
//
//   //Show rectangles around detected objects
//   Widget buildResult() {
//     if (_scanResults == null ||
//         controller == null ||
//         !controller.value.isInitialized) {
//       return const Text('');
//     }
//
//     final Size imageSize = Size(
//       controller.value.previewSize!.height,
//       controller.value.previewSize!.width,
//     );
//     CustomPainter painter = TextRecognitionPainter(imageSize, _scanResults);
//     return CustomPaint(
//       painter: painter,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> stackChildren = [];
//     size = MediaQuery.of(context).size;
//     if (controller != null) {
//       stackChildren.add(
//         Positioned(
//           top: 0.0,
//           left: 0.0,
//           width: size.width,
//           height: size.height,
//           child: Container(
//             child: (controller.value.isInitialized)
//                 ? AspectRatio(
//               aspectRatio: controller.value.aspectRatio,
//               child: CameraPreview(controller),
//             )
//                 : Container(),
//           ),
//         ),
//       );
//
//       stackChildren.add(
//         Positioned(
//             top: 0.0,
//             left: 0.0,
//             width: size.width,
//             height: size.height,
//             child: buildResult()),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text("Text Recognizer",style: TextStyle(fontSize: 25),)),
//         backgroundColor: Colors.brown,
//       ),
//       backgroundColor: Colors.black,
//       body: Container(
//           margin: const EdgeInsets.only(top: 0),
//           color: Colors.black,
//           child: Stack(
//             children: stackChildren,
//           )),
//     );
//   }
// }
//
// class TextRecognitionPainter extends CustomPainter {
//   TextRecognitionPainter(this.absoluteImageSize, this.recognizedText);
//
//   final Size absoluteImageSize;
//   final RecognizedText recognizedText;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double scaleX = size.width / absoluteImageSize.width;
//     final double scaleY = size.height / absoluteImageSize.height;
//
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..color = Colors.brown;
//
//     for (TextBlock block in recognizedText.blocks) {
//       final Rect rect = block.boundingBox;
//       final List<Point<int>> cornerPoints = block.cornerPoints;
//       final String text = block.text;
//       final List<String> languages = block.recognizedLanguages;
//
//       canvas.drawRect(
//         Rect.fromLTRB(
//           block.boundingBox.left * scaleX,
//           block.boundingBox.top * scaleY,
//           block.boundingBox.right * scaleX,
//           block.boundingBox.bottom * scaleY,
//         ),
//         paint,
//       );
//
//       TextSpan span = TextSpan(
//           text: block.text,
//           style: const TextStyle(fontSize: 20, color: Colors.red));
//       TextPainter tp = TextPainter(
//           text: span,
//           textAlign: TextAlign.left,
//           textDirection: TextDirection.ltr);
//       tp.layout();
//       tp.paint(canvas, Offset(block.boundingBox.left * scaleX, block.boundingBox.top * scaleY));
//
//       for (TextLine line in block.lines) {
//         // Same getters as TextBlock
//         for (TextElement element in line.elements) {
//           // Same getters as TextBlock
//         }
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(TextRecognitionPainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize ||
//         oldDelegate.recognizedText != recognizedText;
//   }
// }

import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ImagePicker imagePicker;
  File? _image;
  String result = '';
  var image;
  late List<Pose> poses;

  //TODO declare detector
  dynamic poseDetector;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize detector
    final options = PoseDetectorOptions(
        mode: PoseDetectionMode.single, model: PoseDetectionModel.base);
    poseDetector = PoseDetector(options: options);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doPoseDetection();
    }
  }

  //TODO choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doPoseDetection();
    }
  }

  //TODO pose detection code here
  doPoseDetection() async {
    InputImage inputImage = InputImage.fromFile(_image!);
    poses = await poseDetector.processImage(inputImage);

    for (Pose pose in poses) {
      // to access all landmarks
      pose.landmarks.forEach((_, landmark) {
        final type = landmark.type;
        final x = landmark.x;
        final y = landmark.y;
        print("${type.name} $x $y");
      });

      // to access specific landmarks
      final landmark = pose.landmarks[PoseLandmarkType.nose];
    }
    setState(() {
      _image;
    });
    drawPose();
  }

  // //TODO draw pose
  drawPose() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    setState(() {
      image;
      poses;
      result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Stack(children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: _imgFromGallery,
                    onLongPress: _imgFromCamera,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child:
                    // Container(
                    //   margin: const EdgeInsets.only(top: 8),
                    //   child: _image != null
                    //       ? Image.file(
                    //           _image!,
                    //           width: 350,
                    //           height: 350,
                    //           fit: BoxFit.fill,
                    //         )
                    //       : Container(
                    //           width: 350,
                    //           height: 350,
                    //           color: Colors.indigo,
                    //           child: const Icon(
                    //             Icons.camera_alt,
                    //             color: Colors.white,
                    //             size: 100,
                    //           ),
                    //         ),
                    // ),
                    Container(
                      child: image != null
                          ? Center(
                              child: FittedBox(
                                child: SizedBox(
                                  width: image.width.toDouble(),
                                  height: image.height.toDouble(),
                                  child: CustomPaint(
                                    painter: PosePainter(poses,image),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.indigo,
                              width: 350,
                              height: 350,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 53,
                              ),
                            ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.imageFile);

  final List<Pose> poses;
  var imageFile;


  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.green;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.yellow;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blueAccent;

    for (final pose in poses)
    {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              landmark.x,
              landmark.y
            ),
            1,
            paint);
      });

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(joint1.x,
                joint1.y),
            Offset(joint2.x,
                joint2.y),
            paintType);
      }

      //Draw arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);

      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.poses != poses;
  }
}
