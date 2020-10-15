/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
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


#import "ORKCompletionStepViewController.h"

#import "ORKCustomStepView_Internal.h"
#import "ORKInstructionStepContainerView.h"
#import "ORKInstructionStepView.h"
#import "ORKNavigationContainerView.h"
#import "ORKStepHeaderView_Internal.h"
#import "ORKStepView_Private.h"
#import "ORKStepContainerView_Private.h"
#import "ORKStepContentView_Private.h"

#import "ORKInstructionStepViewController_Internal.h"
#import "ORKStepViewController_Internal.h"
#import "ORKCompletionCheckmarkView.h"
#import "ORKSkin.h"
#import "ORKHelpers_Internal.h"


static const CGFloat TickViewSize = 122;

@interface ORKCompletionStepView : UIView

@property (nonatomic) ORKCompletionCheckmarkView * completionCheckmarkView;

@end


@implementation ORKCompletionStepView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCheckmarkView];
        [self setupConstraints];
    }
    return self;
}

- (void)setupCheckmarkView {
    if (!_completionCheckmarkView) {
        _completionCheckmarkView = [[ORKCompletionCheckmarkView alloc] initWithDefaultDimension];
    }
    [self addSubview:_completionCheckmarkView];
}

- (void)setupConstraints {
    _completionCheckmarkView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint constraintWithItem:_completionCheckmarkView
                                                                           attribute:NSLayoutAttributeCenterX
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1.0
                                                                            constant:0.0],
                                              [NSLayoutConstraint constraintWithItem:_completionCheckmarkView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1.0
                                                                            constant:0.0]
                                              ]];
}

@end

@implementation ORKCompletionStepViewController {
    ORKCompletionCheckmarkView *_completionCheckmarkView;
}

- (void)stepDidChange {
    [super stepDidChange];
    
    self.cancelButtonItem = nil;
    _completionCheckmarkView = [self.stepView.stepContentView completionCheckmarkView];
    [_completionCheckmarkView setNeedsLayout];
    if (self.checkmarkColor) {
        _completionCheckmarkView.tintColor = self.checkmarkColor;
    }
    self.stepView.customContentFillsAvailableSpace = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _completionCheckmarkView.animationPoint = animated ? 0 : 1;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (animated) {
        [_completionCheckmarkView setAnimationPoint:1 animated:YES];
    }
}

- (void)setCheckmarkColor:(UIColor *)checkmarkColor {
    _checkmarkColor = [checkmarkColor copy];
    _completionCheckmarkView.tintColor = checkmarkColor;
}

@end


@interface ORKIncompletionCrossmarkView : ORKCompletionCheckmarkView

@end

@implementation ORKIncompletionCrossmarkView {
    CAShapeLayer *_shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = TickViewSize/2;
        [self tintColorDidChange];
        
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:(CGPoint){37,37}];
        [path addLineToPoint:(CGPoint){87,78}];
        [path moveToPoint:(CGPoint){87,37}];
        [path addLineToPoint:(CGPoint){37,78}];
        path.lineCapStyle = kCGLineCapRound;
        path.lineWidth = 5;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer new];
        shapeLayer.path = path.CGPath;
        shapeLayer.lineWidth = 5;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.frame = self.layer.bounds;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = nil;
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (NSString *)accessibilityLabel {
    return ORKLocalizedString(@"AX_INCOMPLETION_ILLUSTRATION", nil);
}

@end


@interface ORKIncompletionStepView : ORKCompletionStepView

@end


@implementation ORKIncompletionStepView

@dynamic completionCheckmarkView;

- (void)setupCheckmarkView {
    if (!self.completionCheckmarkView) {
        self.completionCheckmarkView = [[ORKIncompletionCrossmarkView alloc] initWithDefaultDimension];
    }
    [self addSubview:self.completionCheckmarkView];
}

@end


@implementation ORKIncompletionStepViewController {
    ORKCompletionStepView *_completionStepView;
}

- (void)stepDidChange {
    [super stepDidChange];
    
    _completionStepView = [ORKIncompletionStepView new];
    if (self.checkmarkColor) {
        _completionStepView.tintColor = self.checkmarkColor;
    }
    self.stepView.customContentFillsAvailableSpace = YES;
    self.stepView.customContentView = _completionStepView;
}

@end
