import 'dart:convert';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
import '../core/api_config.dart';
import '../core/failure.dart';
import '../core/providers.dart';
import '../core/type_defs.dart';
import '../core/utils/error_hendling.dart';
import '../models/complaint.dart';
import 'apis.dart';

final complaintApiProvider = Provider<ComplaintApi>((ref) {
  return ComplaintApi(
      client: ref.watch(clientProvider),
);
});

abstract class IComplaintAPI {
  FutureVoid saveComplaintToDatabase({
    required Complaint complaint,
  });
  FutureEither updateComplaint({
    required Complaint complaint,
  });
  FutureEither<List<Complaint>> getAllComplaints();
  FutureEither<List<Complaint>> getBookmarkedComplaints({required String uid});
  FutureEither<Complaint> getComplaintById({required String complaintId});
}

class ComplaintApi implements IComplaintAPI {
  final Client _client;
  ComplaintApi(
      {required Client client, })
      : _client = client;
      
        @override
        FutureEither<List<Complaint>> getAllComplaints() {
          // TODO: implement getAllComplaints
          throw UnimplementedError();
        }
      
        @override
        FutureEither<List<Complaint>> getBookmarkedComplaints({required String uid}) {
          // TODO: implement getBookmarkedComplaints
          throw UnimplementedError();
        }
      
        @override
        FutureEither<Complaint> getComplaintById({required String complaintId}) {
          // TODO: implement getComplaintById
          throw UnimplementedError();
        }
      
        @override
        FutureVoid saveComplaintToDatabase({required Complaint complaint}) {
          // TODO: implement saveComplaintToDatabase
          throw UnimplementedError();
        }
      
        @override
        FutureEither updateComplaint({required Complaint complaint}) {
          // TODO: implement updateComplaint
          throw UnimplementedError();
        }

}
