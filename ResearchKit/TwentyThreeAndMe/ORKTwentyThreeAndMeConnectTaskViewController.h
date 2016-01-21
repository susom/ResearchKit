//
//  ORKTwentyThreeAndMeConnectTaskViewController.h
//  ResearchKit
//
//  Created by Andrew Schramm on 7/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

#import <ResearchKit/ResearchKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ORKTwentyThreeAndMeConnectTaskViewController;

/**
 The task view controller delegate is responsible for processing the results
 of the task, exerting some control over how the controller behaves, and providing
 auxiliary content as needed.
 */
@protocol ORKTwentyThreeAndMeConnectTaskViewControllerDelegate <NSObject>

/**
 Tells the delegate that the task has finished.
 */
- (void)twentyThreeAndMeConnectTaskViewController:(ORKTwentyThreeAndMeConnectTaskViewController *)twentyThreeAndMeConnectTaskViewController
                             didFinishWithResults:(NSDictionary *)results
                                            error:(nullable NSError *)error;

@end

/**
 *
 */
ORK_CLASS_AVAILABLE
@interface ORKTwentyThreeAndMeConnectTaskViewController : ORKTaskViewController

/**
 The delegate for the connect task view controller.
 */
@property (nonatomic, weak, nullable) id<ORKTwentyThreeAndMeConnectTaskViewControllerDelegate> twentyThreeAndMeConnectDelegate;

/**
 Returns a predefined task view controller that connects a participant with 23andMe
 
 TODO: Finish writing the detailed documentation for this method
 */
+ (ORKTwentyThreeAndMeConnectTaskViewController *)twentyThreeAndMeTaskViewControllerWithIdentifier:(NSString *)identifier
                                                                                      authClientId:(NSString *)clientId
                                                                                  authClientSecret:(NSString *)clientSecret
                                                                                        authScopes:(NSString *)scopes
                                                                           investigatorDisplayName:(NSString *)investigatorDisplayName
                                                                                  studyDisplayName:(NSString *)studyDisplayName
                                                                                 studyContactEmail:(NSString *)studyContactEmail;

@end

NS_ASSUME_NONNULL_END

