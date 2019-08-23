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

- (void)contactStudyButtonPressed:(UIButton *)sender {
    NSString *contactStudyByMail = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                                    [self.studyContactEmail stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet],
                                    [self.studyDisplayName stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet],
                                    @""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contactStudyByMail] options:@{} completionHandler:NULL];
}

- (void)setupAppearance {
    //--------------------
    // Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"failure_chromosome_purple" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
    genePillImageView.contentMode = UIViewContentModeRight;
    
    //--------------------
    // Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"Try again"];
    
    //--------------------
    // Description Label
    NSString *descriptionLabelText = [NSString stringWithFormat:@"Sorry, we weren’t able to enroll you in the genetic component of %@. Please try again, or contact %@ if you have any questions.", self.studyDisplayName, self.studyDisplayName];
    UILabel *descriptionLabel = [UILabel t23BodyLabelWithText:descriptionLabelText];
    
    UIButton *contactStudyButton = [[UIButton alloc] init];
    NSString *contactStudyText = [NSString stringWithFormat:@"Contact %@", self.studyDisplayName];
    [contactStudyButton addTarget:self action:@selector(contactStudyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [contactStudyButton setTitle:contactStudyText forState:UIControlStateNormal];
    UIColor *t23BlueColor = [UIColor colorWithRed:53.0/255.0 green:149.0/255.0 blue:214.0/255.0 alpha:1.0];
    [contactStudyButton setTitleColor:t23BlueColor forState:UIControlStateNormal];
    contactStudyButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    contactStudyButton.translatesAutoresizingMaskIntoConstraints = NO;
    contactStudyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contactStudyButton.heightAnchor constraintEqualToConstant:45.0].active = YES;
    
    //--------------------
    // Try Again Button
    UIButton *tryAgainButton = [UIButton t23ButtonWithText:@"Try again" andHasBorder:YES];
    [tryAgainButton addTarget:self action:@selector(tryAgainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //--------------------
    // Decline Button
    UIButton *declineButton = [UIButton t23ButtonWithText:@"Decline" andHasBorder:NO];
    [declineButton addTarget:self action:@selector(declineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *middleStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        titleLabel,
        descriptionLabel,
        contactStudyButton
    ]];
    middleStackView.axis = UILayoutConstraintAxisVertical;
    middleStackView.layoutMargins = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    middleStackView.layoutMarginsRelativeArrangement = YES;
    middleStackView.spacing = 20.0;
    [middleStackView setCustomSpacing:-10.0 afterView:descriptionLabel];
    
    UIStackView *bottomStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        tryAgainButton,
        declineButton
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
    [self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:stackView.bottomAnchor].active = YES;
    [self.view.leadingAnchor constraintEqualToAnchor:stackView.leadingAnchor].active = YES;
    [self.view.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor].active = YES;
}

@end
