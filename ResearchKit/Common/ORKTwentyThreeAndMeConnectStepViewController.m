//
//  ORKTwentyThreeAndMeConnectStepViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/26/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeConnectStepViewController.h"
#import "ORKTwentyThreeAndMeConnectStep.h"
#import "ORKHelpers_Internal.h"
#import "ORKSkin.h"

@interface ORKTwentyThreeAndMeConnectStepViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ORKTwentyThreeAndMeConnectStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ORKColor(ORKBackgroundColorKey);
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    const CGFloat horizMargin = ORKStandardLeftMarginForTableViewCell(self.view);
    _webView.backgroundColor = ORKColor(ORKBackgroundColorKey);
    _webView.scrollView.backgroundColor = ORKColor(ORKBackgroundColorKey);
    
    _webView.clipsToBounds = NO;
    _webView.scrollView.clipsToBounds = NO;
    _webView.scrollView.scrollIndicatorInsets = (UIEdgeInsets){.left = -horizMargin, .right = -horizMargin};
    _webView.opaque = NO; // If opaque is set to YES, _webView shows a black right margin during transition when modally presented. This is an artifact due to disabling clipsToBounds to be able to show the scroll indicator outside the view.
    
    [_webView setScalesPageToFit:YES];
    
    NSURL *contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.23andme.com/"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:contentURL]];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self setupConstraints];
}

- (void)setupConstraints {
    NSMutableArray *constraints = [NSMutableArray new];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_webView);
    const CGFloat horizMargin = ORKStandardLeftMarginForTableViewCell(self.view);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-horizMargin-[_webView]-horizMargin-|"
                                                                             options:(NSLayoutFormatOptions)0
                                                                             metrics:@{ @"horizMargin": @(horizMargin) }
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|"
                                                                             options:(NSLayoutFormatOptions)0 metrics:nil
                                                                               views:views]];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if( navigationType == UIWebViewNavigationTypeLinkClicked )
    {
        [self goForward];
        return NO;
    }
    
    return YES;
}

@end
