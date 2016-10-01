//
//  PCCalView.h
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCCalBaseView.h"

@class PCCalView;

@protocol PCCalViewDataSource <NSObject>

@optional

- (NSString *)calView:(PCCalView *)calView titleForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate;

- (BOOL)calView:(PCCalView *)calView hasContentForDate:(NSDate *)date;

@end

@protocol PCCalViewDelegate <NSObject>

@optional

- (BOOL)calView:(PCCalView *)calView willChangeForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate;
- (void)calView:(PCCalView *)calView didChangeForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate;

- (BOOL)calView:(PCCalView *)calView willChangeForDate:(NSDate *)date;
- (void)calView:(PCCalView *)calView didChangeForDate:(NSDate *)date;

@end

@interface PCCalView : PCCalBaseView

@property (weak, readonly) UIButton *previousWeekButton;
@property (weak, readonly) UIButton *nextWeekButton;

@property (weak) IBOutlet id<PCCalViewDataSource> dataSource;
@property (weak) IBOutlet id<PCCalViewDelegate> delegate;

- (void)reloadData;

@end
