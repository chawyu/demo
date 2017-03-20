
#import "InputView.h"
#import "UIView+Frame.h"
#import <Masonry/Masonry.h>
#import "UIColor+expanded.h"
#define kInputView_Height 50.0
#define kInputView_Width_Tool 35.0
#define kInputView_Gap_Tool 7.0
#define kKeyboardView_Height 216.0



@interface InputView ()
@property (assign, nonatomic) InputViewType inputviewType;
@property (assign, nonatomic) InputViewStatus inputviewStatus;
@property (strong, nonatomic) UIButton *addButton, *emotionButton,  *voiceButton;
@property (strong, nonatomic) UITextView *inputTextView;
@property (copy, nonatomic) NSString *placeHolder;
@end

@implementation InputView
- (void)setFrame:(CGRect)frame{
    CGFloat oldheightToBottom = kScreen_Height - CGRectGetMinY(self.frame);
    CGFloat newheightToBottom = kScreen_Height - CGRectGetMinY(frame);
    NSLog(@"--setframe---%@- %f-(%f %f)", NSStringFromCGRect(frame), newheightToBottom, kScreen_Height, CGRectGetMinY(frame));
    [super setFrame:frame];
    if (fabs(oldheightToBottom - newheightToBottom) > 0.1) {
        /*
        if (oldheightToBottom > newheightToBottom) {//降下去的时候保存
            [self saveInputStr];
            [self saveInputMedia];
        }*/
        if (_delegate && [_delegate respondsToSelector:@selector(inputView:heightToBottomChenged:)]) {
            [self.delegate inputView:self heightToBottomChenged:newheightToBottom];
        }
    }
}
- (void)setInputviewStatus:(InputViewStatus)inputStatus{
    if (_inputviewStatus != inputStatus) {
        _inputviewStatus = inputStatus;
        switch (_inputviewStatus) {
            case InputViewStatus_System:
            {
                [self.addButton setImage:[UIImage imageNamed:@"keyboard_add"] forState:UIControlStateNormal];
                [self.emotionButton setImage:[UIImage imageNamed:@"keyboard_emotion"] forState:UIControlStateNormal];
                [self.voiceButton setImage:[UIImage imageNamed:@"keyboard_voice"] forState:UIControlStateNormal];
            }
                break;
            case InputViewStatus_Emotion:
            {
                [self.addButton setImage:[UIImage imageNamed:@"keyboard_add"] forState:UIControlStateNormal];
                [self.emotionButton setImage:[UIImage imageNamed:@"keyboard_keyboard"] forState:UIControlStateNormal];
                [self.voiceButton setImage:[UIImage imageNamed:@"keyboard_voice"] forState:UIControlStateNormal];
            }
                break;
            case InputViewStatus_Add:
            {
                [self.addButton setImage:[UIImage imageNamed:@"keyboard_keyboard"] forState:UIControlStateNormal];
                [self.emotionButton setImage:[UIImage imageNamed:@"keyboard_emotion"] forState:UIControlStateNormal];
                [self.voiceButton setImage:[UIImage imageNamed:@"keyboard_voice"] forState:UIControlStateNormal];
            }
                break;
            case InputViewStatus_Voice:
            {
                [self.addButton setImage:[UIImage imageNamed:@"keyboard_add"] forState:UIControlStateNormal];
                [self.emotionButton setImage:[UIImage imageNamed:@"keyboard_emotion"] forState:UIControlStateNormal];
                [self.voiceButton setImage:[UIImage imageNamed:@"keyboard_keyboard"] forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }

        
        //[self updateContentViewBecauseOfMedia:NO];

    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorCommonBG;
        self.backgroundColor = [UIColor clearColor];
        self.inputviewStatus = InputViewStatus_System;
        self.isAlwaysShow = NO;
        UITapGestureRecognizer *panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}
- (void)didPan:(UITapGestureRecognizer *)panGesture
{
    //NSLog(@"--%@", panGesture.view);
    //[self isAndResignFirstResponder];
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.inputviewStatus != InputViewStatus_System) {
        self.inputviewStatus = InputViewStatus_System;
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            /*
            [_emojiKeyboardView setY:kScreen_Height];
            [_addKeyboardView setY:kScreen_Height];
            [_voiceKeyboardView setY:kScreen_Height];*/
        } completion:^(BOOL finished) {
            self.inputviewStatus = InputViewStatus_System;
        }];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing %ldl ",(long)self.inputviewStatus);
    if (self.inputviewStatus == InputViewStatus_System) {
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            if (_isAlwaysShow) {
                [self setY:kScreen_Height- kInputView_Height];
            }else{
                [self setY:kScreen_Height];
            }
        } completion:^(BOOL finished) {
        }];
    }
    return YES;
}
#pragma mark - KeyBoard Notification Handlers
- (void)keyboardChange:(NSNotification*)aNotification{
    if ([aNotification name] == UIKeyboardDidChangeFrameNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    NSDictionary* userInfo = [aNotification userInfo];
    CGRect keyboardEndFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    NSLog(@"begin:%@   end:%@  is:%d",  NSStringFromCGRect(keyboardBeginFrame),NSStringFromCGRect(keyboardEndFrame),  [self.inputTextView isFirstResponder]) ;
    if (self.inputviewStatus == InputViewStatus_System && [self.inputTextView isFirstResponder]) {
        
        CGFloat keyboardY =  keyboardEndFrame.origin.y;
        
        
        CGFloat selfOriginY = kScreen_Height;
        if (keyboardY == kScreen_Height) {
                    if (self.isAlwaysShow) {
                        selfOriginY = kScreen_Height- CGRectGetHeight(self.frame);
                    }else{
                        selfOriginY = kScreen_Height;
                    }
                }else{
                    selfOriginY = keyboardY-CGRectGetHeight(self.frame);
                }
        if (selfOriginY == self.frame.origin.y) {
            return;
        }
        
        
        __weak typeof(self) weakSelf = self;
        void (^endFrameBlock)() = ^(){
            [weakSelf setY:selfOriginY];
        };
        if ([aNotification name] == UIKeyboardWillChangeFrameNotification) {
            NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
            [UIView animateWithDuration:animationDuration delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                endFrameBlock();
            } completion:nil];
        }else{
            endFrameBlock();
        }
    }
}
- (void)prepareToShow{
	if ([self superview] == kKeyWindow) {
        return;
    }
    [self setY:kScreen_Height];
    [kKeyWindow addSubview:self];
    /*
    [kKeyWindow addSubview:_emojiKeyboardView];
    [kKeyWindow addSubview:_addKeyboardView];
    [kKeyWindow addSubview:_voiceKeyboardView];
    */
   // [self isAndResignFirstResponder];
    self.inputviewStatus = InputViewStatus_System;
    if (_isAlwaysShow && ![self isCustomFirstResponder]) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setY:kScreen_Height - CGRectGetHeight(self.frame)];
        }];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}
