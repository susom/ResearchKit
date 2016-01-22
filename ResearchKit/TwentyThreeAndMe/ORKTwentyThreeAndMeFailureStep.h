//
//  ORKTwentyThreeAndMeFailureStep.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

@interface ORKTwentyThreeAndMeFailureStep : ORKStep

/**
 * The display name of the study
 */
@property (nonatomic, copy, nullable) NSString *studyDisplayName;

/**
 * The contact email for the study
 */
@property (nonatomic, copy, nullable) NSString *studyContactEmail;

@end
