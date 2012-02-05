//
//  GameObject.m
// 

#import "GameObject.h"
#import "GameViewController.h"

@implementation GameObject

@synthesize kGameObjectState;
@dynamic defaultImageSize;
@dynamic defaultIconSize;
@synthesize imageView;

@dynamic kGameObjectType;
@synthesize angle;

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
        
        // [self.view setExclusiveTouch: YES];
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

-(void) scaleToFitWidth:(CGFloat)w height:(CGFloat)h {
    [self.view setTransform: CGAffineTransformScale(self.view.transform, w / self.view.frame.size.width, h / self.view.frame.size.height)];
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
    static CGPoint startingPoint;

    if ([self canTranslate]) {
        GameViewController *gameViewController = (GameViewController*) self.parentViewController;
        // assert(gesture.view == self.view);
        // assert(gameViewController != nil);
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            // Change ref. frame of center point from superview of object to the root view
            startingPoint = [gameViewController.view convertPoint: self.view.center fromView: self.view.superview];
            
            // Place the object in the root view
            [gameViewController.view addSubview: self.view];
            
            // Scale the object to default size
            [self scaleToFitWidth: self.defaultImageSize.width height: self.defaultImageSize.height];
        }
        
        CGPoint delta = [gesture translationInView: self.view.superview];
        // DLog(@"Delta: %f %f", delta.x, delta.y);
        CGPoint translatedCenter = CGPointMake(startingPoint.x + delta.x, startingPoint.y + delta.y);
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
        
    } else {
        DLog(@"Translation rejected");
    }
}

-(void) zoom:(UIGestureRecognizer *)gesture {
    DLog(@"Pinch gesture detected on %@ object", [self class]);
    if ([self canZoom]) {
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            // gesture set
        }
    } else {
        DLog(@"Zooming rejected on %@ object", [self class]);
    }
}

-(void) rotate:(UIRotationGestureRecognizer *)gesture {
    // Buggy rotation
    DLog(@"Rotation gesture detected on %@ object", [self class]);
    static CGFloat lastRotation;
    if ([self canRotate]) {
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            lastRotation = 0.;
        }
        
        CGFloat rotationalChange = [gesture rotation] - lastRotation;
        self.angle += rotationalChange;
        [self.view setTransform: CGAffineTransformRotate(self.view.transform, rotationalChange)];
        // [self.view setBounds: CGRectMake(0, 0, 50, 80)];
        // [self.view setFrame: CGRectMake(0, 0, 50, 80)];
        // [self.view setTransform: CGAffineTransformMakeRotation(lastRotation)];
       // [self.view setBounds: CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,
         //                                self.view.bounds.size.width * cos(self.angle) , <#CGFloat height#>)
        lastRotation = [gesture rotation];
        
        if ([gesture state] == UIGestureRecognizerStateEnded) {
            // self.angle += [gesture rotation];
            self.angle -= floor(self.angle / M_PI / 2) * M_PI * 2;
            DLog(@"Final angle: %f", self.angle);
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