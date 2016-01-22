//
//  ORKTwentyThreeAndMeIntroPage3ViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeIntroPage3ViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeIntroPage3ViewController ()

@end

@implementation ORKTwentyThreeAndMeIntroPage3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)setupAppearance {
    //--------------------
    // Style
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // Scroll View
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // - Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"About 23andMe"];
    [scrollView addSubview:titleLabel];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:40.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:-15.0]];
    
    //--------------------
    // - Scroll View Width Behavior
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:-30.0]];
    
    //--------------------
    // - Mission Description Label
    UILabel *missionDescriptionLabel = [UILabel t23BodyLabelWithText:@"The 23andMe mission is to help people access, understand, and benefit from the human genome. 23andMe provides easy to understand reports about genetic markers related to health, traits, and ancestry."];
    [scrollView addSubview:missionDescriptionLabel];
    missionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:missionDescriptionLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:titleLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:20.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:missionDescriptionLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:missionDescriptionLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:-15.0]];
    
    //--------------------
    // - Learn More Header Label
    UILabel *learnMoreHeaderLabel = [UILabel t23SubheaderLabelWithText:@"Lean more"];
    [scrollView addSubview:learnMoreHeaderLabel];
    learnMoreHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreHeaderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:missionDescriptionLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreHeaderLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreHeaderLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:-15.0]];
    
    //--------------------
    // - Learn More Description Label
    UILabel *learnMoreDescriptionLabel = [UILabel t23BodyLabelWithText:@"Learn more about 23andMe and the Personal Genome service."];
    [scrollView addSubview:learnMoreDescriptionLabel];
    learnMoreDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreDescriptionLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:learnMoreHeaderLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:8.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreDescriptionLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:learnMoreDescriptionLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:-15.0]];
    
    //--------------------
    // - Questions Header Label
    UILabel *questionsHeaderLabel = [UILabel t23SubheaderLabelWithText:@"Questions?"];
    [scrollView addSubview:questionsHeaderLabel];
    questionsHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:questionsHeaderLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:learnMoreDescriptionLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:questionsHeaderLabel
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:questionsHeaderLabel
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:-15.0]];
    
    //--------------------
    // - Contact Study Button
    UIButton *contactStudyButton = [[UIButton alloc] init];
    [contactStudyButton setTitle:@"Contact <study_name>" forState:UIControlStateNormal];
    UIColor *t23BlueColor = [UIColor colorWithRed:53.0/255.0 green:149.0/255.0 blue:214.0/255.0 alpha:1.0];
    [contactStudyButton setTitleColor:t23BlueColor forState:UIControlStateNormal];
    contactStudyButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [scrollView addSubview:contactStudyButton];
    contactStudyButton.translatesAutoresizingMaskIntoConstraints = NO;
    [contactStudyButton addConstraint:[NSLayoutConstraint constraintWithItem:contactStudyButton
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.0
                                                            constant:45.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contactStudyButton
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:questionsHeaderLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:-10.0]];
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contactStudyButton
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:15.0]];
    
    //--------------------
    // - Bottom Constraint
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contactStudyButton
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:scrollView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0.0]];
//
    //--------------------
    // - Gene Pill Image View
    if( CGRectGetHeight( [UIScreen mainScreen].bounds ) > 480.0 )
    {
        UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_chromosome_pink"]];
        [self.view addSubview:genePillImageView];
        genePillImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:contactStudyButton
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:22.0]];
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:genePillImageView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:scrollView
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0]];
    }
    
    //--------------------
    // Divider View
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:229.0/255.0 blue:230.0/255.0 alpha:1.0];
    [self.view addSubview:dividerView];
    dividerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:scrollView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
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
    [dividerView addConstraint:[NSLayoutConstraint constraintWithItem:dividerView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:1.0]];
}

@end
