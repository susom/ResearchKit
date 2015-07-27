//
//  ORKTwentyThreeAndMeConnectStep.h
//  ResearchKit
//
//  Created by Andrew Schramm on 7/26/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * An `ORKTwentyThreeAndMeConnectStep` object allows the participant to connect
 * with 23andMe and share their data with the investigators.
 */
ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeConnectStep : ORKStep

/**
 *
 */
@property (nonatomic, copy, nullable) NSString *redirectURI;

/**
 *
 */
@property (nonatomic, copy, nullable) NSString *clientId;

/**
 *
 */
@property (nonatomic, copy, nullable) NSString *clientSecret;

/**
 *
 */
@property (nonatomic, copy, nullable) NSString *scopes;

@end

NS_ASSUME_NONNULL_END

