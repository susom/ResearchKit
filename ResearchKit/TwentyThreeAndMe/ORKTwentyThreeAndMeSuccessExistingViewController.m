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

#import "ORKTwentyThreeAndMeSuccessExistingViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeSuccessExistingViewController ()

@end

@implementation ORKTwentyThreeAndMeSuccessExistingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)doneButtonPressed:(UIButton *)sender {
    [self.delegate doneButtonPressed];
}

- (void)setupAppearance {
    //--------------------
    // Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"congratulations_chromosome_blue" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
    genePillImageView.contentMode = UIViewContentModeLeft;
    
    //--------------------
    // Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"Congratulations"];
    
    //--------------------
    // Description Label
    NSString *descriptionLabelText = [NSString stringWithFormat:@"Congratulations, %@ is now authorized to access your genetic data.", self.studyDisplayName];
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:descriptionLabelText];
    
    //--------------------
    // Done Button
    UIButton *doneButton = [UIButton t23ButtonWithText:@"Done" andHasBorder:YES];
    [doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *middleStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        titleLabel,
        descriptionLabel
    ]];
    middleStackView.axis = UILayoutConstraintAxisVertical;
    middleStackView.alignment = UIStackViewAlignmentCenter;
    middleStackView.layoutMargins = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    middleStackView.layoutMarginsRelativeArrangement = YES;
    middleStackView.spacing = 20.0;
    
    UIStackView *bottomStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        doneButton
    ]];
    bottomStackView.axis = UILayoutConstraintAxisVertical;
    bottomStackView.alignment = UIStackViewAlignmentCenter;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        genePillImageView,
        middleStackView,
        bottomStackView
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentFill;
    [self.view addSubview:stackView];
    [self.view.topAnchor constraintEqualToAnchor:stackView.topAnchor].active = YES;
    [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:stackView.bottomAnchor constant:30.0].active = YES;
    [self.view.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [self.view.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
}


@end
