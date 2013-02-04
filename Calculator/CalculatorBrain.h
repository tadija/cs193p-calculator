//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Marko Tadić on 1/11/13.
//  Copyright (c) 2013 Marko Tadić. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)resetBrain;

@property (readonly) id program;

+ (double)runProgram:(id)program;
//+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
//+ (NSSet *)variablesUsedInProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
