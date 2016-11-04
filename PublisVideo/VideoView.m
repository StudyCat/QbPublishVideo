//
//  VideoView.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/4.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "VideoView.h"
#import "Masonry.h"

@interface VideoView()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic,retain)AVCaptureSession *captureSession;

@property (nonatomic,retain)AVCaptureDeviceInput *captureInPut;

@property (nonatomic,retain)AVCaptureMovieFileOutput *captureOutPut;

@property (nonatomic,retain)AVCaptureVideoPreviewLayer *preViewLayer;

@end

@implementation VideoView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCapture];
    }
    return self;
}

#pragma mark - private method
- (void)initCapture{
    [self.captureSession addInput:self.captureInPut];
    
    [self.captureSession addOutput:self.captureOutPut];
    
    [self.layer addSublayer:self.preViewLayer];
    self.preViewLayer.frame = self.bounds;
}

#pragma mark - public method
- (void)startRecordingToOutputFileURL:(NSURL *)fileURL{
    [self.captureOutPut startRecordingToOutputFileURL:fileURL recordingDelegate:self];
}

- (void)stopRecording{
    [self.captureOutPut stopRecording];
}

#pragma mark - getter & setter
- (void)setIsAppear:(BOOL)isAppear{
    if (isAppear) {
        [self.captureSession startRunning];
    }else{
        [self.captureSession stopRunning];
    }
}

- (AVCaptureDeviceInput *)captureInPut{
    if (!_captureInPut) {
        NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *camera in cameras) {
            if (camera.position == AVCaptureDevicePositionBack) {
                _captureInPut = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:nil];
            }
        }
    }
    return _captureInPut;
}

- (AVCaptureMovieFileOutput *)captureOutPut{
    if (!_captureOutPut) {
        _captureOutPut = [[AVCaptureMovieFileOutput alloc] init];
    }
    return _captureOutPut;
}

- (AVCaptureVideoPreviewLayer *)preViewLayer{
    if (!_preViewLayer) {
        _preViewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        _preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _preViewLayer;
}

- (AVCaptureSession *)captureSession{
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
        _captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    }
    return _captureSession;
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    if ([self.delegate respondsToSelector:@selector(videoViewWithCaptureOutput:didStartRecordingToOutputFileAtURL:fromConnections:)]) {
        [self.delegate videoViewWithCaptureOutput:captureOutput didStartRecordingToOutputFileAtURL:fileURL fromConnections:connections];
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(videoViewWithCaptureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:)]) {
        [self.delegate videoViewWithCaptureOutput:captureOutput didFinishRecordingToOutputFileAtURL:outputFileURL fromConnections:connections error:error];
    }
}

@end
