#import "ORKIncompletionStepViewController.h"

#import "ORKCustomStepView_Internal.h"
#import "ORKInstructionStepView.h"
#import "ORKNavigationContainerView.h"
#import "ORKStepHeaderView_Internal.h"
#import "ORKVerticalContainerView_Internal.h"

#import "ORKInstructionStepViewController_Internal.h"
#import "ORKStepViewController_Internal.h"

#import "ORKHelpers_Internal.h"


@interface ORKIncompletionStepView : ORKActiveStepCustomView

@property (nonatomic) CGFloat animationPoint;

- (void)setAnimationPoint:(CGFloat)animationPoint animated:(BOOL)animated;

@end


@implementation ORKIncompletionStepView {
    CAShapeLayer *_shapeLayer;
}

static const CGFloat TickViewSize = 122;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    _shapeLayer.frame = self.layer.bounds;
}

- (CGSize)intrinsicContentSize {
    return (CGSize){TickViewSize,TickViewSize};
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (void)tintColorDidChange {
    self.backgroundColor = [self tintColor];
}

- (void)setAnimationPoint:(CGFloat)animationPoint {
    _shapeLayer.strokeEnd = animationPoint;
    _animationPoint = animationPoint;
}

- (void)setAnimationPoint:(CGFloat)animationPoint animated:(BOOL)animated {
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.180739998817444 :0 :0.577960014343262 :0.918200016021729];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [animation setTimingFunction:timing];
    [animation setFillMode:kCAFillModeBoth];
    animation.fromValue = @([(CAShapeLayer *)[_shapeLayer presentationLayer] strokeEnd]);
    animation.toValue = @(animationPoint);
    
    animation.duration = 0.3;
    _animationPoint = animationPoint;
    
    _shapeLayer.strokeEnd = animationPoint;
    [_shapeLayer addAnimation:animation forKey:@"strokeEnd"];
    
}

- (BOOL)isAccessibilityElement {
    return YES;
}

- (UIAccessibilityTraits)accessibilityTraits {
    return [super accessibilityTraits] | UIAccessibilityTraitImage;
}

- (NSString *)accessibilityLabel {
    return ORKLocalizedString(@"AX_INCOMPLETION_ILLUSTRATION", nil);
}

@end


@implementation ORKIncompletionStepViewController {
    ORKIncompletionStepView *_completionStepView;
}

- (void)stepDidChange {
    [super stepDidChange];
    
    _completionStepView = [ORKIncompletionStepView new];
    if (self.crossMarkColor) {
        _completionStepView.tintColor = self.crossMarkColor;
    }
    
    self.stepView.stepView = _completionStepView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _completionStepView.animationPoint = animated ? 0 : 1;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (animated) {
        [_completionStepView setAnimationPoint:1 animated:YES];
    }
}

- (void)setCrossMarkColor:(UIColor *)crossMarkColor {
    _crossMarkColor = [crossMarkColor copy];
    _completionStepView.tintColor = crossMarkColor;
}

@end
