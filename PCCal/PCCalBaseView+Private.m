//
//  PCCalBaseView+Private.m
//  Pods
//
//  Created by Pierre-David Bélanger on 16-10-01.
//
//

#import "PCCalBaseView+Private.h"

@implementation PCCalBaseView (Private)

- (void)animateWithDuration:(NSTimeInterval)duration out:(void (^)(void))animationsOut in:(void (^)(void))animationsIn {
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:animationsOut completion:nil];
    [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveEaseIn animations:animationsIn completion:nil];
}

@end
