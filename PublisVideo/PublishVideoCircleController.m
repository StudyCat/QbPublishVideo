//
//  PublishVideoCircleController.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/5.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "PublishVideoCircleController.h"
#import "PlayVideoView.h"

@interface PublishVideoCircleController ()

@property (nonatomic,retain)PlayVideoView *playVideoView;

@end

@implementation PublishVideoCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playVideoView.frame = CGRectMake(0, 20, 375, 400);
    self.playVideoView.videoURL = self.fileURL;
    [self.view addSubview:self.playVideoView];
}

#pragma mark - getter & setter
- (PlayVideoView *)playVideoView{
    if (!_playVideoView) {
        _playVideoView = [[PlayVideoView alloc] init];
    }
    return _playVideoView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
