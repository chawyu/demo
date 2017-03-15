
#import "InputView.h"

#define kInputView_Height 50.0
#define kInputView_Width_Tool 35.0
#define kInputView_Gap_Tool 7.0
#define kKeyboardView_Height 216.0



@interface InputView ()
@property (assign, nonatomic, readonly) InputViewType inputviewType;
@property (assign, nonatomic, readonly) InputViewStatus inputviewStatus;
@property (strong, nonatomic) UIButton *addButton, *emotionButton,  *voiceButton;
@property (strong, nonatomic) UITextView *inputTextView;
@property (copy, nonatomic) NSString *placeHolder;
@end

@implementation InputView
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
        self.inputviewStatus = InputViewStatus_System;
        self.isAlwaysShow = NO;
    }
    return self;
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
    [self isAndResignFirstResponder];
    self.inputviewStatus = InputViewStatus_System;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
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
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)isAndResignFirstResponder{
	if (self.inputviewStatus == InputViewStatus_Add || self.inputviewStatus == InputViewStatus_Voice || self.inputviewStatus == InputViewStatus_Emotion) {
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        	/*
            [_emojiKeyboardView setY:kScreen_Height];
            [_addKeyboardView setY:kScreen_Height];
            [_voiceKeyboardView setY:kScreen_Height];
            if (self.isAlwaysShow) {
                [self setY:kScreen_Height- CGRectGetHeight(self.frame)];
            }else{
                [self setY:kScreen_Height];
            }*/
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

}
- (void)setupWithType:(InputViewType)type{
	self.inputviewType = type;

	 switch (self.inputviewType) {
	 	case InputViewType_PriMsg:
	 		[self setupForPriMsg];
	 		break;
	 	default:

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
        [self.contentView addSubview:_inputTextView];

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
}
@end







