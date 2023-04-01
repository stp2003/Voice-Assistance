import 'package:animate_do/animate_do.dart';
import 'package:chat_gpt/constants/colors.dart';
import 'package:chat_gpt/services/openai_services.dart';
import 'package:chat_gpt/widgets/features_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //**
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';

  //**
  String? generatedContent;
  String? generatedImageUrl;

  //**
  int start = 200;
  int delay = 200;

  final OpenAIService openAIService = OpenAIService();

  //?? init state ->
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  //?? tts ->
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  //?? initSpeechToText ->
  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  //?? for listening ->
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  //?? for stop listening ->
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  //?? for forming results ->
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  //?? for speaking ->
  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  //?? dispose ->
  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  //?? build ->
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: const Text(
            'Allen',
            style: TextStyle(
              fontFamily: 'poppins_bold',
              letterSpacing: 1.2,
              color: Pallete.firstSuggestionBoxColor,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sort_sharp,
            color: Pallete.assistantCircleColor,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      //?? body ->
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              //?? virtual assistance ppf ->
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 120.0,
                        width: 120.0,
                        margin: const EdgeInsets.only(top: 4.0),
                        decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Container(
                      height: 123.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/virtualAssistant.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //?? chat bubble ->
              FadeInRight(
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40.0).copyWith(
                      top: 30.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(20.0).copyWith(
                        topLeft: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        generatedContent == null
                            ? 'Good Morning, what task can I do for you?'
                            : generatedContent!,
                        style: TextStyle(
                          fontFamily: 'poppins_medium',
                          letterSpacing: 1.2,
                          color: Pallete.thirdSuggestionBoxColor,
                          fontSize: generatedContent == null ? 23.0 : 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //?? for image ->
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              //?? text ->
              SlideInRight(
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(top: 10.0, left: 22.0),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Here are few features',
                      style: TextStyle(
                        fontFamily: 'poppins_bold',
                        letterSpacing: 1.2,
                        color: Pallete.mainFontColor,
                      ),
                    ),
                  ),
                ),
              ),

              //?? features list ->
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureBox(
                        color: Pallete.firstSuggestionBoxColor,
                        headerText: 'Chat GPT',
                        descriptionText:
                            'A smarter way to stay organized and informed with ChatGPT.',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay),
                      child: const FeatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: 'Dall-E',
                        descriptionText:
                            'Get inspired and stay creative with your personal assistant powered by Dall-E.',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + 2 * delay),
                      child: const FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor,
                        headerText: 'Smart Voice Assistant',
                        descriptionText:
                            'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //?? floating action button ->
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 4 * delay),
        child: FloatingActionButton(
          backgroundColor: cardColor,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic,
          ),
        ),
      ),
    );
  }
}
