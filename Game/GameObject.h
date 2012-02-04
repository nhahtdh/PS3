//
//  GameObject.h
// 
//

#import <UIKit/UIKit.h>

// Constants for the three game objects to be implemented
typedef enum {kGameObjectWolf, kGameObjectPig, kGameObjectBlock} GameObjectType;

@interface GameObject : UIViewController {
    // You might need to add state here.
    // CGPoint center;
    UIImageView* imageView;
    CGAffineTransform* transform;
}

// @property (nonatomic) CGPoint center;

// TODO: Possible to use this + a game state to check whether should translate/rotate/zoom
@property (strong, nonatomic) UIImageView* imageView;

@property (nonatomic, readonly) BOOL canTranslate;
@property (nonatomic, readonly) BOOL canRotate;
@property (nonatomic, readonly) BOOL canZoom;
@property (nonatomic, readonly) GameObjectType objectType;

- (void)translate:(UIGestureRecognizer *)gesture;
// MODIFIES: object model (coordinates)
// REQUIRES: game in designer mode
// EFFECTS: the user drags around the object with one finger
//          if the object is in the palette, it will be moved in the game area

- (void)rotate:(UIGestureRecognizer *)gesture;
// MODIFIES: object model (rotation)
// REQUIRES: game in designer mode, object in game area
// EFFECTS: the object is rotated with a two-finger rotation gesture

- (void)zoom:(UIGestureRecognizer *)gesture;
// MODIFIES: object model (size)
// REQUIRES: game in designer mode, object in game area
// EFFECTS: the object is scaled up/down with a pinch gesture

// You will need to define more methods to complete the specification. 

@end
