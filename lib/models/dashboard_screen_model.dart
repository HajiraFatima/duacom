// ignore_for_file: unnecessary_this

class DashboardModel {
  String selectedAccount = '';
  String msisdn = '';
  String customerName = '';
  String amount = '';
  String trxId = '';
  String date = '';
  String time = '';
  String network='';

  DashboardModel({
    required this.selectedAccount,
    required this.msisdn,
    required this.customerName,
    required this.amount,
    required this.trxId,
    required this.date,
    required this.time,
    required this.network,
  });

  DashboardModel.fromJson(Map<String, dynamic> json) {
    selectedAccount = json['selectedAccount']??'';
    msisdn = json['msisdn']??'';
    customerName = json['customerName']??'';
    amount = json['amount'];
    trxId = json['trxId']??'';
    date = json['date']??'';
    time = json['time']??'';
    network = json['network']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['selectedAccount'] = this.selectedAccount;
    data['msisdn'] = this.msisdn;
    data['customerName'] = this.customerName;
    data['amount'] = this.amount;
    data['trxId'] = this.trxId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['network'] = this.network;
    return data;
  }

  @override
  String toString() {
    return 'DashboardModel{selectedAccount: $selectedAccount, msisdn: $msisdn, customerName: $customerName, amount: $amount, trxId: $trxId, date:$date,time:$time,network:$network}';
  }
}
