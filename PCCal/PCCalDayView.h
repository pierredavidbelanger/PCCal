//
//  PCCalDayView.h
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCCalBaseView.h"

@class PCCalDayView;

@protocol PCCalDayViewDelegate <NSObject>

@optional

- (void)onDaySelected:(PCCalDayView *)dayView;

@end

@interface PCCalDayView : PCCalBaseView

@property (weak) IBOutlet id<PCCalDayViewDelegate> delegate;

@property BOOL selected;
@property BOOL hasContent;

- (void)reloadData;

@end
