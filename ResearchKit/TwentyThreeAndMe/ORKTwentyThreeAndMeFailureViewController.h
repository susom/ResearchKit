//
//  ORKTwentyThreeAndMeFailureViewController.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

@protocol ORKTwentyThreeAndMeFailureViewControllerDelegate <NSObject>

- (void)tryAgainButtonPressed;

- (void)declineButtonPressed;

@end

ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeFailureViewController : UIViewController

/**
 The delegate for this view controller.
 */
@property (nonatomic, weak, nullable) id<ORKTwentyThreeAndMeFailureViewControllerDelegate> delegate;

@property (nonatomic) NSString *studyDisplayName;

@property (nonatomic) NSString *studyContactEmail;

@end
