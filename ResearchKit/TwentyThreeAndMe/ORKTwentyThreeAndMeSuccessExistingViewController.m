//
//  ORKTwentyThreeAndMeSuccessExistingViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeSuccessExistingViewController.h"
#import "ORKTwentyThreeAndMeSuccessExistingStep.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeSuccessExistingViewController ()

@property (nonatomic) NSString *studyDisplayName;

@end

@implementation ORKTwentyThreeAndMeSuccessExistingViewController

- (ORKTwentyThreeAndMeSuccessExistingStep *)successExistingStep {
    return (ORKTwentyThreeAndMeSuccessExistingStep *)self.step;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ORKTwentyThreeAndMeSuccessExistingStep *successExistingStep = [self successExistingStep];
    self.studyDisplayName = successExistingStep.studyDisplayName;
    
    [self setupAppearance];
}

- (void)setupAppearance {
    //--------------------
    // Style
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // Gene Pill Image View
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"congratulations_chromosome_blue"]];
    [self.view addSubview:genePillImageView];
    genePillImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Text Content View
    UIView *textContentView = [[UIView alloc] init];
    [self.view addSubview:textContentView];
    textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:textContentView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:textContentView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:textContentView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"Congratulations"];
    [textContentView addSubview:titleLabel];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0.0]];
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:15.0]];
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-15.0]];
    
    //--------------------
    // Description Label
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:@"You have successfully signed up for 23andMe. <study_name> will be able to access your data as soon as it’s available."];
    [textContentView addSubview:descriptionLabel];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:titleLabel
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:20.0]];
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:15.0]];
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-15.0]];
    [textContentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:textContentView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0.0]];
    
    //--------------------
    // Done Button
    UIButton *doneButton = [UIButton t23ButtonWithText:@"Done" andHasBorder:YES];
    [self.view addSubview:doneButton];
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:doneButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-30.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:doneButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
}


@end
