//
//  ORKOrderedTask+TwentyThreeAndMe.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKOrderedTask+TwentyThreeAndMe.h"

#import "ORKTwentyThreeAndMeConnectStep.h"
#import "ORKTwentyThreeAndMeConnectStepViewController.h"
#import "ORKHelpers.h"
#import "ORKStep_Private.h"
#import "ORKDefines_Private.h"
#import "ORKCompletionStep.h"

@implementation ORKOrderedTask (TwentyThreeAndMe)

static NSString * const ORKInstruction0StepIdentifier = @"instruction";
static NSString * const ORKInstruction1StepIdentifier = @"instruction1";
static NSString * const ORKConclusionStepIdentifier = @"conclusion";
static NSString * const ORKTwentyThreeAndMeConnectStepIdentifier = @"twentyThreeAndMe.connect";

static void ORKStepArrayAddStep(NSMutableArray *array, ORKStep *step) {
    [step validateParameters];
    [array addObject:step];
}

+ (ORKOrderedTask *)twentyThreeAndMeTaskWithIdentifier:(NSString *)identifier
                                           partnerLogo:(NSString *)logoName
                                          authClientId:(NSString *)clientId
                                      authClientSecret:(NSString *)clientSecret
                                            authScopes:(NSString *)scopes
                                       sharingOptional:(BOOL)sharingOptional
{
    NSMutableArray *steps = [NSMutableArray array];
    
    {
        ORKInstructionStep *step = [[ORKInstructionStep alloc] initWithIdentifier:ORKInstruction0StepIdentifier];
        step.title = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_1_TITLE", nil);
        step.text = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_1_TEXT", nil);
        step.detailText = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_1_DETAIL_TEXT", nil);
        step.shouldTintImages = YES;
        
        ORKStepArrayAddStep(steps, step);
    }
    
    {
        ORKInstructionStep *step = [[ORKInstructionStep alloc] initWithIdentifier:ORKInstruction1StepIdentifier];
        step.title = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_2_TITLE", nil);
        step.text = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_2_TEXT", nil);
        step.detailText = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_2_DETAIL_TEXT", nil);
        step.shouldTintImages = YES;
        
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
        ORKCompletionStep *step = [[ORKCompletionStep alloc] initWithIdentifier:ORKConclusionStepIdentifier];
        step.title = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_CONCLUSION_SUCCESS_NEW_TITLE", nil);
        step.text = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_CONCLUSION_SUCCESS_NEW_TEXT", nil);
        step.shouldTintImages = YES;
        
        ORKStepArrayAddStep(steps, step);
    }
    
    ORKOrderedTask *task = [[ORKOrderedTask alloc] initWithIdentifier:identifier steps:steps];
    
    return task;
}

@end
