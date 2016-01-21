//
//  ORKTwentyThreeAndMeConnectStepViewController.m
//  ResearchKit
//
//  Created by Andrew Schramm on 7/26/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import "ORKTwentyThreeAndMeConnectStepViewController.h"
#import "ORKTwentyThreeAndMeConnectStep.h"
#import "ORKHelpers.h"
#import "ORKSkin.h"
#import "ORKResult.h"

@interface ORKTwentyThreeAndMeConnectStepViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (strong, nonatomic) NSMutableData *receivedData;

@property (nonatomic) BOOL authenticated;

@property (nonatomic, strong) NSURLRequest *failedRequest;

@property (nonatomic, strong) NSString *authToken;

@property (nonatomic, strong) NSString *refreshToken;

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
    NSString *stringUrl = [NSString stringWithFormat:@"https://api.researchkit.23andme.io/authorize/?redirect_uri=%@&client_id=%@&scope=%@", [self connectStep].redirectURI, [self connectStep].clientId, [self connectStep].scopes];
    NSURL *contentURL = [NSURL URLWithString: [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL result = self.authenticated;
    if( ! self.authenticated ) {
        self.failedRequest = request;
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [urlConnection start];
        return result;
    }
    else {
        if ([[[request URL] host] isEqualToString:@"localhost"]) {
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
            
            if (authCode) {
                NSString *data = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@&scope=%@", [self connectStep].clientId, [self connectStep].clientSecret, authCode, [self connectStep].redirectURI, [self connectStep].scopes];
                NSString *tokenURL = @"https://api.researchkit.23andme.io/token/";
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tokenURL]];
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
                
                self.receivedData = [[NSMutableData alloc] init];
                NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                [theConnection start];
            }
            else {
                // ERROR!
            }
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:@"https://api.researchkit.23andme.io/"];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
        NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)pResponse {
    if( ! self.authenticated ) {
        self.authenticated = YES;
        [connection cancel];
        [self.webView loadRequest:self.failedRequest];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if( self.receivedData )
    {
        [self.receivedData appendData:data];
        //NSLog(@"verifier %@",self.receivedData);
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    //Error
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( self.authenticated &&
        self.receivedData )
    {
        //NSLog( @"%@", self.receivedData );
        
        // DEBUGGING for Parse Issues
        const unsigned char *ptr = [self.receivedData bytes];
        NSString *jsonParsed = @"";
        for(int i=0; i<[self.receivedData length]; ++i) {
            unsigned char c = *ptr++;
            jsonParsed = [jsonParsed stringByAppendingFormat:@"%c", c];
        }
        NSLog( @"Json Parsed: %@", jsonParsed );
        
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
