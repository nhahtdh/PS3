//
//  ViewController.h
//  Game
//
//  Created by  on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

- (IBAction)buttonPressed:(id)sender;

@property (strong, nonatomic) NSMutableArray *gameObjects;

@property (strong, nonatomic) IBOutlet UIScrollView *gameArea;

@property (strong, nonatomic) IBOutlet UIView *palette;


@end