- (void)prepareToDismiss{
	if ([self superview] == nil) {
        return;
    }
    [self isAndResignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [self setY:kScreen_Height];
    } completion:^(BOOL finished) {
    	/*
        [_emojiKeyboardView removeFromSuperview];
        [_addKeyboardView removeFromSuperview];
        [_voiceKeyboardView removeFromSuperview];
        [self removeFromSuperview];
        */
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)isAndResignFirstResponder{
	if (self.inputviewStatus == InputViewStatus_Add || self.inputviewStatus == InputViewStatus_Voice || self.inputviewStatus == InputViewStatus_Emotion) {
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        	/*
            [_emojiKeyboardView setY:kScreen_Height];
            [_addKeyboardView setY:kScreen_Height];
            [_voiceKeyboardView setY:kScreen_Height];
            */
            if (self.isAlwaysShow) {
                [self setY:kScreen_Height- kInputView_Height];
            }else{
                [self setY:kScreen_Height];
            }
        } completion:^(BOOL finished) {
            self.inputviewStatus = InputViewStatus_System;
        }];
        return YES;
    }else{
        if ([_inputTextView isFirstResponder]) {
            [_inputTextView resignFirstResponder];
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}
- (BOOL)notAndBecomeFirstResponder{
	self.inputviewStatus = InputViewStatus_System;
    if ([_inputTextView isFirstResponder]) {
        return NO;
    }else{
        [_inputTextView becomeFirstResponder];
        return YES;
    }

}
- (BOOL)isCustomFirstResponder{
	return ([_inputTextView isFirstResponder] || self.inputviewStatus == InputViewStatus_Add || self.inputviewStatus == InputViewStatus_Voice || self.inputviewStatus == InputViewStatus_Emotion);

}
+ (instancetype)inputViewWithType:(InputViewType)type placeHolder:(NSString *)placeHolder{
	InputView* inputview = [[InputView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kInputView_Height)];
	[inputview setupWithType:type];
	if (placeHolder){
		inputview.placeHolder = placeHolder;
	}else{
		inputview.placeHolder = @"";
	}
    return inputview;

}
- (void)setupWithType:(InputViewType)type{
	self.inputviewType = type;
    self.inputView.layer.borderWidth = 2.0;
    self.inputView.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputView.layer.cornerRadius = 5.0;

	 switch (self.inputviewType) {
	 	case InputViewType_PriMsg:
	 		[self setupForPriMsg];
	 		break;
	 	default:
             break;

	 }

	

}
- (void)setupForPriMsg{
	//voic
	self.voiceButton = [[UIButton alloc] init];
		[self.voiceButton setImage:[UIImage imageNamed:@"keyboard_voice"] forState:UIControlStateNormal];
        [self.voiceButton addTarget:self action:@selector(voiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.voiceButton];
        

   		 //textview

		self.inputTextView = [[UITextView alloc] init];
		self.inputTextView.font = [UIFont systemFontOfSize:16];
		self.inputTextView.returnKeyType = UIReturnKeySend;
		self.inputTextView.delegate = self;

		//输入框缩进
        UIEdgeInsets insets = self.inputTextView.textContainerInset;
        insets.left += 8.0;
        insets.right += 8.0;
        self.inputTextView.textContainerInset = insets;
        [self addSubview:self.inputTextView];

        //emotion
        self.emotionButton = [[UIButton alloc] init];
		[self.emotionButton setImage:[UIImage imageNamed:@"keyboard_emotion"] forState:UIControlStateNormal];
        [self.emotionButton addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.emotionButton];

        //add
        self.addButton = [[UIButton alloc] init];
		[self.addButton setImage:[UIImage imageNamed:@"keyboard_add"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];

        [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kInputView_Width_Tool, kInputView_Width_Tool));
            make.bottom.mas_equalTo(-kInputView_Gap_Tool);
            make.left.mas_equalTo(kInputView_Gap_Tool);
        }];
        [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kInputView_Gap_Tool);
            make.bottom.mas_equalTo(-kInputView_Gap_Tool);
            make.left.mas_equalTo(self.voiceButton.mas_right).offset(kInputView_Gap_Tool);
            make.right.mas_equalTo(self.emotionButton.mas_left).offset(-kInputView_Gap_Tool);
        }];
        [self.emotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kInputView_Width_Tool, kInputView_Width_Tool));
            make.bottom.mas_equalTo(-kInputView_Gap_Tool);
            make.left.mas_equalTo(self.inputTextView.mas_right).offset(kInputView_Gap_Tool);
            make.right.mas_equalTo(self.addButton.mas_left).offset(-kInputView_Gap_Tool);
        }];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kInputView_Width_Tool, kInputView_Width_Tool));
            make.bottom.mas_equalTo(-kInputView_Gap_Tool);
            make.left.mas_equalTo(self.emotionButton.mas_right).offset(kInputView_Gap_Tool);
            make.right.mas_equalTo(-kInputView_Gap_Tool);
        }];



}
- (void)voiceButtonClicked:(id)sender {
	CGFloat endY = kScreen_Height;
    if (self.inputviewStatus == InputViewStatus_Voice) {
        self.inputviewStatus = InputViewStatus_System;
        [self.inputTextView becomeFirstResponder];
    }else{
        self.inputviewStatus = InputViewStatus_Voice;
        [self.inputTextView resignFirstResponder];
        endY = kScreen_Height - kKeyboardView_Height;
    }
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        [_emojiKeyboardView setY:endY];
//        [_addKeyboardView setY:kScreen_Height];
//        [_voiceKeyboardView setY:kScreen_Height];
        if (ABS(kScreen_Height - endY) > 0.1) {
            [self setY:endY- CGRectGetHeight(self.frame)];
        }
    } completion:^(BOOL finished) {
    }];
}
- (void)emotionButtonClicked:(id)sender {
	CGFloat endY = kScreen_Height;
    if (self.inputviewStatus == InputViewStatus_Emotion) {
        self.inputviewStatus = InputViewStatus_System;
        [self.inputTextView becomeFirstResponder];
    }else{
        self.inputviewStatus = InputViewStatus_Emotion;
        [self.inputTextView resignFirstResponder];
        endY = kScreen_Height - kKeyboardView_Height;
    }
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //        [_emojiKeyboardView setY:endY];
        //        [_addKeyboardView setY:kScreen_Height];
        //        [_voiceKeyboardView setY:kScreen_Height];
        if (ABS(kScreen_Height - endY) > 0.1) {
            [self setY:endY- CGRectGetHeight(self.frame)];
        }
    } completion:^(BOOL finished) {
    }];
}
- (void)addButtonClicked:(id)sender {
	CGFloat endY = kScreen_Height;
    if (self.inputviewStatus == InputViewStatus_Add) {
        self.inputviewStatus = InputViewStatus_System;
        [self.inputTextView becomeFirstResponder];
    }else{
        self.inputviewStatus = InputViewStatus_Add;
        [self.inputTextView resignFirstResponder];
        endY = kScreen_Height - kKeyboardView_Height;
    }
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //        [_emojiKeyboardView setY:endY];
        //        [_addKeyboardView setY:kScreen_Height];
        //        [_voiceKeyboardView setY:kScreen_Height];
        if (ABS(kScreen_Height - endY) > 0.1) {
            [self setY:endY- CGRectGetHeight(self.frame)];
        }
    } completion:^(BOOL finished) {
    }];
}
@end







