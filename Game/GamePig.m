//
//  GamePig.m
//  Game
//
//  Created by  on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePig.h"

@implementation GamePig

-(GameObjectType) objectType {
    return kGameObjectPig;
}

-(BOOL) canTranslate {
    return YES;
}

-(BOOL) canRotate {
    return NO;
}

-(BOOL) canZoom {
    return YES;
}

#pragma mark - View life cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    DLog(@"Pig viewDidLoad");
    
    [self.view setAutoresizesSubviews: YES];
    
    UIImage *pigImage = [UIImage imageNamed:@"pig.png"];
    UIImageView *pigImageView = [[UIImageView alloc] initWithImage: pigImage];
    
    [self.view addSubview: pigImageView];
    [self.view setFrame: CGRectMake(0, 0, pigImage.size.width, pigImage.size.height)];
    [self.view setBackgroundColor: [UIColor clearColor]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
