//
//  ORKTwentyThreeAndMeConnectResult.h
//  ResearchKit
//
//  Created by Andrew Schramm on 7/29/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import <ResearchKit/ORKResult.h>

NS_ASSUME_NONNULL_BEGIN

/**
 */
ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeConnectResult : ORKResult

/**
 */
@property (nonatomic, copy, nullable) NSString *authToken;

@end

NS_ASSUME_NONNULL_END
