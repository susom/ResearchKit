//
//  ORKTwentyThreeAndMeCompleteViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/26/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeCompleteViewController.h"
#import "ORKTwentyThreeAndMeCompleteStep.h"
#import "ORKTwentyThreeAndMeSuccessExistingViewController.h"
#import "ORKTwentyThreeAndMeFailureViewController.h"


@interface ORKTwentyThreeAndMeCompleteViewController() <ORKTwentyThreeAndMeSuccessExistingViewControllerDelegate, ORKTwentyThreeAndMeFailureViewControllerDelegate>

@property (nonatomic) ORKTwentyThreeAndMeSuccessExistingViewController *successExistingViewController;

@property (nonatomic) ORKTwentyThreeAndMeFailureViewController *failureViewController;

@end

@implementation ORKTwentyThreeAndMeCompleteViewController

- (ORKTwentyThreeAndMeCompleteStep *)completeStep {
    return (ORKTwentyThreeAndMeCompleteStep *)self.step;
}

- (void)doneButtonPressed {
    [self goForward];
}

- (void)tryAgainButtonPressed {
    [self goBackward];
}

- (void)declineButtonPressed {
    [self.taskViewController.delegate taskViewController:self.taskViewController
                                     didFinishWithReason:ORKTaskViewControllerFinishReasonDiscarded
                                                   error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ORKTwentyThreeAndMeCompleteStep *completeStep = [self completeStep];
    NSString *studyDisplayName = completeStep.studyDisplayName;
    NSString *studyContactEmail = completeStep.studyContactEmail;
    
    self.successExistingViewController = [[ORKTwentyThreeAndMeSuccessExistingViewController alloc] init];
    self.successExistingViewController.delegate = self;
    self.successExistingViewController.studyDisplayName = studyDisplayName;
    
    self.failureViewController = [[ORKTwentyThreeAndMeFailureViewController alloc] init];
    self.failureViewController.delegate = self;
    self.failureViewController.studyDisplayName = studyDisplayName;
    self.failureViewController.studyContactEmail = studyContactEmail;
    
    self.cancelButtonItem = nil;
    self.backButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Use Results to Determine What To Show
    ORKTaskResult *taskResult = [self.taskViewController result];
    ORKCollectionResult *connectResultCollection = (ORKCollectionResult *)[taskResult resultForIdentifier:@"twentyThreeAndMe.connect"];
    ORKTwentyThreeAndMeConnectResult *connectResult = (ORKTwentyThreeAndMeConnectResult *)[connectResultCollection.results firstObject];
    if( connectResult.authToken &&
        connectResult.refreshToken ) {
        [self hideFailureViewController];
        [self showSuccessExistingViewController];
    }
    else {
        [self hideSuccessExistingViewController];
        [self showFailureViewController];
    }
}

- (void)showSuccessExistingViewController
{
    [self.view addSubview:self.successExistingViewController.view];
    [self addChildViewController:self.successExistingViewController];
    [self.successExistingViewController didMoveToParentViewController:self];
}

- (void)hideSuccessExistingViewController
{
    [self.successExistingViewController removeFromParentViewController];
    [self.successExistingViewController.view removeFromSuperview];
}

- (void)showFailureViewController
{
    [self.view addSubview:self.failureViewController.view];
    [self addChildViewController:self.failureViewController];
    [self.failureViewController didMoveToParentViewController:self];
}

- (void)hideFailureViewController
{
    [self.failureViewController removeFromParentViewController];
    [self.failureViewController.view removeFromSuperview];
}

@end
