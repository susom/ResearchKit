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
 *  RedirectURI used by auth. Should match what is in developer portal.
 */
@property (nonatomic, copy, nullable) NSString *redirectURI;

/**
 *  ClientId used by auth. Should match what is in developer portal.
 */
@property (nonatomic, copy, nullable) NSString *clientId;

/**
 *  ClientSecret used by auth. Should match what is in developer portal.
 */
@property (nonatomic, copy, nullable) NSString *clientSecret;

/**
 *  Scopes used by auth.
 */
@property (nonatomic, copy, nullable) NSString *scopes;

@end

NS_ASSUME_NONNULL_END

