/*
 Copyright (c) 2016, 23andMe, Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ORKTwentyThreeAndMeIntroPage2ViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeIntroPage2ViewController ()

@end

@implementation ORKTwentyThreeAndMeIntroPage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)setupAppearance {
    //--------------------
    // Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"About this study"];
    
    //--------------------
    // About Description Label
    NSString *aboutDescriptionText = [NSString stringWithFormat:@"In order to participate in this part of the study, you will need to authorize 23andMe to share portions of your genetic data with %@.", self.studyDisplayName];
    UILabel *aboutDescriptionLabel = [UILabel t23BodyLabelWithText:aboutDescriptionText];
    
    //--------------------
    // Eligibility Header Label
    UILabel *eligibilityHeaderLabel = [UILabel t23SubheaderLabelWithText:@"Eligibility"];
    
    //--------------------
    // Existing User Label
    UILabel *existingUserLabel = [UILabel t23BodyLabelWithText:@"Existing 23andMe users"];
    
    //--------------------
    // Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"intro_chromosome_green" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
    genePillImageView.contentMode = UIViewContentModeLeft;
    
    //--------------------
    // Divider View
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = [UIColor t23SeparatorColor];
    [dividerView.heightAnchor constraintEqualToConstant:0.5].active = YES;
    
    UIStackView *topStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        titleLabel,
        aboutDescriptionLabel,
        eligibilityHeaderLabel,
        existingUserLabel
    ]];
    topStackView.translatesAutoresizingMaskIntoConstraints = NO;
    topStackView.axis = UILayoutConstraintAxisVertical;
    topStackView.alignment = UIStackViewAlignmentFill;
    topStackView.layoutMargins = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    topStackView.layoutMarginsRelativeArrangement = YES;
    topStackView.spacing = 15.0;
    [self.view addSubview:topStackView];
    [topStackView setCustomSpacing:20.0 afterView:titleLabel];
    [topStackView setCustomSpacing:10.0 afterView:eligibilityHeaderLabel];
    [topStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [topStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [topStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    UIStackView *bottomStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        genePillImageView,
        dividerView
    ]];
    bottomStackView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomStackView.axis = UILayoutConstraintAxisVertical;
    bottomStackView.alignment = UIStackViewAlignmentFill;
    bottomStackView.spacing = 24.0;
    [self.view addSubview:bottomStackView];
    [bottomStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [bottomStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [bottomStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

@end
