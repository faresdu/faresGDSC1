import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
Member member = Member(id: '443', sID: '12345', name: 'fares',committee: Committee(id: '443', name: 'Tech',coLeaderID: '4321',leaderID: '3123'));
  String fares(){
    return 'Profile name';
  }
  getProfileInfo(){
    return member;
  }
  String getCommitteeStatus(){
    if(member.committee?.leaderID == member.id){
      return 'leader of Tech';
    }else if(member.committee?.coLeaderID == member.id){
      return 'Co-Leader of Tech';
    }else{
      return 'member of Tech';
    }
  }
}
