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
    // 23andMe Logo Image View
    UIImage *logoImage = [UIImage imageNamed:@"intro_23andMe_logo" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.contentMode = UIViewContentModeCenter;
    
    //--------------------
    // Description Label
    NSString *descriptionText = [NSString stringWithFormat:@"%@ is colaborating with 23andMe to collect genetic data for the %@ study", self.investigatorDisplayName, self.studyDisplayName];
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:descriptionText];
    
    //--------------------
    // Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"intro_chromosome_green_striped" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
    genePillImageView.contentMode = UIViewContentModeRight;
    
    //--------------------
    // Divider View
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:229.0/255.0 blue:230.0/255.0 alpha:1.0];
    [self.view addSubview:dividerView];
    [dividerView.heightAnchor constraintEqualToConstant:1.0].active = YES;
    
    UIStackView *descriptionStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        descriptionLabel
    ]];
    descriptionStackView.layoutMargins = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    descriptionStackView.layoutMarginsRelativeArrangement = YES;
    UIStackView *topStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        logoImageView,
        descriptionStackView,
        genePillImageView
    ]];
    topStackView.translatesAutoresizingMaskIntoConstraints = NO;
    topStackView.axis = UILayoutConstraintAxisVertical;
    topStackView.distribution = UIStackViewDistributionEqualSpacing;
    topStackView.alignment = UIStackViewAlignmentFill;
    [self.view addSubview:topStackView];
    [topStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [topStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [topStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    UIStackView *bottomStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        dividerView
    ]];
    bottomStackView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomStackView.axis = UILayoutConstraintAxisVertical;
    bottomStackView.alignment = UIStackViewAlignmentFill;
    [self.view addSubview:bottomStackView];
    [bottomStackView.topAnchor constraintEqualToAnchor:topStackView.bottomAnchor constant:24.0].active = YES;
    [bottomStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [bottomStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [bottomStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

@end
