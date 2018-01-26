//
//  UIView+Shake.m
//  UIView+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)shake {
    [self shake:5 withDelta:5 speed:0.03];
}

- (void)shake:(int)times withDelta:(CGFloat)delta {
    [self shake:times withDelta:delta completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler {
    [self shake:times withDelta:delta speed:0.03 completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self shake:times withDelta:delta speed:interval completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler {
    [self shake:times withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection {
    [self shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(nullable void (^)(void))completion {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection initialTransform:self.layer.affineTransform completion:completion];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection initialTransform:(CGAffineTransform)initialTransform completion:(void (^)(void))completionHandler {
    __weak UIView *weakSelf = self;
	[[self class] _animateWithDuration:interval animations:^{
        CGAffineTransform adjustmentTransform;
        switch (shakeDirection) {
            case ShakeDirectionVertical:
                adjustmentTransform = CGAffineTransformMakeTranslation(0, delta * direction);
                break;
            case ShakeDirectionRotation:
                adjustmentTransform = CGAffineTransformMakeRotation(M_PI * delta / 1000.0f * direction);
                break;
            case ShakeDirectionHorizontal:
                adjustmentTransform = CGAffineTransformMakeTranslation(delta * direction, 0);
            default:
                break;
        }
        self.layer.affineTransform = CGAffineTransformConcat(initialTransform, adjustmentTransform);
	} completion:^(BOOL finished) {
		if(current >= times) {
			[[self class] _animateWithDuration:interval animations:^{
				weakSelf.layer.affineTransform = initialTransform;
			} completion:^(BOOL finished){
				if (completionHandler != nil) {
					completionHandler();
				}
			}];
			return;
		}
		[weakSelf _shake:times
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			   speed:interval
	  shakeDirection:shakeDirection
    initialTransform:initialTransform
          completion:completionHandler];
	}];
}

// Helper method to animate with a keyframe. This prevents a "jump" when animating views that have already been transformed
+ (void)_animateWithDuration:(NSTimeInterval)duration animations:(nonnull void (^)(void))animations completion:(nullable void (^)(BOOL finished))completion {
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:animations];
    } completion:completion];
}

@end
