//
//  GameBlock.m
//  Game
//
//  Created by  on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameBlock.h"

@implementation GameBlock

-(GameObjectType) objectType {
    return kGameObjectBlock;
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

#pragma mark - View life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [super.view setAutoresizesSubviews:YES];
    
    UIImage *blockImage = [UIImage imageNamed: @"straw.png"];
    UIImageView *blockImageView = [[UIImageView alloc] initWithImage:blockImage];
    
    [self.view addSubview: blockImageView];
    [self.view setFrame: CGRectMake(0, 0, blockImage.size.width, blockImage.size.height)];
    [self.view setBackgroundColor: [UIColor clearColor]];
}

@end
