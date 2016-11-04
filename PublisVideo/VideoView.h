//
//  VideoView.h
//  PublisVideo
//
//  Created by wolianw003 on 16/8/4.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class VideoView;
@protocol VideoViewDelegate <NSObject>
@optional
- (void)videoViewWithCaptureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections;

- (void)videoViewWithCaptureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error;
@end

@interface VideoView : UIView

@property (nonatomic,assign)id<VideoViewDelegate> delegate;

- (void)startRecordingToOutputFileURL:(NSURL *)fileURL;

- (void)stopRecording;

@property (nonatomic,assign)BOOL isAppear;

@end
