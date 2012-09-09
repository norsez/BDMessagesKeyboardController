//
//  BDMessagesKeyboardControllerViewController.h
//  BDMessagesKeyboardController
//
//  Created by norsez on 9/8/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDMessagesKeyboardController : UIViewController <UITextViewDelegate, UIGestureRecognizerDelegate>
- (void)showOnViewController:(UIViewController*)viewControllerToDisplayOn;
- (void)hide;
- (void)clearTextView;


/**
 @name Customize Look and Feel.
 */
@property (nonatomic, assign) CGFloat editorHeight;
@property (nonatomic, assign) BOOL showCancelButton;
@property (nonatomic, copy) void(^styleBackgroundView)(UIView*);
@property (nonatomic, copy) void(^styleTextView)(UITextView*);
@property (nonatomic, copy) void(^styleCancelButton)(UIButton*);
@property (nonatomic, copy) void(^styleDoneButton)(UIButton*);
@property (nonatomic, strong) UIView* accessoryView;


/**
 @name Event Handling.
 */
@property (nonatomic, copy) void(^didPressDone)(NSString*);
@property (nonatomic, copy) void(^didPressCancel)(NSString*);
@property (nonatomic, copy) void(^willShowKeyboard)(UITextView*);
@end
