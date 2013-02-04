//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Marko Tadić on 1/11/13.
//  Copyright (c) 2013 Marko Tadić. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
    @property (nonatomic) BOOL userIsInTheMiddleOfEntereingANumber;
    @property (nonatomic, strong) CalculatorBrain *brain;
    - (void)logHistory:(NSString *)lastInput;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize description = _description;
@synthesize userIsInTheMiddleOfEntereingANumber = _userIsInTheMiddleOfEntereingANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    
    BOOL point = [digit isEqualToString:@"."];
    NSRange range = [self.display.text rangeOfString:@"."];
    BOOL alreadyHasPoint = range.length > 0;
    
    if (point) self.userIsInTheMiddleOfEntereingANumber = YES;
    
    if (self.userIsInTheMiddleOfEntereingANumber) {
        if (!point || !alreadyHasPoint) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEntereingANumber = YES;
    }
    
    [self logHistory:digit];
}

- (IBAction)enterPressed
{
   [self.brain pushOperand:[self.display.text doubleValue]];
   self.userIsInTheMiddleOfEntereingANumber = NO;
    
   [self logHistory:@" "];
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEntereingANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;

    [self logHistory:sender.currentTitle];
    [self logHistory:@" = "];
    
    if ([sender.currentTitle isEqualToString:@"+ / -"]) {
        [self logHistory:self.display.text];
        self.userIsInTheMiddleOfEntereingANumber = YES;
    }
}

- (void)logHistory:(NSString *)lastInput {
    self.description.text = [self.description.text stringByReplacingOccurrencesOfString:@" =" withString:@""];
    self.description.text = [self.description.text stringByAppendingString:lastInput];
}   

- (IBAction)resetPressed
{
    [self.brain resetBrain];
    self.display.text = @"0";
    self.description.text = @"";
    self.userIsInTheMiddleOfEntereingANumber = NO;
}

- (IBAction)deletePressed {
    if ( [self.display.text length] > 1) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
        self.description.text = [self.description.text substringToIndex:[self.description.text length] - 1];
    }
    else {
        self.display.text = @"0";
        self.description.text = @"";
        self.userIsInTheMiddleOfEntereingANumber = NO;
    }
}

@end