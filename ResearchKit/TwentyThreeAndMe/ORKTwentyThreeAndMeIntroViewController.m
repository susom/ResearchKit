//
//  ORKTwentyThreeAndMeIntroViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 1/21/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

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
    
    ORKTwentyThreeAndMeIntroPage1ViewController *pageVC1 = [[ORKTwentyThreeAndMeIntroPage1ViewController alloc] init];
    pageVC1.investigatorDisplayName = self.investigatorDisplayName;
    pageVC1.studyDisplayName = self.studyDisplayName;
    pageVC1.studyContactEmail = self.studyContactEmail;
    ORKTwentyThreeAndMeIntroPage2ViewController *pageVC2 = [[ORKTwentyThreeAndMeIntroPage2ViewController alloc] init];
    pageVC2.investigatorDisplayName = self.investigatorDisplayName;
    pageVC2.studyDisplayName = self.studyDisplayName;
    pageVC2.studyContactEmail = self.studyContactEmail;
    ORKTwentyThreeAndMeIntroPage3ViewController *pageVC3 = [[ORKTwentyThreeAndMeIntroPage3ViewController alloc] init];
    pageVC3.investigatorDisplayName = self.investigatorDisplayName;
    pageVC3.studyDisplayName = self.studyDisplayName;
    pageVC3.studyContactEmail = self.studyContactEmail;
    self.pages = @[pageVC1, pageVC2, pageVC3];
    
    [self setupAppearance];
    
    [self.pageViewController setViewControllers:@[pageVC1]
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
    NSString *alertMessage = [NSString stringWithFormat:@"Are you sure you want to decline adding your genetic data to %@? Declining may impact your eligibility for this study.", self.studyDisplayName];
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
    // Style
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // Page View Controller Control Appearance
    UIPageControl *pageControl = nil;
    if( [UIPageControl instancesRespondToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)] ) {
        pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[ORKTwentyThreeAndMeIntroViewController class]]];
    }
    else {
        pageControl = [UIPageControl appearance];
    }
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:51.0/255.0 green:52.0/255.0 blue:53.0/255.0 alpha:1.0];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    //--------------------
    // Page View Controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageViewController.view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageViewController.view
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageViewController.view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Share Button
    UIButton *shareButton = [UIButton t23ButtonWithText:@"Add Genetic Data" andHasBorder:YES];
    [self.view addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:shareButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.pageViewController.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:shareButton
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
                                                             toItem:shareButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:declineButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //--------------------
    // Bottom
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:declineButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
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

