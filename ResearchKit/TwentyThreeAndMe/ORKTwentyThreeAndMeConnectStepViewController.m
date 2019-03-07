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

#import "ORKTwentyThreeAndMeConnectStepViewController.h"
#import "ORKTwentyThreeAndMeConnectStep.h"
#import "ORKHelpers_Internal.h"
#import "ORKSkin.h"
#import "ORKTwentyThreeAndMeConnectResult.h"
#import "ORKStepViewController_Internal.h"
#import "ORKNavigationContainerView_Internal.h"

@interface ORKTwentyThreeAndMeConnectStepViewController ()<WKNavigationDelegate> {
    NSArray<NSLayoutConstraint *> *_constraints;
}

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong, readonly) ORKNavigationContainerView *navigationFooterView;

@property (strong, nonatomic) NSMutableData *receivedData;

@property (nonatomic, strong) NSString *authToken;

@property (nonatomic, strong) NSString *refreshToken;

@end

@implementation ORKTwentyThreeAndMeConnectStepViewController

- (ORKTwentyThreeAndMeConnectStep *)connectStep {
    return (ORKTwentyThreeAndMeConnectStep *)self.step;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *wkConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkConfiguration];
    self.webView.navigationDelegate = self;
    NSString *contentURLString = [NSString stringWithFormat:@"%@/authorize/?redirect_uri=%@&response_type=code&client_id=%@&select_profile=true&scope=%@", [self connectStep].baseURL, [self connectStep].redirectURI, [self connectStep].clientId, [self connectStep].scopes];
    NSURL *contentURL = [NSURL URLWithString:contentURLString];
    NSURLRequest *nsRequest=[NSURLRequest requestWithURL:contentURL];
    [self.webView loadRequest:nsRequest];
    [self.view addSubview:self.webView];
    [self setNavigationFooterView];
    [self setupConstraints];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([UIApplication sharedApplication].isNetworkActivityIndicatorVisible) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)setNavigationFooterView {
    if (!_navigationFooterView) {
        _navigationFooterView = [ORKNavigationContainerView new];
    }
    _navigationFooterView.cancelButtonItem = self.cancelButtonItem;
    _navigationFooterView.hidden = self.isBeingReviewed;
    [_navigationFooterView updateContinueAndSkipEnabled];
    [self.view addSubview:_navigationFooterView];
}

- (void)setupConstraints {
    if (_constraints) {
        [NSLayoutConstraint deactivateConstraints:_constraints];
    }
    _constraints = nil;
    
    UIView *viewForiPad = [self viewForiPadLayoutConstraints];
    
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    _navigationFooterView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *containerView = viewForiPad ? : self.view;
    _constraints = @[
        [_webView.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [_webView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [_webView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [_webView.bottomAnchor constraintEqualToAnchor:_navigationFooterView.topAnchor],
        [_navigationFooterView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [_navigationFooterView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        [_navigationFooterView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
    ];
    [NSLayoutConstraint activateConstraints:_constraints];
}

#pragma mark - ORKStepResult

- (ORKStepResult *)result {
    ORKStepResult *sResult = [super result];
    
    // "Now" is the end time of the result, which is either actually now,
    // or the last time we were in the responder chain.
    NSDate *now = sResult.endDate;
    
    NSMutableArray *results = [NSMutableArray arrayWithArray:sResult.results];
    
    ORKTwentyThreeAndMeConnectResult *connectResult = [[ORKTwentyThreeAndMeConnectResult alloc] initWithIdentifier:self.step.identifier];
    connectResult.startDate = sResult.startDate;
    connectResult.endDate = now;
    connectResult.authToken = self.authToken;
    connectResult.refreshToken = self.refreshToken;
    
    [results addObject:connectResult];
    sResult.results = [results copy];
    
    return sResult;
}

#pragma mark - WebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        // Extract oauth_verifier from URL query
        NSString *authCode = nil;
        NSString *errorCode = nil;
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
            else if([key isEqualToString:@"error"])
            {
                errorCode = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (authCode) {
            NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@&scope=%@", [self connectStep].clientId, [self connectStep].clientSecret, authCode, [self connectStep].redirectURI, [self connectStep].scopes];
            NSString *tokenURL = [NSString stringWithFormat:@"%@/token/", [self connectStep].baseURL];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tokenURL]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            
            self.receivedData = [[NSMutableData alloc] init];
            NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [theConnection start];
        }
        else if (errorCode && [errorCode isEqualToString:@"access_denied"]) {
            [self goForward];
        }
        else {
            // Unexpected Request. Drop on floor for now.
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - NSURLConnectionDelegate - Handles Code to Token Connection

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if( self.receivedData )
    {
        [self.receivedData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    //Error
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( self.receivedData )
    {
        //NSLog( @"%@", self.receivedData );
        
        // DEBUGGING for Parse Issues
        const unsigned char *ptr = [self.receivedData bytes];
        NSString *jsonParsed = @"";
        for(int i=0; i<[self.receivedData length]; ++i) {
            unsigned char c = *ptr++;
            jsonParsed = [jsonParsed stringByAppendingFormat:@"%c", c];
        }
        //NSLog( @"Json Parsed: %@", jsonParsed );
        
        NSError *localError = nil;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingAllowFragments error:&localError];
        if( parsedData )
        {
            self.authToken = parsedData[@"access_token"];
            self.refreshToken = parsedData[@"refresh_token"];
        }
        
        [self goForward];
    }
}

@end
