

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InputViewType) {
    InputViewType_PriMsg = 0,
    InputViewType_Test,
};
typedef NS_ENUM(NSInteger, InputViewStatus) {
    InputViewStatus_System,
    InputViewStatus_Emotion,
    InputViewStatus_Add,
    InputViewStatus_Voice
};
@protocol InputViewDelegate;
@interface InputView : UIControl<UITextViewDelegate>
@property (assign, nonatomic) BOOL isAlwaysShow;
@property (nonatomic, weak) id<InputViewDelegate> delegate;
+ (instancetype)inputViewWithType:(InputViewType)type placeHolder:(NSString *)placeHolder;
- (void)prepareToShow;
- (void)prepareToDismiss;
- (BOOL)isAndResignFirstResponder;
- (BOOL)notAndBecomeFirstResponder;
- (BOOL)isCustomFirstResponder;

@end

@protocol InputViewDelegate <NSObject>

@optional
- (void)inputView:(InputView *)inputView sendText:(NSString *)text;
- (void)inputView:(InputView *)inputView sendBigEmotion:(NSString *)emotionName;
- (void)inputView:(InputView *)inputView sendVoice:(NSString *)file duration:(NSTimeInterval)duration;
- (void)inputView:(InputView *)inputView addIndexClicked:(NSInteger)index;
- (void)inputView:(InputView *)inputView heightToBottomChenged:(CGFloat)heightToBottom;

@end