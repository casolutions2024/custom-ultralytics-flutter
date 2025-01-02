import AVFoundation
import Flutter
import UIKit

// import Ultralytics

class FLNativeView: NSObject, FlutterPlatformView {
  private let previewView: UIView
  private let videoCapture: VideoCapture
  private var busy = false

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    videoCapture: VideoCapture
  ) {
    let screenSize: CGRect = UIScreen.main.bounds
    previewView = UIView(
      frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))

    self.videoCapture = videoCapture

    super.init()

    startCameraPreview(position: .back)
  }

  func view() -> UIView {
    return previewView
  }

  private func startCameraPreview(position: AVCaptureDevice.Position) {
      if !busy {
          busy = true

          videoCapture.setUp(sessionPreset: .photo, position: position) { success in
              if success {
                  // Add preview layer
                  if let previewLayer = self.videoCapture.previewLayer {
                      self.previewView.layer.addSublayer(previewLayer)
                      self.videoCapture.previewLayer?.frame = self.previewView.bounds
                  }

                  // Enable torch
                  if let device = AVCaptureDevice.default(for: .video) {
                      try? device.lockForConfiguration()
                      if device.hasTorch {
                          device.torchMode = .on
                      }
                      device.unlockForConfiguration()
                  }

                  self.videoCapture.start()
                  self.busy = false
              }
          }
      }
  }
}
