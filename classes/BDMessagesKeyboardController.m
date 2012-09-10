//
//  BDMessagesKeyboardControllerViewController.m
//  BDMessagesKeyboardController
//
//  Created by norsez on 9/8/12.
//  Copyright (c) 2012 Bluedot. All rights reserved.
//

#import "BDMessagesKeyboardController.h"
#import <QuartzCore/QuartzCore.h>
#define kIntervalAnimation 0.20
#define kHeightTextEditor 58
#define kMargin 8
#define kHeightMinAccessoryView 44
@interface BDMessagesKeyboardController ()
{
    UIViewController *_superViewController;
    UITextView* _textView;
    UIView* _textEditorBackgroundView;
    UIButton *_cancelButton;
    UIButton *_doneButton;
    UITapGestureRecognizer *_tapToCancel;
    CGRect _keyboardFrame;
    CAGradientLayer *_backgroundGradient;

}
@end

@implementation BDMessagesKeyboardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if((touch.view == self.view || touch.view == _accessoryView) && (gestureRecognizer == _tapToCancel)){
        return YES;
    }
    
    return NO;
}

- (void)configureView
{
    self.editorHeight = kHeightTextEditor;
    
    self.view.backgroundColor = [UIColor clearColor];
    _tapToCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    _tapToCancel.delegate = self;
    _tapToCancel.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:_tapToCancel];
    self.view.opaque = NO;
    _textEditorBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _textEditorBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview: _textEditorBackgroundView];
    _textEditorBackgroundView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView.layer.cornerRadius = 3;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    [_textEditorBackgroundView addSubview:_textView];
    _textView.delegate = self;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_doneButton addTarget:self action:@selector(onPressDone:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton addTarget:self action:@selector(onPressCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _cancelButton.hidden = !self.showCancelButton;
    
    _doneButton.autoresizingMask = _cancelButton.autoresizingMask;
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_textEditorBackgroundView addSubview:_cancelButton];
    [_textEditorBackgroundView addSubview:_doneButton];
    
    [self.view insertSubview:self.accessoryView atIndex:0];
    self.accessoryView.frame = CGRectOffset(self.accessoryView.frame, 0, CGRectGetHeight(self.view.bounds));
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(layoutTextEditor:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _textView = nil;
    _textEditorBackgroundView = nil;
    _doneButton = nil;
    _cancelButton = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [_superViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}


- (void)layoutTextEditor:(NSNotification*)notification
{

    NSDictionary *kbInfo = notification.userInfo;
    NSValue * frameEndValueKB = [kbInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    _keyboardFrame = frameEndValueKB.CGRectValue;
    
    _keyboardFrame = [_superViewController.view convertRect:_keyboardFrame fromView:[UIApplication sharedApplication].keyWindow];
    
    CGSize sizeBackgroundSubviews = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                               self.editorHeight);
    CGRect endFrame = CGRectMake(0,
                                 CGRectGetHeight(_superViewController.view.bounds) - _keyboardFrame.size.height - sizeBackgroundSubviews.height,
                                 CGRectGetWidth(_superViewController.view.bounds),
                                 sizeBackgroundSubviews.height);
    

    _textEditorBackgroundView.frame = endFrame;
    
    const CGFloat textViewRatio = 0.8;
    const CGSize buttonSize = CGSizeMake((1-textViewRatio) * CGRectGetWidth(_textEditorBackgroundView.bounds) , (self.editorHeight - kMargin* 3) * 0.5);
    
    _textView.frame = CGRectMake(kMargin,
                                 kMargin,
                                 textViewRatio * (CGRectGetWidth(_textEditorBackgroundView.bounds) - (kMargin*2)),
                                 self.editorHeight-(kMargin*2));
        
    if (self.showCancelButton) {
        _doneButton.frame = CGRectMake( CGRectGetMaxX(_textView.frame) + kMargin,
                                       self.editorHeight - buttonSize.height - kMargin,
                                       buttonSize.width- kMargin,
                                       buttonSize.height);
        
        
        _cancelButton.frame = CGRectOffset(_doneButton.frame, 0, -buttonSize.height - kMargin);
    }else{
        const CGFloat buttonScale = 5/7.f;
        _doneButton.bounds = CGRectMake(0, 0, buttonSize.width-kMargin, CGRectGetHeight(_textView.bounds) * buttonScale);
        _doneButton.frame = CGRectMake(CGRectGetMaxX(_textView.bounds) + (kMargin*2),
                                       CGRectGetHeight(_textView.bounds) * 0.5 * buttonScale,
                                       buttonSize.width - kMargin,
                                       CGRectGetHeight(_doneButton.bounds)
                                       );
    }
    
    if  (self.styleBackgroundView){
        self.styleBackgroundView(_textEditorBackgroundView);
    }
    if  (self.styleTextView){
        self.styleTextView(_textView);
    }
    if  (self.showCancelButton && self.styleCancelButton){
        self.styleCancelButton(_cancelButton);
    }
    if  (self.styleDoneButton){
        self.styleDoneButton(_doneButton);
    }
   
    [self resizeEditor:YES];
}

- (void)showOnViewController:(UIViewController *)viewControllerToDisplayOn
{
    _superViewController = viewControllerToDisplayOn;
    [_superViewController.view addSubview:self.view];
    self.view.frame = _superViewController.view.bounds;
    _textEditorBackgroundView.frame = CGRectMake(0,
                                 CGRectGetHeight(_superViewController.view.bounds),
                                 CGRectGetWidth(self.view.bounds), self.editorHeight);
    if (self.willShowKeyboard) {
        self.willShowKeyboard(_textView);
    }
    [_textView becomeFirstResponder];
    [self viewDidLayoutSubviews];
}

- (void)hideWithCompletion:(void(^)(void))completion
{
    [_textView resignFirstResponder];
    [UIView animateWithDuration:kIntervalAnimation
                     animations:^{
                        self.accessoryView.frame = CGRectOffset(self.accessoryView.frame,
                                                                0,
                                                                -CGRectGetHeight(self.view.bounds));
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:kIntervalAnimation
                                          animations:^{
                                              self.view.alpha = 0;
                                              _textEditorBackgroundView.frame = CGRectOffset(_textEditorBackgroundView.frame, 0, CGRectGetHeight(_textEditorBackgroundView.superview.bounds));
                                          } completion:^(BOOL finished){
                                              if (completion){
                                                  [self.view removeFromSuperview];
                                                  _superViewController = nil;
                                                  completion();
                                              }
                                          }];

                     }];
}

- (void)hide
{
    [self hideWithCompletion:nil];
}

- (void)clearTextView
{
    _textView.text = nil;
    [self resizeEditor:NO];
}


#pragma mark - handling events

- (void)onPressDone:(id)sender
{
    [self hideWithCompletion:^{
        if  (self.didPressDone){
            self.didPressDone(_textView.text);
        }
    }];
}

- (void)onPressCancel:(id)sender
{
    [self hideWithCompletion:^{
        if  (self.didPressCancel){
            self.didPressCancel(_textView.text);
        }
    }];
    
}

#pragma mark - Text view delegate
- (void)resizeEditor:(BOOL)animating
{
    NSArray * lines = [_textView.text componentsSeparatedByString:@"\n"];
    
    CGFloat heightViewport = CGRectGetHeight( _superViewController.view.bounds) - CGRectGetHeight(_keyboardFrame);
    CGFloat updatedHeight = (_textView.font.lineHeight * lines.count + 2);
    updatedHeight = MIN(updatedHeight, heightViewport - kHeightMinAccessoryView);
    updatedHeight = MAX(self.editorHeight, updatedHeight);
    
    
    CGFloat minYTextEditor = heightViewport - updatedHeight;
    minYTextEditor = minYTextEditor < kHeightMinAccessoryView?kHeightMinAccessoryView:minYTextEditor;
    CGRect endFrameTextEditorBackgroundView = CGRectMake(0,
                                                         minYTextEditor,
                                                         CGRectGetWidth(_superViewController.view.bounds),
                                                         updatedHeight);
    
    CGRect endFrameAccessoryView = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(_accessoryView.bounds),
                                              heightViewport - CGRectGetHeight(endFrameTextEditorBackgroundView));
    
    _textEditorBackgroundView.frame = endFrameTextEditorBackgroundView;
    _accessoryView.frame = endFrameAccessoryView;
    
    if (animating) {
        
        
        
            self.view.alpha = 0;
            self.accessoryView.frame = CGRectOffset(endFrameAccessoryView, 0, -CGRectGetHeight(self.view.bounds));
            _textEditorBackgroundView.frame = CGRectOffset(endFrameTextEditorBackgroundView, 0, CGRectGetHeight(endFrameTextEditorBackgroundView));
            [UIView animateWithDuration:kIntervalAnimation animations:^{
                self.view.alpha = 1;
                _textEditorBackgroundView.frame = endFrameTextEditorBackgroundView;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kIntervalAnimation
                                 animations:^{
                                     self.accessoryView.frame = endFrameAccessoryView;
                                 }];
            }];
        
    }
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self resizeEditor:NO];
    return YES;
}
@end
