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

@property (strong, nonatomic) NSMutableData *receivedData;

@end

@implementation ORKTwentyThreeAndMeConnectStepViewController

- (ORKTwentyThreeAndMeConnectStep *)connectStep {
    return (ORKTwentyThreeAndMeConnectStep *)self.step;
}

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
    
    NSURL *contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.23andme.com/authorize/?redirect_uri=%@&client_id=%@&scope=%@", [self connectStep].redirectURI, [self connectStep].clientId, [self connectStep].scopes]];
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
//    if( navigationType == UIWebViewNavigationTypeLinkClicked )
//    {
//        [self goForward];
//        return NO;
//    }
    
    if ([[[request URL] host] isEqualToString:@"localhost"])
    {
        // Extract oauth_verifier from URL query
        NSString* authCode = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams)
        {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"])
            {
                authCode = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (authCode)
        {
            NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@&scope=%@", [self connectStep].clientId, [self connectStep].clientSecret, authCode, [self connectStep].redirectURI, [self connectStep].scopes];
            NSString *tokenURL = @"https://api.23andme.com/token/";
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tokenURL]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            
            self.receivedData = [[NSMutableData alloc] init];
            NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        }
        else
        {
            // ERROR!
        }
        
        return NO;
    }
    
    return YES;
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    NSLog(@"verifier %@",self.receivedData);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Error
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog( @"%@", self.receivedData );
    [self goForward];
//    SBJson4ValueBlock block = ^(id parsedValue, BOOL *stop)
//    {
//        if( [parsedValue isKindOfClass:[NSDictionary class]] )
//        {
//            NSDictionary *tokenResponse = (NSDictionary*)parsedValue;
//            [[Rest23Manager sharedManager] setupWithAuthDict:tokenResponse];
//            
//            [self.presenter performSelector:@selector(loginComplete)];
//        }
//    };
//    
//    SBJson4ErrorBlock eh = ^(NSError* err)
//    {
//        NSLog(@"Connection: Received JSON data failed to parse: %@", err);
//    };
//    
//    SBJson4Parser *parser = [SBJson4Parser parserWithBlock:block allowMultiRoot:NO unwrapRootArray:NO errorHandler:eh];
//    [parser parse:self.receivedData];
}

@end
