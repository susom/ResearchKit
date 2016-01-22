//
//  UIButton+T23.h
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (T23)

/**
 *  Helper to build a styled button for 23andMe module content
 *
 *  @param text      <#text description#>
 *  @param hasBorder <#hasBorder description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton *)t23ButtonWithText:(NSString *)text andHasBorder:(BOOL)hasBorder;

@end
