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

- (IBAction)resetButtonPressed:(id)sender;

@property (strong, nonatomic) NSMutableArray *inPlayGameObjects;
@property (strong, nonatomic) IBOutlet UIScrollView *gameArea;

@property (strong, nonatomic) NSMutableArray *paletteGameObjects;
@property (strong, nonatomic) IBOutlet UIView *palette;

@end
