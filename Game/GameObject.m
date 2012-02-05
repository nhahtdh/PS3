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

-(id) init {
    DLog(@"GameObject init is called");
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(translate:)];
        [pan setMinimumNumberOfTouches: (NSUInteger) 1];
        [pan setMaximumNumberOfTouches: (NSUInteger) 2];
        [pan setDelegate: self];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(zoom:)];
        [pinch setDelegate: self];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action: @selector(rotate:)];
        [rotation setDelegate: self];
        
        [self.view addGestureRecognizer: pan];
        [self.view addGestureRecognizer: pinch];
        [self.view addGestureRecognizer: rotation];
        
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
        assert(gesture.view == self.view);
        assert(gameViewController != nil);
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            // Place the object in the root view
            // [self.view removeFromSuperview];
            [gameViewController.view addSubview: self.view];
            // [self.view removeFromSuperview];
            // [gameViewController.view bringSubviewToFront: self.view];
            // [self.view removeFromSuperview];
            
            // Scale the object to default size
            [self scaleToFitWidth: self.defaultImageSize.width height: self.defaultImageSize.height];
            
            startingPoint = self.view.center;
        }
        
        CGPoint delta = [gesture translationInView: gameViewController.view];
        DLog(@"Delta: %f %f", delta.x, delta.y);
        CGPoint translatedCenter = CGPointMake(startingPoint.x + delta.x, startingPoint.y + delta.y);
        DLog(@"Center: %f %f", translatedCenter.x, translatedCenter.y);
        [self.view setCenter: translatedCenter];
        // startingPoint = translatedCenter;
        
        if ([gesture state] == UIGestureRecognizerStateCancelled) {
            DLog(@"WARNING: Cancelled");
            // gesture 
        }
        
        /*
        GameViewController *gameViewController = (GameViewController*) self.parentViewController;
        // [gameViewController.view bringSubviewToFront: gameViewController.palette];
        // [gameViewController.view bringSubviewToFront: self.view];
        
        // There seems to be a bit of jittery in the implementation with translationInView
        if ([gesture state] == UIGestureRecognizerStateBegan) {
            // Normalize the center point to the root view
            // startingPoint = [gameViewController.view convertPoint: self.view.center fromView: self.view];
            
            startingPoint = self.view.center;
            // startingPoint = [gesture locationInView: gameViewController.view];
            // [gameViewController.gameArea setScrollEnabled: NO];
        }
        
        CGPoint delta = [gesture translationInView: gameViewController.view];
        // CGPoint delta = [gesture
        // CGPoint currentPoint = [gesture locationInView: gameViewController.view];
        
        CGPoint translatedCenter = CGPointMake(startingPoint.x + delta.x, startingPoint.y + delta.y);
        // CGPoint translatedCenter = CGPointMake(self.view.center.x + currentPoint.x - startingPoint.x, 
        //                                        self.view.center.y + currentPoint.y - startingPoint.y);
        DLog(@"%f %f", translatedCenter.x, translatedCenter.y);
        
        [self.view setCenter: translatedCenter];
        
        // startingPoint = currentPoint;
        DLog(@"GameViewController: %@", gameViewController);
        CGPoint centerByPalette = [gameViewController.palette convertPoint: translatedCenter fromView: gameViewController.view];
        // if ([gameViewController.palette pointInside: translatedCenter withEvent:nil]) {
        if ([gameViewController.palette pointInside: centerByPalette withEvent: nil]) {
            DLog(@"Palette point inside success: %f %f", translatedCenter.x, translatedCenter.y);
            // [self.view setCenter: centerByPalette];
        } else { // Point outside palette, consider it inside the scroll view
            DLog(@"Palette point inside failed: %f %f", translatedCenter.x, translatedCenter.y);
            // CGPoint centerByGameArea = [gameViewController.gameArea convertPoint: translatedCenter fromView:gameViewController.view];
            // [self.view setCenter: centerByGameArea];
            if ([self kGameObjectState] == kGameObjectStateOnPalette) {
                CGPoint centerByGameArea = [gameViewController.gameArea convertPoint: translatedCenter fromView:self.view];
                [self setKGameObjectState: kGameObjectStateOnGameArea];
                [self scaleToFitWidth: self.defaultImageSize.width height:self.defaultImageSize.height];
                
                [self.view removeFromSuperview];
                [gameViewController.gameArea addSubview: self.view];
                
                [gameViewController.inPlayGameObjects addObject: self];
                [gameViewController.paletteGameObjects removeObject: self];
                
                // [self scaleToFitWidth:<#(CGFloat)#> height:<#(CGFloat)#>
            }
        }
        
        if ([gesture state] == UIGestureRecognizerStateEnded || [gesture state] == UIGestureRecognizerStateCancelled) {
            // [gameViewController.gameArea setScrollEnabled: YES];
        }
        */
    } else {
        DLog(@"Translation rejected");
    }
}

-(void) zoom:(UIGestureRecognizer *)gesture {
    DLog(@"Pinch gesture detected on %@ object", [self class]);
    if ([self canZoom]) {
        
    } else {
        DLog(@"Zooming rejected on %@ object", [self class]);
    }
}

-(void) rotate:(UIGestureRecognizer *)gesture {
    DLog(@"Rotation gesture detected on %@ object", [self class]);
    if ([self canRotate]) {
        
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