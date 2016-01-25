@import UIKit;
#import <ResearchKit/ORKDefines.h>
#import <ResearchKit/ORKInstructionStepViewController.h>

ORK_CLASS_AVAILABLE

@interface ORKIncompletionStepViewController : ORKInstructionStepViewController

/**
 Optional property to set the color of the cross mark. This allows the cross mark to use a different
 color from the tintColor of the parent view.
 */
@property (nonatomic, copy, nullable) UIColor *crossMarkColor;

@end
