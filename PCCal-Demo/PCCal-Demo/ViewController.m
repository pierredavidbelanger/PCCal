//
//  ViewController.m
//  PCCal-Demo
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import "ViewController.h"

#import <PCCal/PCCal.h>

@interface ViewController () <PCCalViewDataSource, PCCalViewDelegate>

@property (weak, nonatomic) IBOutlet PCCalView *calView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"fr_CA"];
    self.calView.calendar = calendar;
    self.calView.tintColor = [UIColor purpleColor];
}

- (NSString *)calView:(PCCalView *)calView titleForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate {
    return [NSString stringWithFormat:@"%@", [[calView dateFormatter:@"MMMM d"] stringFromDate:firstDate]];
}

- (BOOL)calView:(PCCalView *)calView hasContentForDate:(NSDate *)date {
    return [calView.calendar component:NSCalendarUnitDay fromDate:date] % 2 == 0;
}

- (BOOL)calView:(PCCalView *)calView willChangeForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate {
    return YES;
}

- (void)calView:(PCCalView *)calView didChangeForWeekBetween:(NSDate *)firstDate and:(NSDate *)lastDate {
    NSLog(@"didChangeForWeekBetween:%@ and:%@", firstDate, lastDate);
}

- (BOOL)calView:(PCCalView *)calView willChangeForDate:(NSDate *)date {
    return [calView.calendar component:NSCalendarUnitDay fromDate:date] != 5;
}

- (void)calView:(PCCalView *)calView didChangeForDate:(NSDate *)date {
    NSLog(@"didChangeForDate:%@", date);
}

@end
