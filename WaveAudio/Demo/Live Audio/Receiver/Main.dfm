�
 TMAINFORM 0�  TPF0	TMainFormMainFormLeftTop� BorderIconsbiSystemMenu
biMinimize BorderStylebsSingleCaptionReceiver (Client)ClientHeight� ClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TButtonbtnDisconnectLeftTop� WidthaHeightCaption
DisconnectTabOrderVisibleOnClickbtnDisconnectClick  TButton
btnConnectLeftTop� WidthaHeightCaptionConnectTabOrderOnClickbtnConnectClick  	TGroupBoxgbBroadcasterLeftTopWidth Height~AnchorsakLeftakTopakRight Caption Broadcaster TabOrder  TLabellblRemoteAddressLeftTopWidth)HeightCaptionAddress:FocusControledRemoteAddress  TLabellblRemotePortLeft� TopWidthHeightAnchorsakTopakRight CaptionPort:FocusControlseRemotePort  TLabel	lblFormatLeftTopHWidthAHeightCaptionAudio Format:FocusControledFormat  TEditedRemoteAddressLeftTop(Width� HeightAnchorsakLeftakTopakRight TabOrder Text	localhost  	TSpinEditseRemotePortLeft� Top(WidthIHeightAnchorsakTopakRight MaxValue?B MinValueTabOrderValue�  TEditedFormatLeftTopXWidth� HeightTabStopAnchorsakLeftakTopakRight ParentColor	ReadOnly	TabOrder   TProgressBarpbLevelLeftpTop� Width� HeightBorderWidthMin MaxdTabOrder  TLiveAudioPlayerLiveAudioPlayer	PCMFormatnonePCMBufferInternallyBufferLengthdBufferCount

OnActivateLiveAudioPlayerActivateOnDeactivateLiveAudioPlayerDeactivateOnErrorLiveAudioPlayerErrorOnLevelLiveAudioPlayerLevelOnFormatLiveAudioPlayerFormat	OnDataPtrLiveAudioPlayerDataPtrLeftpTop  TClientSocket	tcpClientActive
ClientTypectNonBlockingPort 	OnConnecttcpClientConnectOnDisconnecttcpClientDisconnectOnReadtcpClientReadLeft� Top   