//
//  PCCalDayView.m
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import "PCCalDayView.h"

#import "PCCalBaseView+Private.h"

@interface PCCalDayView ()

@property (weak, nonatomic) IBOutlet UILabel *dayNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *dayButton;
@property (weak, nonatomic) IBOutlet UIView *selectionIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *contentIndicatorView;

@end

@implementation PCCalDayView

- (void)onViewInit {
    [super onViewInit];
    self.selected = NO;
    self.hasContent = NO;
}

- (void)layoutSubviews {
    [self reloadData];
}

- (IBAction)onTouch:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDaySelected:)]) {
        [self.delegate onDaySelected:self];
    }
}

- (void)reloadData {
    
    BOOL large = self.bounds.size.width >= 75;
    
    [self animateWithDuration:0.15 out:^{
        if (!self.selected) {
            self.selectionIndicatorView.alpha = 0.0;
        }
        if (!self.hasContent) {
            self.contentIndicatorView.alpha = 0.0;
        }
    } in:^{
        if (self.selected) {
            self.selectionIndicatorView.alpha = 1.0;
        }
        if (self.hasContent) {
            self.contentIndicatorView.alpha = 1.0;
        }
    }];
    
    NSDateFormatter *dayNameFormatter = [self dateFormatter:large ? @"EEEE" : @"EEE"];
    self.dayNameLabel.text = [dayNameFormatter stringFromDate:self.date];
    
    NSDateFormatter *dayFormatter = [self dateFormatter:@"d"];
    [self.dayButton setTitle:[dayFormatter stringFromDate:self.date] forState:UIControlStateNormal];
    UIColor *titleColor = self.selected ? [UIColor lightTextColor] : [UIColor darkTextColor];
    [self.dayButton setTitleColor:titleColor forState:UIControlStateNormal];
    
    self.dayButton.enabled = !self.selected;
}

@end
