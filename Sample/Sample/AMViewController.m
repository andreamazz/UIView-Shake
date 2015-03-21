//
//  AMViewController.m
//  Sample
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMViewController.h"
#import "UIView+Shake.h"

@interface AMViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textShakes;
@property (weak, nonatomic) IBOutlet UITextField *textSpeed;
@property (weak, nonatomic) IBOutlet UITextField *textDelta;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shakeDirection;

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Demo"];
    [@[_textDelta, _textShakes, _textSpeed] enumerateObjectsUsingBlock:^(UITextField* obj, NSUInteger idx, BOOL *stop) {
        [obj.layer setBorderWidth:2];
        [obj.layer setBorderColor:[UIColor colorWithRed:107.0/255.0 green:150.0/255.0 blue:199.0/255.0 alpha:1].CGColor];
        [obj setDelegate:self];
    }];
    [self.shakeDirection.layer setBorderWidth:2];
    [self.shakeDirection.layer setBorderColor:self.shakeDirection.tintColor.CGColor];
    self.shakeDirection.selectedSegmentIndex = 0;
}

- (IBAction)actionShake:(id)sender
{
    [self shake];
}

- (void)shake
{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj shake:[self.textShakes.text intValue]
         withDelta:[self.textDelta.text floatValue]
          andSpeed:[self.textSpeed.text floatValue]
    shakeDirection:(self.shakeDirection.selectedSegmentIndex == 0) ? ShakeDirectionHorizontal : ShakeDirectionVertical completionHandler:^{
        NSLog(@"done!");
    }];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

@end
