//
//  GameObject.m
// 

#import "GameObject.h"
#import "GameWolf.h"
#import "GamePig.h"
#import "GameBlock.h"
#import "GameViewController.h"

@implementation GameObject

@synthesize kGameObjectState;
@dynamic defaultImageSize;
@dynamic defaultIconSize;
@synthesize imageView;

@dynamic kGameObjectType;
@synthesize angle;
@synthesize scale = scale_;

+ (GameObject*) GameObjectCreate:(GameObjectType)kGameObjectType {
    switch (kGameObjectType) {
        case kGameObjectWolf:
            return [[GameWolf alloc] init];
        case kGameObjectPig:
            return [[GamePig alloc] init];
        case kGameObjectBlock:
            return [[GameBlock alloc] init];
        default:
            return nil;
    }
}

-(id) init {
    DLog(@"GameObject init is called");
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(translate:)];
        [pan setMinimumNumberOfTouches: (NSUInteger) 1];
        [pan setMaximumNumberOfTouches: (NSUInteger) 1];
        [pan setDelegate: self];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(zoom:)];
        [pinch setDelaysTouchesBegan: 0.1];
        [pinch setDelegate: self];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action: @selector(rotate:)];
        [rotation setDelaysTouchesBegan: 0.1];
        [rotation setDelegate: self];
        
        [self.view addGestureRecognizer: pinch];
        [self.view addGestureRecognizer: rotation];
        [self.view addGestureRecognizer: pan];
        
        self.angle = 0.0;
        scale_ = 1.0;
    }
    
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    DLog(@"GameObject initWithCoder is called");
    if (self = [super initWithCoder: aDecoder]) {
        // TODO: Implement this later
    }
    
    return self;
}

-(void) resizeBaseWidth:(CGFloat)w height:(CGFloat)h {
    // [self.view setTransform: CGAffineTransformScale(self.view.transform, w / self.view.frame.size.width, h / self.view.frame.size.height)];
    [self.imageView setFrame: CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, w, h)];
    [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, w, h)];
}

-(BOOL) canTranslate {
    return YES;
}

-(BOOL) canRotate {
    return YES;
}

-(BOOL) canZoom {
    return YES;
}

-(void) translate:(UIPanGestureRecognizer *)gesture {
    DLog(@"Pan gesture detected on %@ object", [self class]);
    
    if ([self canTranslate]) {
        GameViewController *gameViewController = (GameViewController*) self.parentViewController;
        // assert(gesture.view == self.view);
        // assert(gameViewController != nil);
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            // Change ref. frame of center point from superview of object to the root view
            __startingPosition = [gameViewController.view convertPoint: self.view.center fromView: self.view.superview];
            
            // Place the object in the root view
            [gameViewController.view addSubview: self.view];
            
            // Scale the object to default size if from the palette
            if ([self kGameObjectState] == kGameObjectStateOnPalette) {
                [self resizeBaseWidth: self.defaultImageSize.width height: self.defaultImageSize.height];
            }
        }
        
        CGPoint delta = [gesture translationInView: self.view.superview];
        // DLog(@"Delta: %f %f", delta.x, delta.y);
        CGPoint translatedCenter = CGPointMake(__startingPosition.x + delta.x, __startingPosition.y + delta.y);
        DLog(@"%@ center: %f %f", [self class], translatedCenter.x, translatedCenter.y);
        [self.view setCenter: translatedCenter];
         
        if ([gesture state] == UIGestureRecognizerStateEnded) {
            CGPoint centerRelativeToGameArea = [gameViewController.gameArea convertPoint: translatedCenter fromView:gameViewController.view];
            
            if ([gameViewController.gameArea pointInside: centerRelativeToGameArea withEvent: nil]) {
                DLog(@"Center (%f, %f) is inside game area", centerRelativeToGameArea.x, centerRelativeToGameArea.y);
                
                self.kGameObjectState = kGameObjectStateOnGameArea;
                
                // Place the object into game area and adjust the center accordingly
                [gameViewController.gameArea addSubview: self.view];
                [self.view setCenter: centerRelativeToGameArea];
            }
        }
        
        if ([gesture state] == UIGestureRecognizerStateCancelled ||
            [gesture state] == UIGestureRecognizerStateFailed) {
            DLog(@"WARNING: Gesture failed or cancelled");
        }
        
    } else {
        DLog(@"Translation rejected");
    }
}

-(void) zoom:(UIPinchGestureRecognizer *)gesture {
    DLog(@"Pinch gesture detected on %@ object", [self class]);
    if ([self canZoom]) {
        DLog(@"Scale: %f", [gesture scale]);
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            __previousScale = 1.0;
        }
        
        CGFloat scaleStep = [gesture scale] / __previousScale;
        [self.view setTransform: CGAffineTransformScale(self.view.transform, scaleStep, scaleStep)];
        
        __previousScale = [gesture scale];
        
        if ([gesture state] == UIGestureRecognizerStateEnded) {
            scale_ *= [gesture scale];
            DLog(@"Final scale: %f", scale_);
        }
        
        
        if ([gesture state] == UIGestureRecognizerStateCancelled ||
            [gesture state] == UIGestureRecognizerStateFailed) {
            DLog(@"WARNING: Gesture failed or cancelled");
        }
    } else {
        DLog(@"Zooming rejected on %@ object", [self class]);
    }
}

-(void) rotate:(UIRotationGestureRecognizer *)gesture {
    DLog(@"Rotation gesture detected on %@ object", [self class]);
    if ([self canRotate]) {
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            __previousRotation = 0.0;
        }
        
        CGFloat rotationalChange = [gesture rotation] - __previousRotation;
        // self.angle += rotationalChange;
        [self.view setTransform: CGAffineTransformRotate(self.view.transform, rotationalChange)];

        __previousRotation = [gesture rotation];
        
        if ([gesture state] == UIGestureRecognizerStateEnded) {
            self.angle += [gesture rotation];
            // Limit the angle to [0, 2 * PI)
            self.angle -= floor(self.angle / M_PI / 2) * M_PI * 2;
            
            DLog(@"Delta: %f", [gesture rotation]);
            DLog(@"Final angle: %f", self.angle / M_PI * 180);
        }
        
        if ([gesture state] == UIGestureRecognizerStateCancelled ||
            [gesture state] == UIGestureRecognizerStateFailed) {
            DLog(@"WARNING: Gesture failed or cancelled");
        }
        
    } else {
        DLog(@"Rotation rejected on %@ object", [self class]);
    }
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    DLog(@"Simultaneous gestures occured: %@ %@", [gestureRecognizer class], [otherGestureRecognizer class]);

    // Only allow pinch and rotation gestures to work together
    if (([gestureRecognizer isKindOfClass: [UIPinchGestureRecognizer class]] &&
         [otherGestureRecognizer isKindOfClass: [UIRotationGestureRecognizer class]]) || 
        ([gestureRecognizer isKindOfClass: [UIRotationGestureRecognizer class]] &&
         [otherGestureRecognizer isKindOfClass: [UIPinchGestureRecognizer class]])) {
            return YES;
    }
    
    return NO;
}

@end