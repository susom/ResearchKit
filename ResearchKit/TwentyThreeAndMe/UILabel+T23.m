//
//  UILabel+T23.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "UILabel+T23.h"

@implementation UILabel (T23)

+ (UILabel *)t23HeaderLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if( [UIFont instancesRespondToSelector:@selector(systemFontOfSize:weight:)] ) {
        label.font = [UIFont systemFontOfSize:22.0 weight:UIFontWeightSemibold];
    }
    else {
        label.font = [UIFont boldSystemFontOfSize:22.0];
    }
    label.numberOfLines = 1;
    label.textColor = [UIColor colorWithRed:51.0/255.0 green:52.0/255.0 blue:53.0/255.0 alpha:1.0];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (UILabel *)t23SubheaderLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if( [UIFont instancesRespondToSelector:@selector(systemFontOfSize:weight:)] ) {
        label.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    }
    else {
        label.font = [UIFont boldSystemFontOfSize:16.0];
    }
    label.numberOfLines = 1;
    label.textColor = [UIColor colorWithRed:51.0/255.0 green:52.0/255.0 blue:53.0/255.0 alpha:1.0];
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

+ (UILabel *)t23BodyLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.0];
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:51.0/255.0 green:52.0/255.0 blue:53.0/255.0 alpha:1.0];
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

@end
