//
//  PCCustomView.h
//  PCCal
//
//  Created by Pierre-David Bélanger on 16-09-30.
//  Copyright © 2016 PjEr.ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCCalBaseView : UIView

@property (strong) NSCalendar *calendar;
@property (strong) NSDate *date;

- (void)onViewInit;

- (NSDateFormatter *)dateFormatter:(NSString *)dateFormat;

@end
