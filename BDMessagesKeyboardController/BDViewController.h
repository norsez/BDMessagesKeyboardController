//
//  BDViewController.h
//  BDMessagesKeyboard
//
//  Created by norsez on 9/8/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDViewController : UIViewController

- (IBAction)showMessageKeyboard:(id)sender;
@property (nonatomic, strong) IBOutlet UIView* demoAccessoryView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIButton *button;
@end
