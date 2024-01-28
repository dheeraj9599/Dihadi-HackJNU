// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Jobs {
  final String id;
  final String title;
  final Timestamp postedAt;
  final Timestamp startDate;
  final String contractor;
  final String responsibility;
  final List<String> skills;
  final String status;
  final String contractorContact;
  final List<String> applicants;
  Jobs({
    required this.id,
    required this.title,
    required this.postedAt,
    required this.startDate,
    required this.contractor,
    required this.responsibility,
    required this.skills,
    required this.status,
    required this.contractorContact,
    required this.applicants,
  });

  Jobs copyWith(
      {String? id,
      String? title,
      Timestamp? postedAt,
      Timestamp? startDate,
      String? contractor,
      String? responsibility,
      List<String>? skills,
      String? status,
      String? contractorContact,
      List<String>? applicants}) {
    return Jobs(
      id: id ?? this.id,
      title: title ?? this.title,
      postedAt: postedAt ?? this.postedAt,
      startDate: startDate ?? this.startDate,
      contractor: contractor ?? this.contractor,
      responsibility: responsibility ?? this.responsibility,
      skills: skills ?? this.skills,
      status: status ?? this.status,
      applicants: applicants ?? this.applicants,
      contractorContact: contractorContact ?? this.contractorContact,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'postedAt': postedAt,
      'startDate': startDate,
      'contractor': contractor,
      'responsibility': responsibility,
      'skills': skills,
      'status': status,
      'applicants': applicants,
      'contractorContact': contractorContact,
    };
  }

  factory Jobs.fromMap(Map<String, dynamic> map) {
    return Jobs(
      id: map['id'] as String,
      title: map['title'] as String,
      postedAt: map['postedAt'] as Timestamp,
      startDate: map['startDate'] as Timestamp,
      contractor: map['contractor'] as String,
      responsibility: map['responsibility'] as String,
      skills: List<String>.from(
        (map['skills']),
      ),
      applicants: List<String>.from(
        (map['applicants']),
      ),
      status: map['status'] as String,
      contractorContact: map['contractorContact'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Jobs.fromJson(String source) =>
      Jobs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Jobs(id: $id, title: $title, postedAt: $postedAt, startDate: $startDate, contractor: $contractor, responsibility: $responsibility, skills: $skills, status: $status, contractorContact: $contractorContact)';
  }

  @override
  bool operator ==(covariant Jobs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.postedAt == postedAt &&
        other.startDate == startDate &&
        other.contractor == contractor &&
        other.responsibility == responsibility &&
        listEquals(other.skills, skills) &&
        other.status == status &&
        other.contractorContact == contractorContact;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        postedAt.hashCode ^
        startDate.hashCode ^
        contractor.hashCode ^
        responsibility.hashCode ^
        skills.hashCode ^
        status.hashCode ^
        contractorContact.hashCode;
  }
}
