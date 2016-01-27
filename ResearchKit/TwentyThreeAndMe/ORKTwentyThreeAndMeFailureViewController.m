//
//  ORKTwentyThreeAndMeFailureViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeFailureViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeFailureViewController ()

@end

@implementation ORKTwentyThreeAndMeFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)tryAgainButtonPressed:(UIButton *)sender {
    [self.delegate tryAgainButtonPressed];
}

- (void)declineButtonPressed:(UIButton *)sender {
    [self.delegate declineButtonPressed];
}

- (void)setupAppearance {
    //--------------------
    // Style
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"failure_chromosome_purple" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
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
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
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
                                                           constant:-20.0]];
    
    //--------------------
    // Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"Try again"];
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
    NSString *descriptionLabelText = [NSString stringWithFormat:@"Sorry, we weren’t able to enroll you in the genetic component of %@. Please try again, or contact %@ if you have any questions.", self.studyDisplayName, self.studyDisplayName];
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:descriptionLabelText];
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
    // Try Again Button
    UIButton *tryAgainButton = [UIButton t23ButtonWithText:@"Try again" andHasBorder:YES];
    [self.view addSubview:tryAgainButton];
    [tryAgainButton addTarget:self action:@selector(tryAgainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    tryAgainButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tryAgainButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Decline Button
    UIButton *declineButton = [UIButton t23ButtonWithText:@"Decline" andHasBorder:NO];
    [self.view addSubview:declineButton];
    [declineButton addTarget:self action:@selector(declineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    declineButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:declineButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:tryAgainButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:5.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:declineButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:declineButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-10.0]];
}

@end
