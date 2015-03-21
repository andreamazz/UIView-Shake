//
//  UIView+Shake.m
//  UIView+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)shake:(int)times withDelta:(CGFloat)delta
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03 shakeDirection:ShakeDirectionHorizontal completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:ShakeDirectionHorizontal completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completionHandler:(void (^)(void))completionHandler
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection completionHandler:completionHandler];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completionHandler:(void (^)(void))completionHandler
{
	[UIView animateWithDuration:interval animations:^{
		self.layer.affineTransform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
	} completion:^(BOOL finished) {
		if(current >= times) {
			[UIView animateWithDuration:interval animations:^{
				self.layer.affineTransform = CGAffineTransformIdentity;
			} completion:^(BOOL finished){
				completionHandler();
			}];
			return;
		}
		[self _shake:(times - 1)
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			andSpeed:interval
	  shakeDirection:shakeDirection
   completionHandler:completionHandler];
	}];
}

@end
