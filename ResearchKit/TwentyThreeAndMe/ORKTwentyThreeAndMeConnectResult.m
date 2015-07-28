//
//  ORKTwentyThreeAndMeConnectResult.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/29/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeConnectResult.h"

#import "ORKResult_Private.h"
#import "ORKHelpers_Internal.h"

@implementation ORKTwentyThreeAndMeConnectResult

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    ORK_ENCODE_OBJ(aCoder, authToken);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        ORK_DECODE_OBJ_CLASS(aDecoder, authToken, NSString);
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    BOOL isParentSame = [super isEqual:object];
    
    __typeof(self) castObject = object;
    return (isParentSame &&
            ORKEqualObjects(self.authToken, castObject.authToken));
}

- (instancetype)copyWithZone:(NSZone *)zone {
    ORKTwentyThreeAndMeConnectResult *result = [super copyWithZone:zone];
    result.authToken = [self.authToken copy];
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", [super description], self.authToken];
}

@end
