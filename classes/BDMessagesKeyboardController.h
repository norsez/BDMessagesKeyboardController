//
//  BDMessagesKeyboardControllerViewController.h
//  BDMessagesKeyboardController
//
//  Created by norsez on 9/8/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDMessagesKeyboardController : UIViewController <UITextViewDelegate, UIGestureRecognizerDelegate>{
@protected
    /**
     The view controller whose view this class displays text editor over.
     */
    UIViewController *_superViewController;
    /**
     The text view for text input.
     */
    UITextView* _textView;
    /**
     The background view that contains the text view and buttons.
     */
    UIView* _textEditorBackgroundView;
    /**
     The defualt cancel button.
     */
    UIButton *_cancelButton;
    /**
     The default done button.
     */
    UIButton *_doneButton;
    /**
     The scrollView being adjusted while displaying the text editor.
     */
    UIScrollView *_adjustedScrollView;
    /**
     The reference subview of the adjustedScrollView that this class will
     try its best to offset the scroll view in order to avoid the text editor from
     obscuring this particular subview.
     */
    UIView *_adjustToSubview;

}

/**
 Display text editor on the view of a controller.
 @param viewControllerToDisplayOn view controller whose view will contain the text editor.
 */
- (void)showOnViewController:(UIViewController*)viewControllerToDisplayOn;

/**
 Display text editor on the view of a controller and adjust the given scrollview so that
 the given subview on the scrollview will appear above the text editor.
 @param viewControllerToDisplayOn view controller whose view will contain the text editor.
 @param scrollView the scrollView which will be adjusted.
 @param subViewInScrollView a subview on scrollView
  */
- (void)showOnViewController:(UIViewController *)viewControllerToDisplayOn adjustingScrollView:(UIScrollView*)scrollView forScrollViewSubview:(UIView*)subViewInScrollView;

/**
 Hide the displayed text editor.
 */
- (void)hide;

/**
 Clear the text editor's text.
 */
- (void)clearTextView;

/**
 * Set text to the text editor.
 */
- (void)setText:(NSString*)text;


/**
 @name Customize Look and Feel.
 */

/**
 Initial height of the text editor.
 */
@property (nonatomic, assign) CGFloat editorHeight;

/**
 Flag to show a dedicated cancel button.
 */
@property (nonatomic, assign) BOOL showCancelButton;

/**
 Block called every time the text editor will be displayed. 
 This block is given with the background view of the editor.
 Customization can be done here.
 */
@property (nonatomic, copy) void(^styleBackgroundView)(UIView*);

/**
 Block called every time the text editor will be displayed.
 This block is given with the text view of the editor.
 Customization can be done here.
 */
@property (nonatomic, copy) void(^styleTextView)(UITextView*);

/**
 Block called every time the text editor will be displayed.
 This block is given with the cancel button of the editor.
 Customization can be done here.
 */
@property (nonatomic, copy) void(^styleCancelButton)(UIButton*);

/**
 Block called every time the text editor will be displayed.
 This block is given with the done button of the editor.
 Customization can be done here.
 */
@property (nonatomic, copy) void(^styleDoneButton)(UIButton*);

/**
 The view which is displayed on top of the text editor. 
 This view should not respond to user interactions and it should be
 automatically resized which the size of the text editor changes.

 */
@property (nonatomic, strong) UIView* accessoryView __deprecated;

@property (nonatomic, strong) UIView *inputAccessoryView;

/**
 @name Event Handling.
 */
/**
 Block called when the cancel button is pressed.
 */
@property (nonatomic, copy) void(^didPressCancel)(NSString*);

/**
 Block called just before the text editor is displayed.
 */
@property (nonatomic, copy) void(^willShowKeyboard)(UITextView*);

/**
 Called as the text editor is going to be dismissed by the Done button.
 The block must return NO, in order to stop the text editor from being dismissed.
 */
@property (nonatomic, copy) BOOL(^shouldDismissKeyboard)(NSString*);
/**
 Called after user hitting Done, when BOOL(^shouldDismissKeyboard)(NSString*) returns NO
 in order to customize handling of reporting unable to dismiss reason.
 This property is optional and default to this class default animation.
 */
@property (nonatomic, copy) BOOL(^onCannotDismissKeyboard)(UITextView*);

/**
 Called if shouldDismissKeyboard is undefined or returns YES.
 The returned NSString* is the user's final text input.
 This block is executed after the text editor has been dismissed from
 the parent view controller.
 */
@property (nonatomic, copy) void(^didPressDone)(NSString*);
@end
