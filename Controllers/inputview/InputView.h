

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

@interface InputView : UIView<UITextViewDelegate>
@property (assign, nonatomic) BOOL isAlwaysShow;
+ (instancetype)inputViewWithType:(InputViewType)type placeHolder:(NSString *)placeHolder;
- (void)prepareToShow;
- (void)prepareToDismiss;
- (BOOL)isAndResignFirstResponder;
- (BOOL)notAndBecomeFirstResponder;
- (BOOL)isCustomFirstResponder;

@end