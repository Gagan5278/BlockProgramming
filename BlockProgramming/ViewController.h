//
//  ViewController.h
//  BlockProgramming
//
//  Created by Gagan on 24/04/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyCompletionBlock)(BOOL);
@interface ViewController : UIViewController
- (IBAction)CallWebservice:(id)sender;
- (IBAction)sortingArray:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;
@end
