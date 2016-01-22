//
//  UILabel+T23.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (T23)

+ (UILabel *)t23HeaderLabelWithText:(NSString *)text;

+ (UILabel *)t23SubheaderLabelWithText:(NSString *)text;

+ (UILabel *)t23BodyLabelWithText:(NSString *)text;

@end
