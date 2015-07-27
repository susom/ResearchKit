//
//  ORKTwentyThreeAndMeConnectTaskViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeConnectTaskViewController.h"
#import "ORKOrderedTask+TwentyThreeAndMe.h"

@interface ORKTwentyThreeAndMeConnectTaskViewController ()<ORKTaskViewControllerDelegate>

@end

@implementation ORKTwentyThreeAndMeConnectTaskViewController

/**
 Returns a predefined task view controller that connects a participant with 23andMe
 
 TODO: Finish writing the detailed documentation for this method
 */
+ (ORKTwentyThreeAndMeConnectTaskViewController *)twentyThreeAndMeTaskViewControllerWithIdentifier:(NSString *)identifier
                                                                                       partnerLogo:(NSString *)logoName
                                                                                      authClientId:(NSString *)clientId
                                                                                  authClientSecret:(NSString *)clientSecret
                                                                                        authScopes:(NSString *)scopes
                                                                                   sharingOptional:(BOOL)sharingOptional
{
    ORKOrderedTask *ttamTask = [ORKOrderedTask twentyThreeAndMeTaskWithIdentifier:identifier
                                                                      partnerLogo:logoName
                                                                     authClientId:clientId // mobile-tech internal api client
                                                                 authClientSecret:clientSecret
                                                                       authScopes:scopes
                                                                  sharingOptional:sharingOptional];
    
    ORKTwentyThreeAndMeConnectTaskViewController *ttamTaskViewController = [[ORKTwentyThreeAndMeConnectTaskViewController alloc] initWithTask:ttamTask
                                                                                                                                  taskRunUUID:nil];
    ttamTaskViewController.delegate = ttamTaskViewController;
    
    return ttamTaskViewController;
}

#pragma mark Protocol ORKTaskViewControllerDelegate

- (void)taskViewController:(ORKTaskViewController *)taskViewController
       didFinishWithReason:(ORKTaskViewControllerFinishReason)reason
                     error:(nullable NSError *)error
{
    // TODO: Handle Completion!
    
    if( reason == ORKTaskViewControllerFinishReasonDiscarded )
    {
        // Cancelled...
    }
    else if( reason == ORKTaskViewControllerFinishReasonCompleted )
    {
        // Completed!
        if( self.twentyThreeAndMeConnectDelegate )
        {
            [self.twentyThreeAndMeConnectDelegate twentyThreeAndMeConnectTaskViewController:self didFinishWithResults:@{} error:nil];
        }
    }
}

//- (BOOL)taskViewController:(ORKTaskViewController *)taskViewController shouldPresentStep:(ORKStep *)step
//{
//    // The logic here will keep us from being able to back out of the webview once it is presented.
//    // It seems that for this to be usable, I will need to move this entire class back
//    // into ResearchKit, which I was already planning. Might as well do that sooner now.
//    return YES;
//}

//- (BOOL)taskViewController:(ORKTaskViewController *)taskViewController hasLearnMoreForStep:(ORKStep *)step
//{
//    if( [step.identifier isEqualToString:@"instruction"] )
//    {
//        return YES;
//    }
//
//    return NO;
//}
//
//- (void)taskViewController:(ORKTaskViewController *)taskViewController learnMoreForStep:(ORKStepViewController *)stepViewController
//{
//
//}
//
//- (void)taskViewController:(ORKTaskViewController *)taskViewController stepViewControllerWillAppear:(ORKStepViewController *)stepViewController
//{
//    // Modify LearnMore button here
//}

@end
