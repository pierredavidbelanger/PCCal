//
//  PCCalView.m
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import "PCCalView.h"

#import "PCCalDayView.h"
#import "PCCalBaseView+Private.h"

@interface PCCalView () <PCCalDayViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *previousWeekButton;
@property (weak, nonatomic) IBOutlet UIButton *nextWeekButton;

@property (strong, nonatomic) IBOutletCollection(PCCalDayView) NSArray *dayViews;

@property (strong) NSDate *reloadedDate;

@end

@implementation PCCalView

- (void)onViewInit {
    [super onViewInit];
    self.reloadedDate = [NSDate distantPast];
}

- (void)layoutSubviews {
    [self reloadData];
}

- (void)onDaySelected:(PCCalDayView *)dayView {
    self.date = dayView.date;
    [self reloadData];
}

- (IBAction)onWeekNavTouch:(UIButton *)sender {
    
    NSDateComponents *oneWeekComponent = [[NSDateComponents alloc] init];
    oneWeekComponent.weekOfYear = sender.tag;
    
    NSDate *date = [self.calendar dateByAddingComponents:oneWeekComponent toDate:self.date options:NSCalendarMatchNextTimePreservingSmallerUnits];
    
    [self animateWithDuration:0.15 out:^{
        self.titleLabel.alpha = 0.0;
    } in:^{
        self.titleLabel.alpha = 1.0;
    }];
    
    self.date = date;
    [self reloadData];
}

- (void)reloadData {
    
    BOOL sameDay = [self is:self.reloadedDate onSameDay:self.date];
    BOOL sameWeek = [self is:self.reloadedDate onSameWeek:self.date];
    
    NSDate *firstDateOfWeek;
    NSTimeInterval oneWeekInterval;
    [self.calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&firstDateOfWeek interval:&oneWeekInterval forDate:self.date];
    NSDate *lastDateOfWeek = [firstDateOfWeek dateByAddingTimeInterval:oneWeekInterval - 1];
    
    if (!sameWeek) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(calView:willChangeForWeekBetween:and:)]) {
            if (![self.delegate calView:self willChangeForWeekBetween:firstDateOfWeek and:lastDateOfWeek]) {
                return;
            }
        }
    }
    
    if (!sameDay) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(calView:willChangeForDate:)]) {
            if (![self.delegate calView:self willChangeForDate:self.date]) {
                return;
            }
        }
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(calView:titleForWeekBetween:and:)]) {
        self.titleLabel.text = [self.dataSource calView:self titleForWeekBetween:firstDateOfWeek and:lastDateOfWeek];
    } else {
        NSDateFormatter *yearFormatter = [self dateFormatter:@"yyyy"];
        NSDateFormatter *dateFormatter = [self dateFormatter:@"MMM d"];
        self.titleLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",
                                [yearFormatter stringFromDate:firstDateOfWeek],
                                [dateFormatter stringFromDate:firstDateOfWeek],
                                [dateFormatter stringFromDate:lastDateOfWeek]];
    }
    
    for (PCCalDayView *dayView in self.dayViews) {
        
        NSDateComponents *oneDayComponent = [[NSDateComponents alloc] init];
        oneDayComponent.day = dayView.tag;
        
        NSDate *date = [self.calendar dateByAddingComponents:oneDayComponent toDate:firstDateOfWeek options:NSCalendarMatchNextTimePreservingSmallerUnits];
        
        dayView.calendar = self.calendar;
        dayView.date = date;
        
        dayView.selected = [self is:self.date onSameDay:date];
        
        dayView.hasContent = self.dataSource && [self.dataSource respondsToSelector:@selector(calView:hasContentForDate:)] && [self.dataSource calView:self hasContentForDate:date];
        
        [dayView reloadData];
    }
    
    self.reloadedDate = self.date;
    
    if (!sameDay) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(calView:didChangeForDate:)]) {
            [self.delegate calView:self didChangeForDate:self.date];
        }
    }
    
    if (!sameWeek) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(calView:didChangeForWeekBetween:and:)]) {
            [self.delegate calView:self didChangeForWeekBetween:firstDateOfWeek and:lastDateOfWeek];
        }
    }
}

- (BOOL)is:(NSDate *)date1 onSameWeek:(NSDate *)date2 {
    
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitWeekOfYear;
    
    NSDateComponents *dateComponents1 = [self.calendar components:units fromDate:date1];
    NSDateComponents *dateComponents2 = [self.calendar components:units fromDate:date2];
    
    if (dateComponents1.year != dateComponents2.year) {
        return NO;
    }
    if (dateComponents1.weekOfYear != dateComponents2.weekOfYear) {
        return NO;
    }
    return YES;
}

- (BOOL)is:(NSDate *)date1 onSameDay:(NSDate *)date2 {
    
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponents1 = [self.calendar components:units fromDate:date1];
    NSDateComponents *dateComponents2 = [self.calendar components:units fromDate:date2];
    
    if (dateComponents1.year != dateComponents2.year) {
        return NO;
    }
    if (dateComponents1.month != dateComponents2.month) {
        return NO;
    }
    if (dateComponents1.day != dateComponents2.day) {
        return NO;
    }
    return YES;
}

@end
