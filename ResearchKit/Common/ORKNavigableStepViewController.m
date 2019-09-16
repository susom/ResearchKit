//
//  ORKNavigableStepViewController.m
//  CardioHealth
//
//  Created by Paweł Kowalczyk on 07/03/2019.
//  Copyright © 2019 Stanford Medical. All rights reserved.
//

#import "ORKNavigableStepViewController.h"

#import "ORKNavigationContainerView_Internal.h"
#import "ORKStepContainerView.h"
#import "ORKStepContainerView_Private.h"
#import "ORKStepViewController_Internal.h"

#import "ORKStep_Private.h"

#import "ORKHelpers_Internal.h"

@interface ORKNavigableStepViewController ()

@property (nonatomic, strong, nullable) ORKStepContainerView *stepView;

@end

@implementation ORKNavigableStepViewController {
    ORKNavigationContainerView *_navigationFooterView;
    NSArray<NSLayoutConstraint *> *_constraints;
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    _contentView = contentView;
    self.stepView.customContentView = _contentView;
    self.stepView.customContentFillsAvailableSpace = YES;
    [self.stepView.navigationFooterView.continueButton setHidden:self.continueButtonHidden];
    [self.stepView.navigationFooterView.cancelButton setHidden:self.cancelButtonHidden];
    self.stepView.stepTitle = self.step.title;
}

- (BOOL)contentFillsAvailableSpace
{
    return self.stepView.customContentFillsAvailableSpace;
}

- (void)setContentFillsAvailableSpace:(BOOL)contentFillsAvailableSpace
{
    self.stepView.customContentFillsAvailableSpace = contentFillsAvailableSpace;
}

- (void)stepDidChange {
    [super stepDidChange];
    
    [self.stepView removeFromSuperview];
    self.stepView = nil;
    
    if (self.step && [self isViewLoaded]) {
        self.stepView = [[ORKStepContainerView alloc] init];
        [self.view addSubview:self.stepView];
        [self setNavigationFooterView];
        [self setupConstraints];
    }
}

- (void)setNavigationFooterView {
    if (_stepView) {
        _navigationFooterView = _stepView.navigationFooterView;
        _navigationFooterView.continueButtonItem = self.continueButtonItem;
        _navigationFooterView.continueEnabled = YES;
        _navigationFooterView.cancelButtonItem = self.cancelButtonItem;
        _navigationFooterView.hidden = self.isBeingReviewed;
        [_navigationFooterView updateContinueAndSkipEnabled];
    }
}

- (void)setupConstraints {
    if (_constraints) {
        [NSLayoutConstraint deactivateConstraints:_constraints];
    }
    self.stepView.translatesAutoresizingMaskIntoConstraints = NO;
    _constraints = nil;
    _constraints = @[
                     [NSLayoutConstraint constraintWithItem:self.stepView
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:self.stepView
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:self.stepView
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:self.stepView
                                                  attribute:NSLayoutAttributeBottom
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0
                                                   constant:0.0]
                     ];
    [NSLayoutConstraint activateConstraints:_constraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self stepDidChange];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_stepView setNeedsUpdateConstraints];
}


- (void)useAppropriateButtonTitleAsLastBeginningInstructionStep {
    self.internalContinueButtonItem.title = ORKLocalizedString(@"BUTTON_GET_STARTED", nil);
}

- (void)setContinueButtonItem:(UIBarButtonItem *)continueButtonItem {
    [super setContinueButtonItem:continueButtonItem];
    _navigationFooterView.continueButtonItem = continueButtonItem;
}

- (void)setCancelButtonItem:(UIBarButtonItem *)cancelButtonItem {
    [super setCancelButtonItem:cancelButtonItem];
    _navigationFooterView.cancelButtonItem = cancelButtonItem;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
}

@end
