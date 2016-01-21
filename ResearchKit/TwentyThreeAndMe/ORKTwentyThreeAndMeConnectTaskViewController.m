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

- (BOOL)taskViewController:(ORKTaskViewController *)taskViewController hasLearnMoreForStep:(ORKStep *)step {
    if( [step.identifier isEqualToString:@"instruction"] ) {
        return YES;
    }
    else if( [step.identifier isEqualToString:@"instruction1"] ) {
        return YES;
    }

    return NO;
}

- (void)taskViewController:(ORKTaskViewController *)taskViewController learnMoreForStep:(ORKStepViewController *)stepViewController {
    if( [stepViewController.step.identifier isEqualToString:@"instruction"] ) {
        UIViewController *learnMoreInstruction1VC = [[UIViewController alloc] init];
        learnMoreInstruction1VC.view.backgroundColor = [UIColor purpleColor];
        learnMoreInstruction1VC.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(learnMoreDone:)];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:learnMoreInstruction1VC];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    else if( [stepViewController.step.identifier isEqualToString:@"instruction1"] ) {
        UIViewController *learnMoreInstruction1VC = [[UIViewController alloc] init];
        learnMoreInstruction1VC.view.backgroundColor = [UIColor purpleColor];
        learnMoreInstruction1VC.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(learnMoreDone:)];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:learnMoreInstruction1VC];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (void)taskViewController:(ORKTaskViewController *)taskViewController stepViewControllerWillAppear:(ORKStepViewController *)stepViewController {
    if( [stepViewController.step.identifier isEqualToString:@"instruction"] ) {
        stepViewController.learnMoreButtonTitle = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_1_LEARN_MORE", nil);
    }
    else if( [stepViewController.step.identifier isEqualToString:@"instruction1"] ) {
        stepViewController.learnMoreButtonTitle = ORKLocalizedString(@"TWENTYTHREEANDME_CONNECT_TASK_INTRO_2_LEARN_MORE", nil);
    }
}

@end
