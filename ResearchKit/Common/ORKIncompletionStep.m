//
//  ORKIncompletionStep.m
//  ResearchKit
//
//  Created by Dariusz Lesniak on 25/01/2016.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKIncompletionStep.h"
#import "ORKIncompletionStepViewController.h"

@implementation ORKIncompletionStep

+ (Class)stepViewControllerClass {
    return [ORKIncompletionStepViewController class];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}


@end
