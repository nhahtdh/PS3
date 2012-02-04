//
//  GameObject.m
// 

#import "GameObject.h"

@implementation GameObject

@dynamic objectType;
@dynamic canTranslate;
@dynamic canRotate;
@dynamic canZoom;

// @synthesize position;
@synthesize kGameObjectState;
@synthesize imageView;

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
    }
    
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    DLog(@"GameObject initWithCoder is called");
    if (self = [super initWithCoder: aDecoder]) {
        // TODO: Implement this later
    }
    
    return  self;
}

-(void) translate:(UIGestureRecognizer *)gesture {
    DLog(@"Pan gesture detected");
    if ([self canTranslate]) {
        
    } else {
        DLog(@"Translation rejected");
    }
}

-(void) zoom:(UIGestureRecognizer *)gesture {
    DLog(@"Pinch gesture detected");
    if ([self canZoom]) {
        
    } else {
        DLog(@"Zooming rejected");
    }
}

-(void) rotate:(UIGestureRecognizer *)gesture {
    DLog(@"Rotation gesture detected");
    if ([self canRotate]) {
        
    } else {
        DLog(@"Rotation rejected");
    }
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    DLog(@"Simultaneous gestures occured: %@ %@", [gestureRecognizer class], [otherGestureRecognizer class]);
    
    // Does not allow UITapGestureRecognizer (and instances of its subclass) to work simultaneously with other gestures
    if (![gestureRecognizer isKindOfClass: [UITapGestureRecognizer class]] && ![gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    
    return NO;
}

@end