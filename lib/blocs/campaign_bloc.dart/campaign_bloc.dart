// import 'package:flutter_wawinner/blocs/campaign_bloc.dart/medicines_state.dart';
// import 'package:meta/meta.dart';
// import 'package:bloc/bloc.dart';

// import 'medicines_event.dart';

// class CampaignsBloc extends Bloc<CampaignEvent, CampaignState> {
//   final MedicineApi medicineApi;
//   List<Medicine> medss = [];

//   MedicineBloc({@required this.medicineApi})
//       : assert(medicineApi != null),
//         super(MedicineInitial());

//   @override
//   Stream<MedicineState> mapEventToState(MedicineEvent event) async* {
//     if (event is MedicinesRequested) {
//       yield MedicinesLoadInProgress();
//       try {
//         List<Medicine> mds = await medicineApi.getMedicines(event.cnt);
//         medss = mds;
//         yield MedicinesLoadSuccess(mds: mds, isMore: true);
//       } catch (_) {
//         yield MedicinesLoadFailure();
//       }
//     } else if (event is SeeMore) {
//       try {
//         List<Medicine> mds = await medicineApi.getMedicines(event.cnt);
//         print(mds.length);
//         if (mds.length == 0) {
//           medss = mds;
//           yield MedicinesLoadSuccess(
//               mds: ((state as MedicinesLoadSuccess).mds + mds), isMore: false);
//         } else {
//           medss += mds;
//           yield MedicinesLoadSuccess(mds: medss, isMore: true);
//         }
//       } catch (_) {
//         yield MedicinesLoadFailure();
//       }
//     } else if (event is MedicinePackages) {
//       try {
//         List<Package> pkgs = await medicineApi.getPackages(event.ids);

//         yield MedicinePackagesLoadSuccess(pkgs: pkgs);
//       } catch (_) {
//         yield MedicinesLoadFailure();
//       }
//     } else if (event is AddToCart) {
//       yield MedicinesLoadInProgress();

//       try {
//         List<Distributer> dists = await medicineApi.isAvilable(event.data);

//         if (dists.length > 0) {
//           CartMedicine cm = CartMedicine(
//               id: event.medicine.id,
//               image: event.medicine.image,
//               name: event.medicine.name,
//               price: event.medicine.price,
//               is_package: '0',
//               distributers: dists);

//           await Cart.addMedicine(cm);
//         }

//         yield AddToCartResponse(dists: dists, id: event.medicine.id);
//       } catch (_) {
//         yield MedicinesLoadFailure();
//       }
//     } else if (event is AddPkgMdsToCart) {
//       yield MedicinesLoadInProgress();

//       try {
//         List<Distributer> dists = await medicineApi.isAvilable(event.data);

//         if (dists.length > 0) {
//           CartMedicine cm = CartMedicine(
//               id: event.medicine.id,
//               image: event.medicine.image,
//               name: event.medicine.name,
//               price: event.medicine.price,
//               is_package: '0',
//               distributers: dists);

//           await Cart.addMedicine(cm);
//         }
//         yield AddToCartResponse(dists: dists);
//       } catch (_) {
//         yield MedicinesLoadFailure();
//       }
//     }
//   }
// }
