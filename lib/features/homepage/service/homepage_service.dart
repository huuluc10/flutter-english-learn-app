import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';

class HomepageService {
  final HomepageRepository homepageRepository;

  HomepageService({required this.homepageRepository});

  Future<void> fetchTopic(String body) async {
    await homepageRepository.fetchTopic(body);
  }
}