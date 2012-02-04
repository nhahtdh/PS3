//
//  GameBlock.m
//  Game
//
//  Created by  on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameBlock.h"

NSString* const kBlockImageFileNames[] =  {@"straw.png", @"wood.png", @"iron.png", @"stone.png"};

@implementation GameBlock

@synthesize kBlockType;

+ (NSString*) getBlockImageFileName: (GameBlockType) blockType {
    return kBlockImageFileNames[blockType];
}

- (void) setNextBlockType {
    self.kBlockType = (self.kBlockType + 1) % 4;
}

-(id) init {
    if (self = [super init]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(changeBlockType:)];
        [tap setNumberOfTapsRequired: 1];
        [tap setNumberOfTouchesRequired: 1];
        
        [self.view addGestureRecognizer: tap];
    }
    
    return  self;
}

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

-(void) changeBlockType:(UIGestureRecognizer *)gesture {
    DLog(@"Tap?");
    if (![gesture isMemberOfClass: [UITapGestureRecognizer class]]) {
        DLog(@"WARNING: Something is wrong here");
    }
    
    [self setNextBlockType];
    [imageView setImage: [UIImage imageNamed: [GameBlock getBlockImageFileName:kBlockType]]];
    // [self.view subviews
}

#pragma mark - View life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    DLog(@"Block viewDidLoad called.");
    
    [super.view setAutoresizesSubviews:YES];
    
    kBlockType = kGameBlockStraw;
    UIImage *blockImage = [UIImage imageNamed: [GameBlock getBlockImageFileName: kBlockType]];
    // UIImageView *blockImageView = [[UIImageView alloc] initWithImage:blockImage];
    imageView = [[UIImageView alloc] initWithImage:blockImage];
    
    // [self.view addSubview: blockImageView];
    [self.view addSubview: imageView];
    [self.view setFrame: CGRectMake(0, 0, blockImage.size.width, blockImage.size.height)];
    [self.view setBackgroundColor: [UIColor clearColor]];
}

@end
