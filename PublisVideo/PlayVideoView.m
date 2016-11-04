 //
//  PlayVideoView.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/5.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "PlayVideoView.h"

@interface PlayVideoView()
@property (nonatomic,retain)AVPlayer *player;
@property (nonatomic,retain)AVPlayerLayer *playerLayer;
@property (nonatomic,retain)AVPlayerItem *playerItem;
@end

@implementation PlayVideoView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)playerDidEnd{
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}

- (void)setVideoURL:(NSURL *)videoURL{
    if (_videoURL != videoURL) {
        _videoURL = videoURL;
    }
    if (self.player == nil) {
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
        self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        self.player = [AVPlayer playerWithPlayerItem:_playerItem];
        self.player.volume = 0;
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        self.playerLayer.frame = self.bounds;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:self.playerLayer];
        [self.player play];
    }
}

@end
