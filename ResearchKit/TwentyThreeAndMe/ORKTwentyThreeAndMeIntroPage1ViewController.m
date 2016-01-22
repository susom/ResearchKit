//
//  ORKTwentyThreeAndMeIntroPage1ViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeIntroPage1ViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeIntroPage1ViewController ()

@end

@implementation ORKTwentyThreeAndMeIntroPage1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)setupAppearance {
    //--------------------
    // Style
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // 23andMe Logo Image View
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_23andMe_logo"]];
    [self.view addSubview:logoImageView];
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:60.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:15.0]];
    
    //--------------------
    // Spacer Above
    UIView *spacerAboveDescription = [[UIView alloc] init];
    [self.view addSubview:spacerAboveDescription];
    spacerAboveDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerAboveDescription
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:logoImageView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerAboveDescription
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerAboveDescription
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Description Label
    NSString *descriptionText = [NSString stringWithFormat:@"%@  has selected 23andMe to collect genetic data for the  %@ study", @"<Investigator>", @"<study_name>"];
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:descriptionText];
    [self.view addSubview:descriptionLabel];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:spacerAboveDescription
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:15.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:-15.0]];
    
    //--------------------
    // Spacer Below
    UIView *spacerBelowDescription = [[UIView alloc] init];
    [self.view addSubview:spacerBelowDescription];
    spacerBelowDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerBelowDescription
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:descriptionLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerBelowDescription
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:spacerAboveDescription
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerBelowDescription
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:spacerBelowDescription
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Gene Pill Image View
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_chromosome_green_striped"]];
    [self.view addSubview:genePillImageView];
    genePillImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:spacerBelowDescription
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Divider View
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:229.0/255.0 blue:230.0/255.0 alpha:1.0];
    [self.view addSubview:dividerView];
    dividerView.translatesAutoresizingMaskIntoConstraints = NO;
    [dividerView addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:1.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:genePillImageView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:24.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
}

@end
