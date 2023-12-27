import 'package:flutter/cupertino.dart';
import 'package:live_stream_app/constants/zego_env.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class VideoChatWidget extends StatelessWidget {
  final String userIdentity;
  final String livename;
  const VideoChatWidget({Key? key, this.isHost = false, required this.userIdentity, required this.livename}) : super(key: key);
  final bool isHost;


  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveStreaming(
      appID: appID,
      appSign: appSign,
      userID: userIdentity,
      userName: livename,
      liveID: 'testLiveID',
      config: isHost
          ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
          : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
        ..bottomMenuBarConfig.showInRoomMessageButton=false,

    );
  }
}