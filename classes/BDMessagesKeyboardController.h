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
- (void)showOnViewController:(UIViewController *)viewControllerToDisplayOn adjustingScrollView:(UIScrollView*)scrollView forScrollViewSubview:(UIView*)subViewInScrollView;
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

/**
 Called as the text editor is going to be dismissed by the Done button.
 The block must return NO, in order to stop the text editor from being dismissed.
 */
@property (nonatomic, copy) BOOL(^shouldDismissKeyboard)(NSString*);
/**
 Blocked called when BOOL(^shouldDismissKeyboard)(NSString*) returns NO
 in order to customize handling of reporting unable to dismiss reason.
 This property is optional and default to this class default animation.
 */
@property (nonatomic, copy) BOOL(^onCannotDismissKeyboard)(UITextView*);
@end
