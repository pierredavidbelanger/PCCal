//
//  PCCustomView.m
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import "PCCalBaseView.h"

@interface PCCalBaseView ()

@property (weak) IBOutlet UIView* contentView;

@end

@implementation PCCalBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    NSURL *bundleURL = [[NSBundle bundleForClass:[PCCalBaseView class]] URLForResource:@"PCCal" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    [bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.contentView];
    
    [self onViewInit];
}

- (void)onViewInit {
    self.calendar = [NSCalendar autoupdatingCurrentCalendar];
    self.date = [NSDate date];
}

- (NSDateFormatter *)dateFormatter:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = self.calendar;
    dateFormatter.timeZone = self.calendar.timeZone;
    dateFormatter.locale = self.calendar.locale;
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

@end
