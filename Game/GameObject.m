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
@synthesize imageView;

-(id) init {
    DLog(@"GameObject init is called");
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(translate:)];
        [pan setMinimumNumberOfTouches: (NSUInteger) 1];
        [pan setMaximumNumberOfTouches: (NSUInteger) 1];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(zoom:)];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action: @selector(rotate:)];
        
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
    DLog(@"Pan gesture?");
}

-(void) zoom:(UIGestureRecognizer *)gesture {
    DLog(@"Pinch gesture?");
}

-(void) rotate:(UIGestureRecognizer *)gesture {
    DLog(@"Rotation gesture?");
}

@end