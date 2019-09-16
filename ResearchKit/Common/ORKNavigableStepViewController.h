//
//  ORKNavigableStepViewController.h
//  CardioHealth
//
//  Created by Paweł Kowalczyk on 07/03/2019.
//  Copyright © 2019 Stanford Medical. All rights reserved.
//

@import UIKit;
#import <ResearchKit/ORKStepViewController.h>

NS_ASSUME_NONNULL_BEGIN

ORK_CLASS_AVAILABLE
@interface ORKNavigableStepViewController : ORKStepViewController

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL contentFillsAvailableSpace;
@property (nonatomic, assign) BOOL continueButtonHidden;
@property (nonatomic, assign) BOOL cancelButtonHidden;

@end

NS_ASSUME_NONNULL_END
