//
//  ORKOrderedTask+TwentyThreeAndMe.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKOrderedTask+TwentyThreeAndMe.h"

#import "ORKTwentyThreeAndMeIntroStep.h"
#import "ORKTwentyThreeAndMeConnectStep.h"
#import "ORKTwentyThreeAndMeCompleteStep.h"
#import "ORKHelpers.h"
#import "ORKStep_Private.h"
#import "ORKDefines_Private.h"
#import "ORKCompletionStep.h"

@implementation ORKOrderedTask (TwentyThreeAndMe)

static NSString * const ORKTwentyThreeAndMeIntroStepIdentifier = @"twentyThreeAndMe.intro";
static NSString * const ORKTwentyThreeAndMeConnectStepIdentifier = @"twentyThreeAndMe.connect";
static NSString * const ORKTwentyThreeAndMeCompleteStepIdentifier = @"twentyThreeAndMe.complete";

static void ORKStepArrayAddStep(NSMutableArray *array, ORKStep *step) {
    [step validateParameters];
    [array addObject:step];
}

+ (ORKOrderedTask *)twentyThreeAndMeTaskWithIdentifier:(NSString *)identifier
                                          authClientId:(NSString *)clientId
                                      authClientSecret:(NSString *)clientSecret
                                            authScopes:(NSString *)scopes
                               investigatorDisplayName:(NSString *)investigatorDisplayName
                                      studyDisplayName:(NSString *)studyDisplayName
                                     studyContactEmail:(NSString *)studyContactEmail
{
    NSMutableArray *steps = [NSMutableArray array];
    
    {
        ORKTwentyThreeAndMeIntroStep *step = [[ORKTwentyThreeAndMeIntroStep alloc] initWithIdentifier:ORKTwentyThreeAndMeIntroStepIdentifier];
        step.investigatorDisplayName = investigatorDisplayName;
        step.studyDisplayName = studyDisplayName;
        step.studyContactEmail = studyContactEmail;
        ORKStepArrayAddStep(steps, step);
    }
    
    {
        ORKTwentyThreeAndMeConnectStep *step = [[ORKTwentyThreeAndMeConnectStep alloc] initWithIdentifier:ORKTwentyThreeAndMeConnectStepIdentifier];
        step.redirectURI = @"http://localhost:5000/receive_code/&response_type=code";
        step.clientId = clientId;
        step.clientSecret = clientSecret;
        step.scopes = scopes;
        ORKStepArrayAddStep(steps, step);
    }
    
    {
        ORKTwentyThreeAndMeCompleteStep *step = [[ORKTwentyThreeAndMeCompleteStep alloc] initWithIdentifier:ORKTwentyThreeAndMeCompleteStepIdentifier];
        step.studyDisplayName = studyDisplayName;
        step.studyContactEmail = studyContactEmail;
        ORKStepArrayAddStep(steps, step);
    }
    
    ORKOrderedTask *task = [[ORKOrderedTask alloc] initWithIdentifier:identifier steps:steps];
    
    return task;
}

@end
