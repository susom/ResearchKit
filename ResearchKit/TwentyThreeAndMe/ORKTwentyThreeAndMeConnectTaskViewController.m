//
//  ORKTwentyThreeAndMeConnectTaskViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeConnectTaskViewController.h"
#import "ORKOrderedTask+TwentyThreeAndMe.h"
#import "ORKCompletionStep.h"
#import "ORKDefines_Private.h"
#import "ORKConsentLearnMoreViewController.h"

@interface ORKTwentyThreeAndMeConnectTaskViewController ()<ORKTaskViewControllerDelegate>

@end

@implementation ORKTwentyThreeAndMeConnectTaskViewController

+ (ORKTwentyThreeAndMeConnectTaskViewController *)twentyThreeAndMeTaskViewControllerWithIdentifier:(NSString *)identifier
                                                                                      authClientId:(NSString *)clientId
                                                                                  authClientSecret:(NSString *)clientSecret
                                                                                        authScopes:(NSString *)scopes
                                                                           investigatorDisplayName:(NSString *)investigatorDisplayName
                                                                                  studyDisplayName:(NSString *)studyDisplayName
                                                                                 studyContactEmail:(NSString *)studyContactEmail {
    ORKOrderedTask *ttamTask = [ORKOrderedTask twentyThreeAndMeTaskWithIdentifier:identifier
                                                                     authClientId:clientId
                                                                 authClientSecret:clientSecret
                                                                       authScopes:scopes
                                                          investigatorDisplayName:investigatorDisplayName
                                                                 studyDisplayName:studyDisplayName
                                                                studyContactEmail:studyContactEmail];
    
    ORKTwentyThreeAndMeConnectTaskViewController *ttamTaskViewController = [[ORKTwentyThreeAndMeConnectTaskViewController alloc] initWithTask:ttamTask
                                                                                                                                  taskRunUUID:nil];
    ttamTaskViewController.delegate = ttamTaskViewController;
    ttamTaskViewController.showsProgressInNavigationBar = NO;
    
    return ttamTaskViewController;
}

- (IBAction)learnMoreDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Protocol ORKTaskViewControllerDelegate

- (void)taskViewController:(ORKTaskViewController *)taskViewController
       didFinishWithReason:(ORKTaskViewControllerFinishReason)reason
                     error:(nullable NSError *)error {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    if( reason == ORKTaskViewControllerFinishReasonDiscarded ) {
        if( self.twentyThreeAndMeConnectDelegate ) {
            [resultDict setObject:@"cancelled" forKey:@"completionType"];
            [self.twentyThreeAndMeConnectDelegate twentyThreeAndMeConnectTaskViewController:self didFinishWithResults:resultDict error:nil];
        }
    }
    else if( reason == ORKTaskViewControllerFinishReasonCompleted ) {
        if( self.twentyThreeAndMeConnectDelegate ) {
            ORKTaskResult *taskResult = [taskViewController result];
            ORKCollectionResult *connectResultCollection = (ORKCollectionResult *)[taskResult resultForIdentifier:@"twentyThreeAndMe.connect"];
            ORKTwentyThreeAndMeConnectResult *connectResult = (ORKTwentyThreeAndMeConnectResult *)[connectResultCollection.results firstObject];
            if( connectResult )
            {
                [resultDict setObject:connectResult.authToken forKey:@"authToken"];
                [resultDict setObject:connectResult.refreshToken forKey:@"refreshToken"];
            }
            
            [resultDict setObject:@"success" forKey:@"completionType"];
            [self.twentyThreeAndMeConnectDelegate twentyThreeAndMeConnectTaskViewController:self didFinishWithResults:resultDict error:nil];
        }
    }
}

- (void)taskViewController:(ORKTaskViewController *)taskViewController stepViewControllerWillAppear:(ORKStepViewController *)stepViewController {    
    [stepViewController.backButtonItem setTintColor:[UIColor colorWithRed:146.0/255.0 green:199.0/255.0 blue:70.0/255.0 alpha:1.0]];
    [stepViewController.cancelButtonItem setTintColor:[UIColor colorWithRed:146.0/255.0 green:199.0/255.0 blue:70.0/255.0 alpha:1.0]];
}

@end
