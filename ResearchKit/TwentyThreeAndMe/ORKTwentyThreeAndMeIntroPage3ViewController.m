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

- (void)contactStudyButtonPressed:(UIButton *)sender {
    NSString *contactStudyByMail = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
        [self.studyContactEmail stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet],
        [self.studyDisplayName stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet],
        @""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contactStudyByMail] options:@{} completionHandler:NULL];
}

- (void)learnMoreButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.23andme.com/service/"] options:@{} completionHandler:NULL];
}

- (void)setupAppearance {
    //--------------------
    // Style
    UIColor *t23BlueColor = [UIColor colorWithRed:53.0/255.0 green:149.0/255.0 blue:214.0/255.0 alpha:1.0];
    
    //--------------------
    // - Title Label
    UILabel *titleLabel = [UILabel t23HeaderLabelWithText:@"About 23andMe"];
    
    //--------------------
    // - Mission Description Label
    UILabel *missionDescriptionLabel = [UILabel t23BodyLabelWithText:@"23andMe is a genetic service available directly to U.S. customers that includes reports that meet FDA standards for being scientifically and clinically valid. 23andMe helps people understand what’s in their DNA. The 23andMe Personal Genome Service includes more than 60 personalized genetic health, trait and ancestry reports."];
    
    //--------------------
    // - Learn More Button
    UIButton *learnMoreButton = [[UIButton alloc] init];
    NSString *learnMoreText = @"Learn more about 23andMe";
    [learnMoreButton addTarget:self action:@selector(learnMoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [learnMoreButton setTitle:learnMoreText forState:UIControlStateNormal];
    [learnMoreButton setTitleColor:t23BlueColor forState:UIControlStateNormal];
    learnMoreButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    learnMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    learnMoreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [learnMoreButton.heightAnchor constraintEqualToConstant:45.0].active = YES;
    
    //--------------------
    // - Questions Header Label
    UILabel *questionsHeaderLabel = [UILabel t23SubheaderLabelWithText:@"Questions?"];
    
    //--------------------
    // - Contact Study Button
    UIButton *contactStudyButton = [[UIButton alloc] init];
    NSString *contactStudyText = [NSString stringWithFormat:@"Contact %@", self.studyDisplayName];
    [contactStudyButton addTarget:self action:@selector(contactStudyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [contactStudyButton setTitle:contactStudyText forState:UIControlStateNormal];
    [contactStudyButton setTitleColor:t23BlueColor forState:UIControlStateNormal];
    contactStudyButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    contactStudyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    contactStudyButton.translatesAutoresizingMaskIntoConstraints = NO;
    [contactStudyButton.heightAnchor constraintEqualToConstant:45.0].active = YES;

    //--------------------
    // - Gene Pill Image View
    UIImage *genePillImage = [UIImage imageNamed:@"intro_chromosome_pink" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImageView *genePillImageView = [[UIImageView alloc] initWithImage:genePillImage];
    genePillImageView.contentMode = UIViewContentModeRight;
    
    //--------------------
    // Divider View
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:229.0/255.0 blue:230.0/255.0 alpha:1.0];
    [dividerView.heightAnchor constraintEqualToConstant:1.0].active = YES;
    
    UIStackView *topStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        titleLabel,
        missionDescriptionLabel,
        learnMoreButton,
        questionsHeaderLabel,
        contactStudyButton
    ]];
    topStackView.translatesAutoresizingMaskIntoConstraints = NO;
    topStackView.axis = UILayoutConstraintAxisVertical;
    topStackView.alignment = UIStackViewAlignmentFill;
    topStackView.layoutMargins = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    topStackView.layoutMarginsRelativeArrangement = YES;
    topStackView.spacing = 15.0;
    [self.view addSubview:topStackView];
    [topStackView setCustomSpacing:20.0 afterView:titleLabel];
    [topStackView setCustomSpacing:0.0 afterView:missionDescriptionLabel];
    [topStackView setCustomSpacing:10.0 afterView:learnMoreButton];
    [topStackView setCustomSpacing:-10.0 afterView:questionsHeaderLabel];
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
