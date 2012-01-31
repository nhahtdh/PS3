//
//  GameWolf.m
//  Game
//
//  Created by  on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameWolf.h"

@implementation GameWolf

-(GameObjectType) objectType {
    return kGameObjectWolf;
}

+ (CGRect) getBoundingBoxAt: (NSInteger)frameNumber {
    // REQUIRE: 0 <= frameNumber < total number of frames in wolfs.png
    //          The numbering starts from top-left corner, from left-to-right,
    //          then top-to-bottom
    // EFFECTS: return a CGRect that represents the specified frame of the wolf
    CGFloat singleFrameWidth = 225;
    CGFloat singleFrameHeight = 150;
    NSInteger framePerRow = 5;
    NSInteger framePerColumn = 3;
    
    NSInteger numberOfFrame = framePerColumn * framePerRow;
    
    if (frameNumber < 0 || frameNumber >= numberOfFrame)
        [NSException raise:@"Invalid frame number" 
                    format:@"Frame number %d does not exist", (int) frameNumber];
    
    CGFloat xCoordinate = singleFrameWidth * (frameNumber % framePerRow);
    CGFloat yCoordinate = singleFrameHeight * (frameNumber / framePerRow);
    
    return CGRectMake(xCoordinate, yCoordinate, singleFrameWidth, singleFrameHeight);
}

#pragma mark - View life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Wolf loaded");
    
    UIImage *wolfImages = [UIImage imageNamed:@"wolfs.png"];
    CGRect frameZeroBoundingBox = [GameWolf getBoundingBoxAt: 0];
    CGImageRef wolfImagesRef = CGImageCreateWithImageInRect([wolfImages CGImage], frameZeroBoundingBox);
     
    UIImageView *wolfImageView = [[UIImageView alloc] initWithImage: [UIImage imageWithCGImage:wolfImagesRef]];
    // [wolfImageView setAutoresizingMask: UIViewAutoresizingFlexibleBottomMargin | UIView
    // [wolfImageView setBackgroundColor: [UIColor redColor]];
    /*
    UIImageView *wolfImageView = [[UIImageView alloc] initWithImage: wolfImages];
     */
    // [wolfView addSubview: wolfImageView];
    [self.view addSubview: wolfImageView];
    // [self.view setAutoresizingMask: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin];
    // [self.view setContentMode: UIViewContentModeTopLeft];
    [self.view setAutoresizesSubviews: YES];
    // [self.view setAutoresizingMask: UIViewAutoresizingNone];
    NSLog(@"%f %f %f %f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view setBounds: CGRectMake(0, 0, wolfImageView.bounds.size.width, wolfImageView.bounds.size.height)];
    [self.view setBackgroundColor: [UIColor orangeColor]];
    // [self.view setAutoresizingMask: UIViewA
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
