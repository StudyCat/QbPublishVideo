//
//  ViewController.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/4.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "TakeCircleVideoController.h"
#import "VideoView.h"
#import "Masonry.h"
#import "HoldToTakeVideoView.h"
#import "PublishVideoCircleController.h"
#import "TakeVideoProgressView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TakeCircleVideoController ()<VideoViewDelegate>

@property (nonatomic,retain)VideoView *videoView;

@property (nonatomic,retain)TakeVideoProgressView *progressView;

@property (nonatomic,retain)NSTimer *timer;

@property (nonatomic,retain)HoldToTakeVideoView *holdView;

@property (nonatomic,assign)BOOL isEndRecord;

@property (nonatomic,retain)NSURL *fileURL;

@property (nonatomic,retain)UILabel *alertLabel;

@end

@implementation TakeCircleVideoController{
    CGFloat time;
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    [self.view addSubview:self.videoView];
    
    [self.view addSubview:self.progressView];
    
    [self.view addSubview:self.holdView];
    
    [self.view addSubview:self.alertLabel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.videoView.isAppear = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.videoView.isAppear = NO;
}

#pragma mark - target action
- (void)progressChange{
    time ++;
    self.progressView.progress = (1 - time / 800);
    if (time == 800) {
        [self.timer invalidate];
        self.timer = nil;
        [self.videoView stopRecording];
        self.isEndRecord = YES;
    }
}

#pragma mark - getter & setter
- (NSURL *)fileURL{
    if (!_fileURL) {
        NSString *filePath = [NSString stringWithFormat:@"%@/Library/circle.mp4",NSHomeDirectory()];
        _fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
    }
    return _fileURL;
}

- (NSTimer *)timer{
    if(!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (TakeVideoProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[TakeVideoProgressView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2.0, SCREEN_WIDTH, 3)];
        _progressView.hidden = YES;
    }
    return _progressView;
}

- (VideoView *)videoView{
    if (!_videoView) {
        _videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0 - 64.f)];
        _videoView.delegate = self;
    }
    return _videoView;
}

- (HoldToTakeVideoView *)holdView{
    if (!_holdView) {
        _holdView = [[HoldToTakeVideoView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2.0 + 3.f, SCREEN_WIDTH, SCREEN_HEIGHT / 2.0 - 3.f)];
        __weak TakeCircleVideoController *weakSelf = self;
        [_holdView setLongPressStateEnd:^{
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            [weakSelf.videoView stopRecording];
            weakSelf.isEndRecord = YES;
        }];
        [_holdView setLongPressStateBegan:^{
            [weakSelf.videoView startRecordingToOutputFileURL:weakSelf.fileURL];
        }];
        [_holdView setLongPressStateCancelledOrFailed:^{
            [weakSelf.videoView stopRecording];
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            weakSelf.progressView.progress = 1;
            weakSelf.progressView.hidden = YES;
            weakSelf.alertLabel.hidden = YES;
        }];
    }
    return _holdView;
}

- (UILabel *)alertLabel{
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2.0 - 40, SCREEN_WIDTH, 20)];
        _alertLabel.text = @"上移取消";
        _alertLabel.textColor = [UIColor greenColor];
        _alertLabel.font = [UIFont systemFontOfSize:14.f];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.hidden = YES;
    }
    return _alertLabel;
}

#pragma mark - VideoViewDelegate
- (void)videoViewWithCaptureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    _alertLabel.hidden = NO;
    self.progressView.hidden = NO;
    time = 0;
    [self.timer fire];
}

- (void)videoViewWithCaptureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    if (self.isEndRecord) {
        PublishVideoCircleController *publishVC = [[PublishVideoCircleController alloc] init];
        publishVC.fileURL = outputFileURL;
        [self presentViewController:publishVC animated:YES completion:nil];
    }
}

@end


