//
//  TakeVideoProgressView.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/5.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "TakeVideoProgressView.h"
@interface TakeVideoProgressView()

@property (nonatomic,retain)UIView *progressView;

@end
@implementation TakeVideoProgressView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressView.frame = self.bounds;
        [self addSubview:self.progressView];
    }
    return self;
}

#pragma mark - getter & setter
- (UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor greenColor];
    }
    return _progressView;
}

- (void)setProgress:(CGFloat)progress{
    CGFloat startWidth = CGRectGetWidth(self.frame);
    CGFloat width = startWidth * progress;
    self.progressView.frame = CGRectMake(0, 0, width, 3);
    self.progressView.center = CGPointMake(startWidth/2.0, 1.5);
}

@end
