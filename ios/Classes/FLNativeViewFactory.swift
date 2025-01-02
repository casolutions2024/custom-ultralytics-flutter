//
//  FLNativeViewFactory.swift
//  ultralytics_yolo
//
//  Created by Sergio Sánchez on 9/11/23.
//

import Flutter

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var videoCapture: VideoCapture

    init(videoCapture: VideoCapture) {
        self.videoCapture = videoCapture
        super.init()
    }

    deinit {
        videoCapture.cleanup()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let newVideoCapture = VideoCapture()
        return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: args, videoCapture: newVideoCapture)
    }
}

//class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
//  private let videoCapture: VideoCapture
//
//  init(videoCapture: VideoCapture) {
//    self.videoCapture = videoCapture
//    super.init()
//  }
//
//  func create(
//    withFrame frame: CGRect,
//    viewIdentifier viewId: Int64,
//    arguments args: Any?
//  ) -> FlutterPlatformView {
//    return FLNativeView(
//      frame: frame,
//      viewIdentifier: viewId,
//      arguments: args,
//      videoCapture: videoCapture
//    )
//  }
//}
