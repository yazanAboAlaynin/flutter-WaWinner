import 'package:flutter_wawinner/models/campaign.dart';
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


        yield ProfileLoadSuccess(user: user);
      } catch (_) {
        yield ProfileLoadFailure();
      }
    }
  }
}
