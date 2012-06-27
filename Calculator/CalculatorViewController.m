//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nil on May/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize stackDisplay = _stackDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if(!_brain)
        _brain = [[CalculatorBrain alloc] init];
    
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingFormat:[sender currentTitle]];
        self.stackDisplay.text = [self.stackDisplay.text stringByAppendingFormat:[sender currentTitle]];
    }
    else
    {
        self.display.text = sender.currentTitle;
        self.stackDisplay.text = [[self.stackDisplay.text stringByAppendingFormat:@" "] stringByAppendingFormat:[sender currentTitle]];
        
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    //self.stackDisplay.text = [[self.stackDisplay.text stringByAppendingFormat:[sender currentTitle]] stringByAppendingFormat:@" "];
}

- (IBAction)variablePressed:(UIButton *)sender 
{
    self.display.text = sender.currentTitle;
    self.stackDisplay.text = [[self.stackDisplay.text stringByAppendingFormat:@" "] stringByAppendingFormat:[sender currentTitle]];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    //If user is in the middle of typing a number, implicitly press Enter
    if(self.userIsInTheMiddleOfEnteringANumber)
        [self enterPressed];
    
    self.display.text = [NSString stringWithFormat:@"%g", [self.brain performOperation:[sender currentTitle]]];
    
    //The operation for pi is incorrect. If the value is stored on the stack, 
    //it will not be popped out and will be used by succeeding operation.
    if([[sender currentTitle] isEqualToString:@"sin"] ||
       [[sender currentTitle] isEqualToString:@"cos"] ||
       [[sender currentTitle] isEqualToString:@"√"]   ||
       [[sender currentTitle] isEqualToString:@"+/-"] ||
       [[sender currentTitle] isEqualToString:@"∏"])
        [self enterPressed];
    
    self.stackDisplay.text = [[self.stackDisplay.text stringByAppendingFormat:@" "] stringByAppendingFormat:[sender currentTitle]];
}

- (IBAction)decimalPressed:(UIButton *)sender 
{
    //If we already have a decimal in the result, do not reset decimal pressed
    NSRange range = [self.display.text rangeOfString:@"."];
    if(range.location == NSNotFound)
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.stackDisplay.text = [self.stackDisplay.text stringByAppendingFormat:@"."];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed 
{
    [self.brain clearStack];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    self.display.text = @"0";
    self.stackDisplay.text= @"";
}


- (void)viewDidUnload {
    [self setStackDisplay:nil];
    [super viewDidUnload];
}
@end
