//
//  ORKTwentyThreeAndMeSuccessExistingViewController.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

@protocol ORKTwentyThreeAndMeSuccessExistingViewControllerDelegate <NSObject>

- (void)doneButtonPressed;

@end

ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeSuccessExistingViewController : UIViewController

/**
 The delegate for this view controller.
 */
@property (nonatomic, weak, nullable) id<ORKTwentyThreeAndMeSuccessExistingViewControllerDelegate> delegate;

@property (nonatomic) NSString *studyDisplayName;

@end
