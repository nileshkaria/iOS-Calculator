//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Nil on May/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)   pushOperand:(double) operand;
- (double) popOperand;
- (void)   clearStack;
- (double) performOperation:(NSString *)operation;

@property (readonly) id program;

+ (double) runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;

@end
