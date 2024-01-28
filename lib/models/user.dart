// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String uid; 
  final String name; // Name field
  final String email; // Email field
  final String photoUrl; // photoUrl field
  final String about;
  final String phone; // photoUrl
  final String dob;
  final String experience;
  final List<String> skills;
  final String service;
  final String role;
  final List<String> savedWorkers;
  final String portfolioUrl; // linkedInProfileUrl field
  final List<String> myJobs; // bookmarkedComplaints field
  final List<String> savedJobs; // bookmarkedEvents field
  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.photoUrl,
      required this.about,
      required this.phone,
            required this.savedWorkers,

      required this.dob,
      required this.experience,
      required this.skills,
      required this.service,
      required this.portfolioUrl,
      required this.myJobs,
      required this.savedJobs,
      required this.role});

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? about,
    String? phone,
    String? dob,
    String? experience,
    List<String>? skills,
    List<String>? savedWorkers,
    String? service,
    String? portfolioUrl,
    String? role,
    List<String>? myJobs,
    List<String>? savedJobs,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      about: about ?? this.about,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      service: service ?? this.service,
            savedWorkers: savedWorkers ?? this.savedWorkers,

      role: role ?? this.role,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      myJobs: myJobs ?? this.myJobs,
      savedJobs: savedJobs ?? this.savedJobs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'about': about,
      'phone': phone,
      'dob': dob,
      'savedWorkers': savedWorkers,
      'experience': experience,
      'skills': skills,
      'service': service,
      'role': role,
      'portfolioUrl': portfolioUrl,
      'myJobs': myJobs,
      'savedJobs': savedJobs,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      about: map['about'] as String,
      phone: map['phone'] as String,
      dob: map['dob'] as String,
      role: map['role'] as String,
      experience: map['experience'] as String,
      skills: List<String>.from(
        (map['skills'] ),
      ),
      savedWorkers: List<String>.from(
        (map['savedWorkers'] ),
      ),
      service: map['service'] as String,
      portfolioUrl: map['portfolioUrl'] as String,
      myJobs: List<String>.from(
        (map['myJobs']),
      ),
      savedJobs: List<String>.from(
        (map['savedJobs']),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, photoUrl: $photoUrl, about: $about, phone: $phone, dob: $dob, experience: $experience, skills: $skills, service: $service, portfolioUrl: $portfolioUrl, myJobs: $myJobs, savedJobs: $savedJobs)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.about == about &&
        other.phone == phone &&
        other.dob == dob &&
        other.experience == experience &&
        listEquals(other.skills, skills) &&
        other.service == service &&
        other.portfolioUrl == portfolioUrl &&
        listEquals(other.myJobs, myJobs) &&
        listEquals(other.savedJobs, savedJobs);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        about.hashCode ^
        phone.hashCode ^
        dob.hashCode ^
        experience.hashCode ^
        skills.hashCode ^
        service.hashCode ^
        portfolioUrl.hashCode ^
        myJobs.hashCode ^
        savedJobs.hashCode;
  }
}
