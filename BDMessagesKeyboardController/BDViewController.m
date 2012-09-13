//
//  BDViewController.m
//  BDMessagesKeyboard
//
//  Created by norsez on 9/8/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import "BDViewController.h"
#import "BDMessagesKeyboardController.h"
#import <QuartzCore/QuartzCore.h>
@interface BDViewController ()
{
    BDMessagesKeyboardController *_kbCtrl;
}
@end

@implementation BDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _kbCtrl = [[BDMessagesKeyboardController alloc] init];
    _kbCtrl.accessoryView = self.demoAccessoryView;

    
    self.demoAccessoryView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.demoAccessoryView.layer.shadowOpacity = 0.3;
    self.demoAccessoryView.layer.shadowRadius = self.demoAccessoryView.layer.cornerRadius;
    self.demoAccessoryView.layer.shadowOffset = CGSizeMake(0, -5);
    
    _kbCtrl.styleBackgroundView = ^(UIView* backgroundView){
        backgroundView.backgroundColor = [UIColor grayColor];
    };
    
    _kbCtrl.styleTextView = ^(UITextView* textView){
        textView.font = [UIFont systemFontOfSize:18];
    };
    
    _kbCtrl.styleDoneButton = ^(UIButton* btn){
        btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        btn.layer.cornerRadius = 4;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    };
    
    _kbCtrl.shouldDismissKeyboard = ^BOOL(NSString* inputText){
        inputText = [inputText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \r\n"]];
        return inputText.length > 0;
    };
       
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)showMessageKeyboard:(id)sender
{
    [_kbCtrl showOnViewController:self adjustingScrollView:self.scrollView forScrollViewSubview:self.button];
}

@end
