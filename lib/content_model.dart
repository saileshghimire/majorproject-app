class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({this.image = '', this.title = '', this.discription = ''});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Quality Food',
    image: 'images/271808-P5Y6CB-83.jpg',
    discription: "Simply dummy text of the printing and typesetting industry. "
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        "when an unknown printer took a galley of type and scrambled it.",
  ),
  OnboardingContent(
    title: 'Fast Delivery',
    image: 'images/5044081.jpg',
    discription: "Simply dummy text of the printing and typesetting industry. "
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        "when an unknown printer took a galley of type and scrambled it.",
  ),
  OnboardingContent(
    title: 'Reward Surprises',
    image: 'images/8608652.jpg',
    discription: "Simply dummy text of the printing and typesetting industry. "
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        "when an unknown printer took a galley of type and scrambled it.",
  ),
];
