//
//  PCCalBaseView+Private.h
//  Pods
//
//  Created by Pierre-David Bélanger on 16-10-01.
//
//

#import <Foundation/Foundation.h>

#import "PCCalBaseView.h"

@interface PCCalBaseView (Private)

- (void)animateWithDuration:(NSTimeInterval)duration out:(void (^)(void))animationsOut in:(void (^)(void))animationsIn;

@end
