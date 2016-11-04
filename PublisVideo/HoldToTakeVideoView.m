//
//  HoldToTakeVideoView.m
//  PublisVideo
//
//  Created by wolianw003 on 16/8/4.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import "HoldToTakeVideoView.h"

@interface  HoldToTakeVideoView()

@property (nonatomic,retain)UILabel *titleLabel;

@property (nonatomic,retain)UIView *inductionView;

@end

@implementation HoldToTakeVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat widthOfSelf = CGRectGetWidth(self.bounds);
    CGFloat heightOfSelf = CGRectGetHeight(self.bounds);
    CGFloat width = widthOfSelf / 2.f;
    self.titleLabel.frame = CGRectMake(width / 2.0, (heightOfSelf - width) / 2.0, width, width);
    self.titleLabel.layer.cornerRadius = width / 2.0;
    self.titleLabel.layer.masksToBounds = YES;
    [self addSubview:self.titleLabel];
    
    self.inductionView.frame = self.titleLabel.frame;
    [self addSubview:self.inductionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
}

#pragma mark - target action
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    CGPoint point = [longPress locationInView:self.inductionView];
    if (point.x >= 0 && point.x <= CGRectGetWidth(self.inductionView.frame) && point.y >= 0 && point.y <= CGRectGetHeight(self.inductionView.frame)) {
        if (longPress.state == UIGestureRecognizerStateBegan) {
            if (self.longPressStateBegan) {
                self.longPressStateBegan();
            }
        }else if (longPress.state == UIGestureRecognizerStateEnded){
            if (self.longPressStateEnd) {
                self.longPressStateEnd();
            }
        }else if (longPress.state == UIGestureRecognizerStateCancelled ||longPress.state == UIGestureRecognizerStateFailed){
            if (self.longPressStateCancelledOrFailed) {
                self.longPressStateCancelledOrFailed();
            }
        }
    }else{
        if (self.longPressStateCancelledOrFailed) {
            self.longPressStateCancelledOrFailed();
        }
    }
    
}

#pragma mark - getter & setter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"按住拍";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor greenColor];
        _titleLabel.layer.borderColor = [UIColor greenColor].CGColor;
        _titleLabel.layer.borderWidth = 1.f;
        _titleLabel.font = [UIFont systemFontOfSize:20.f];
    }
    return _titleLabel;
}

- (UIView *)inductionView{
    if (!_inductionView) {
        _inductionView = [[UIView alloc] init];
    }
    return _inductionView;
}


@end
