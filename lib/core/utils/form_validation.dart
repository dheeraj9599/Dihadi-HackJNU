import 'package:dihadi/core/utils/extensions/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_constant.dart';

final validationServiceProvider = Provider<ValidationService>((ref) {
  return ValidationService();
});

class ValidationService {
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return EMAIL_AUTH_VALIDATION_EMPTY;
    } else if (!value.isValidEmail()) {
      return EMAIL_AUTH_VALIDATION_INVALID;
    } 
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return NAME_AUTH_VALIDATION_EMPTY;
    }
    // else if (!value.isValidName()) {
    //   return NAME_AUTH_VALIDATION_INVALID;
    // }
    return null;
  }

  String? validateRollNumber(String value) {
    if (value.isEmpty) {
      return ROLL_NUMBER_AUTH_VALIDATION_EMPTY;
    } else if (!value.isValidRollNo()) {
      return ROLL_NUMBER_AUTH_VALIDATION_INVALID;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return PASSWORD_AUTH_VALIDATION_EMPTY;
    }
    if (value.length < 6) {
      return PASSWORD_AUTH_VALIDATION_TOO_SHORT;
    }
    return null;
  }

  String? validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return CONFIRM_PASSWORD_AUTH_VALIDATION_EMPTY;
    }
    if (value != password) {
      return CONFIRM_PASSWORD_AUTH_VALIDATION_NOT_MATCHED;
    }
    return null;
  }

  String? validateSelectCampus(String? value) {
    if (value == null || value.isEmpty) {
      return 'select role';
    }
    return null;
  }

  String? validateSelectCourse(String value) {
    if (value.isEmpty) {
      return 'select skills';
    }
    return null;
  }

  String? validateSelectSemester(String value) {
    if (value.isEmpty) {
      return SELECT_SEMESTER_EMPTY;
    }
    return null;
  }

  String? validateSelectVenue(String? value) {
    if (value == null || value.isEmpty) {
      return SELECT_VENUE_EMPTY;
    }
    return null;
  }

  String? validateCapacity(int value) {
    if (value <= 0) {
      return 'Capacity must be greater than 0';
    }
    return null;
  }

  String? validateOrganizerInfo(String value) {
    if (value.isEmpty) {
      return 'Please provide organizer information';
    }
    return null;
  }

  String? validateAttendees(List<String> value) {
    if (value.isEmpty) {
      return 'Please specify attendees';
    }
    return null;
  }

  String? validateRegistrationLink(String value) {
    if (value.isEmpty) {
      return 'Please provide a registration link';
    }
    return null;
  }

  String? validateContactInfo(String value) {
    if (value.isEmpty) {
      return 'Please provide contact information';
    }
    return null;
  }

  String? validateEventType(String value) {
    if (value.isEmpty) {
      return 'Please specify the event type';
    }
    return null;
  }

  String? validateLocation(String value) {
    if (value.isEmpty) {
      return 'Please specify the location';
    }
    return null;
  }
}
