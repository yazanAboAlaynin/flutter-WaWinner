import 'package:http/http.dart';

import 'api.dart';
import 'package:meta/meta.dart';

class CampaignApi extends Api {
  final Client httpClient;

  CampaignApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  // Future<List<Medicine>> getMedicines(cnt) async {
  //   final url = '${Api.baseUrl}/rest/medicines/$cnt';

  //   final response =
  //       await this.httpClient.get(url, headers: await getHeaders());

  //   var res = jsonDecode(response.body)["data"] as List;

  //   List<Medicine> mds = res.map((dynamic i) => Medicine.fromJson(i)).toList();
  //   return mds;
// }
}
