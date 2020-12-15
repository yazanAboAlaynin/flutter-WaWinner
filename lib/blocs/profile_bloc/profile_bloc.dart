import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/currency.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:flutter_wawinner/repositories/profile_api.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileApi profileApi;

  ProfileBloc({@required this.profileApi})
      : assert(profileApi != null),
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileRequested) {
      yield ProfileLoadInProgress();
      try {
      User user = await profileApi.profile();
      List<Currency> c = await profileApi.currences();

      yield ProfileLoadSuccess(user: user, currencies: c);
      } catch (_) {
      yield ProfileLoadFailure();
      }
    } else if (event is UpdateProfileRequested) {
      yield ProfileLoadInProgress();
      try {
        User user = await profileApi.updateProfile(event.id, event.data);

        yield ProfileLoadSuccess(user: user,currencies: null);
      } catch (_) {
        yield ProfileLoadFailure();
      }
    } else if (event is ChangePasswordRequested) {
      yield ProfileLoadInProgress();
      try {
        bool st = await profileApi.changePassword(event.data);
        if (st) {
          yield ChangePasswordSccess();
        } else {
          yield ChangePasswordFaield();
        }
      } catch (_) {
        yield ProfileLoadFailure();
      }
    } else if (event is ContactUsRequested) {
      yield ProfileLoadInProgress();
      try {
        bool st = await profileApi.contactUs(event.data);
        if (st) {
          yield MessageSent();
        } else {
          yield MessageFaield();
        }
      } catch (_) {
        yield ProfileLoadFailure();
      }
    } else if (event is AboutUsRequested) {
      yield ProfileLoadInProgress();
      try {
        String st = await profileApi.aboutUs();
        yield AboutUsLoadSuccess(text: st);
      } catch (_) {
        yield ProfileLoadFailure();
      }
    }
  }
}
