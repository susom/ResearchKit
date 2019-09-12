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

#import "ORKTwentyThreeAndMeIntroViewController.h"
#import "ORKTwentyThreeAndMeIntroStep.h"
#import "ORKTwentyThreeAndMeIntroPage1ViewController.h"
#import "ORKTwentyThreeAndMeIntroPage2ViewController.h"
#import "ORKTwentyThreeAndMeIntroPage3ViewController.h"
#import "UIButton+T23.h"
#import "UILabel+T23.h"

@interface ORKTwentyThreeAndMeIntroViewController() <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic) UIPageViewController *pageViewController;

@property (nonatomic) NSArray *pages;

@property (nonatomic) NSString *investigatorDisplayName;

@property (nonatomic) NSString *studyDisplayName;

@property (nonatomic) NSString *studyContactEmail;

@end

@implementation ORKTwentyThreeAndMeIntroViewController

- (ORKTwentyThreeAndMeIntroStep *)introStep {
    return (ORKTwentyThreeAndMeIntroStep *)self.step;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ORKTwentyThreeAndMeIntroStep *introStep = [self introStep];
    self.investigatorDisplayName = introStep.investigatorDisplayName;
    self.studyDisplayName = introStep.studyDisplayName;
    self.studyContactEmail = introStep.studyContactEmail;
    
//    ORKTwentyThreeAndMeIntroPage1ViewController *pageVC1 = [[ORKTwentyThreeAndMeIntroPage1ViewController alloc] init];
//    pageVC1.investigatorDisplayName = self.investigatorDisplayName;
//    pageVC1.studyDisplayName = self.studyDisplayName;
//    pageVC1.studyContactEmail = self.studyContactEmail;
    ORKTwentyThreeAndMeIntroPage2ViewController *pageVC2 = [[ORKTwentyThreeAndMeIntroPage2ViewController alloc] init];
    pageVC2.investigatorDisplayName = self.investigatorDisplayName;
    pageVC2.studyDisplayName = self.studyDisplayName;
    pageVC2.studyContactEmail = self.studyContactEmail;
    ORKTwentyThreeAndMeIntroPage3ViewController *pageVC3 = [[ORKTwentyThreeAndMeIntroPage3ViewController alloc] init];
    pageVC3.investigatorDisplayName = self.investigatorDisplayName;
    pageVC3.studyDisplayName = self.studyDisplayName;
    pageVC3.studyContactEmail = self.studyContactEmail;
//    self.pages = @[pageVC1, pageVC2, pageVC3];
    self.pages = @[pageVC2, pageVC3];
    
    [self setupAppearance];
    
    [self.pageViewController setViewControllers:@[pageVC2]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    self.cancelButtonItem = nil;
    self.backButtonItem = nil;
}

- (void)shareButtonPressed:(UIButton *)sender {
    [self goForward];
}

- (void)declineButtonPressed:(UIButton *)sender {
    NSString *alertMessage = [NSString stringWithFormat:@"Are you sure you want to decline adding your genetic data to %@?", self.studyDisplayName];
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:alertMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    UIAlertAction *declineAction = [UIAlertAction actionWithTitle:@"Decline"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self.taskViewController.delegate taskViewController:self.taskViewController didFinishWithReason:ORKTaskViewControllerFinishReasonDiscarded error:nil];
                                                             
                                                         }];
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:declineAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)setupAppearance {
    //--------------------
    // Page View Controller Control Appearance
    UIPageControl *pageControl = nil;
    if( [UIPageControl instancesRespondToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)] ) {
        pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[ORKTwentyThreeAndMeIntroViewController class]]];
    }
    else {
        pageControl = [UIPageControl appearance];
    }
    pageControl.pageIndicatorTintColor = [UIColor t23LightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor t23GrayColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    //--------------------
    // Page View Controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.pageViewController.view.topAnchor constant:20.0].active = YES;
    [self.view.leadingAnchor constraintEqualToAnchor:self.pageViewController.view.leadingAnchor].active = YES;
    [self.view.trailingAnchor constraintEqualToAnchor:self.pageViewController.view.trailingAnchor].active = YES;
    
    //--------------------
    // Share Button
    UIButton *shareButton = [UIButton t23ButtonWithText:@"Add Genetic Data" andHasBorder:YES];
    [self.view addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [shareButton.topAnchor constraintEqualToAnchor:self.pageViewController.view.bottomAnchor].active = YES;
    [shareButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    //--------------------
    // Decline Button
    UIButton *declineButton = [UIButton t23ButtonWithText:@"Decline" andHasBorder:NO];
    [self.view addSubview:declineButton];
    [declineButton addTarget:self action:@selector(declineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    declineButton.translatesAutoresizingMaskIntoConstraints = NO;
    [declineButton.topAnchor constraintEqualToAnchor:shareButton.bottomAnchor].active = YES;
    [declineButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    //--------------------
    // Bottom
    [declineButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger indexOfCurrentPage = (NSInteger)[self.pages indexOfObject:viewController];
    if( indexOfCurrentPage - 1 >= 0 )
    {
        return self.pages[indexOfCurrentPage - 1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger indexOfCurrentPage = (NSInteger)[self.pages indexOfObject:viewController];
    if( indexOfCurrentPage + 1 < [self.pages count] )
    {
        return self.pages[indexOfCurrentPage + 1];
    }
    
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    UIViewController *currentPageViewController = [pageViewController.viewControllers firstObject];
    if( currentPageViewController )
    {
        return [self.pages indexOfObject:currentPageViewController];
        
    }
    return 0;
}


@end

