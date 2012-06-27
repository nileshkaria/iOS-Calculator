//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Nil on May/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *programStack;

@end


@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray*) programStack
{
    if(!_programStack)
        _programStack = [[NSMutableArray alloc] init];
    
    return _programStack;
}

- (void) pushOperand:(double) operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double) popOperand
{
    NSNumber * operandObject = [self.programStack lastObject];
    
    if(operandObject)
        [self.programStack removeLastObject];
    
    return [operandObject doubleValue];
}

- (void) clearStack
{
    [self.programStack removeAllObjects];
}

- (double) performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
    return [self.programStack copy];
}

//Add dictionaryWithObjectsAndKeys: for 3e

+ (BOOL) isOperation:(NSString *)operation
{
    return YES;
}

+ (NSString *) descriptionOFTopOfStack:(NSMutableArray *)stack
{
    return nil;
}

+ (NSString * ) descriptionOfProgram:(id)program
{
    //No operand operation
    //One operand operation
    //Two operand operation
    //Variable
    //(Try helpers with NSSet containsObject)
    return @"Write Assignment 2 code here";
}

// Change to use variables
+ (double) popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;   
    
    id topOfStack = [stack lastObject];
    
    if(topOfStack)
        [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        
        //perform operation details
        if([operation isEqualToString:@"+"])
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if([@"*" isEqualToString:operation])
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if([operation isEqualToString:@"-"])
        {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        }
        else if([operation isEqualToString:@"+/-"])
        {
            result = [self popOperandOffStack:stack];
            
            if(result != 0)
                result *= -1;
        }
        else if([operation isEqualToString:@"/"])
        {
            double divisor = [self popOperandOffStack:stack];
            
            if(divisor)
                result = [self popOperandOffStack:stack] / divisor;
        }
        else if([operation isEqualToString:@"sin"])
        {
            result = sin([self popOperandOffStack:stack]);
        }
        else if([operation isEqualToString:@"cos"])
        {
            result = cos([self popOperandOffStack:stack]);
        }
        else if([operation isEqualToString:@"√"])
        {
            result = sqrt([self popOperandOffStack:stack]);
        }
        else if([operation isEqualToString:@"∏"])
        {
            result = (double) 22/7;
        }
    }
    
    return result;
}

+ (NSSet *) variablesUsedInProgram:(id)program
{
    NSSet * variableSet;
    
    return variableSet;
}

//Change to use variables
+ (id) runProgram:(id)program
       usingVariableValues:(NSDictionary *)variableValues
{

    return nil;
}

+ (double) runProgram:(id)program
{
    NSMutableArray * stack;
    
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}



@end
