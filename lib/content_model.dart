class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({this.image = '', this.title = '', this.discription = ''});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Nepali Sign Language',
    image: 'images/271808-P5Y6CB-83.jpg',
    discription: "Our app uses advanced image recognition to interpret Nepali Sign Language,"
        " making communication more inclusive for individuals with hearing impairments. "
        "It employs cutting-edge technology to detect and translate gestures representing unique "
        "characters in Nepali Sign Language. ",
  ),
  OnboardingContent(
    title: 'Just click',
    image: 'images/5044081.jpg',
    discription: "Effortlessly capture and predict Nepali Sign Language with our app."
        " Utilizing YOLO's image recognition, it interprets gestures, providing a seamless way to communicate and understand Nepali Sign Language on your mobile device."
        " Empower communication with inclusivity.",
  ),
  OnboardingContent(
    title: 'Sign Predict',
    image: 'images/8608652.jpg',
    discription: "Snap a photo or upload one, and our "
        "cutting-edge technology predicts Nepali alphabetical "
        "sign language gestures instantly. Bridging gaps, fostering inclusivity.",
  ),
];
