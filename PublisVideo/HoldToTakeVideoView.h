//
//  HoldToTakeVideoView.h
//  PublisVideo
//
//  Created by wolianw003 on 16/8/4.
//  Copyright © 2016年 wolianw003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoldToTakeVideoView : UIView

@property (copy)void (^longPressStateBegan)();

@property (copy)void (^longPressStateEnd)();

@property (copy)void (^longPressStateCancelledOrFailed)();
@end
