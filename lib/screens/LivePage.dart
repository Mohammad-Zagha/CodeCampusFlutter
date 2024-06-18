import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/classes/UserService.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatelessWidget {
  const LivePage({Key? key, required this.liveID,required this.userId, this.isHost = false,required this.name})
      : super(key: key);

  final String liveID,userId,name;
  final bool isHost;

  @override
  Widget build(BuildContext context) {

    List<IconData> customIcons = [
      Icons.cookie,
      Icons.phone,
      Icons.speaker,
      Icons.air,
      Icons.blender,
      Icons.file_copy,
      Icons.place,
      Icons.phone_android,
      Icons.phone_iphone,
    ];

    return ZegoUIKitPrebuiltLiveStreaming(
      appID: 1584986389,
      appSign: "a1e83efbeb47e90c07bbb9ceefb0d4ab227b05107673101be55c5cc2507b41c2",
      userID: userId,
      userName: '${name}_$userId',
      liveID: liveID,

      // Modify your custom configurations here.
      config: isHost
          ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
          : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
        ..bottomMenuBar = ZegoLiveStreamingBottomMenuBarConfig(
          maxCount: 5,
          hostButtons: [
            ZegoLiveStreamingMenuBarButtonName.switchCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton,
            ZegoLiveStreamingMenuBarButtonName.toggleScreenSharingButton
          ],
          hostExtendButtons: customIcons
              .map(
                (customIcon) => ZegoLiveStreamingMenuBarExtendButton(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(40, 40),
                  shape: const CircleBorder(),
                  primary: const Color(0xff2C2F3E).withOpacity(0.6),
                ),
                onPressed: () {},
                child: Icon(customIcon),
              ),
            ),
          )
              .toList(),
          coHostButtons: [
            ZegoLiveStreamingMenuBarButtonName.switchCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleCameraButton,
            ZegoLiveStreamingMenuBarButtonName.toggleMicrophoneButton,
            ZegoLiveStreamingMenuBarButtonName.coHostControlButton,
            ZegoLiveStreamingMenuBarButtonName.toggleScreenSharingButton
          ],
        ),
    );
  }
}