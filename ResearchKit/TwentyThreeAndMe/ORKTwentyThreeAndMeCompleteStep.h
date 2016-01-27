//
//  ORKTwentyThreeAndMeCompleteStep.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/26/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeCompleteStep : ORKStep

/**
 * The display name of the study
 */
@property (nonatomic, copy, nullable) NSString *studyDisplayName;

/**
 * The contact email for the study
 */
@property (nonatomic, copy, nullable) NSString *studyContactEmail;

@end
