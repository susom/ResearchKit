//
//  UIButton+T23.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "UIButton+T23.h"

@implementation UIButton (T23)

+ (UIButton *)t23ButtonWithText:(NSString *)text andHasBorder:(BOOL)hasBorder {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    UIColor *t23ButtonGreen = [UIColor colorWithRed:146.0/255.0 green:199.0/255.0 blue:70.0/255.0 alpha:1.0];
    [button setTitleColor:t23ButtonGreen forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 24.0, 0.0, 24.0);
    if( hasBorder ) {
        button.layer.cornerRadius = 3.0;
        button.layer.borderColor = t23ButtonGreen.CGColor;
        button.layer.borderWidth = 1.0;
    }
    [button addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1.0
                                                       constant:45.0]];
    return button;
}

@end
