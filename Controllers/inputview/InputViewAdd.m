

#import "InputViewAdd.h"

@implementation InputViewAdd()
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorCommonBG;
        UIButton *photoItem = [self buttonWithImageName:@"keyboard_add_photo" title:@"照片" index:0];
        UIButton *cameraItem = [self buttonWithImageName:@"keyboard_add_camera" title:@"拍摄" index:1];
        [self addSubview:photoItem];
        [self addSubview:cameraItem];
    }
    return self;
}

- (UIButton *)buttonWithImageName:(NSString *)imageName title:(NSString *)title index:(NSInteger)index{
    CGFloat itemWidth = (kScreen_Width- 2*kPaddingLeftWidth)/4;
    CGFloat itemHeight = 90;
    CGFloat iconWidth = 57;
    CGFloat leftX = kPaddingLeftWidth, topY = 10;
    UIButton *addItem = [[UIButton alloc] initWithFrame:CGRectMake(leftX +index*itemWidth +(itemWidth -iconWidth)/2, topY, iconWidth, itemHeight)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, itemHeight - 20, iconWidth, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = kColorCommonFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [addItem addSubview:titleLabel];
    
    [addItem setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 15, 0)];
    [addItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    addItem.tag = 2000+index;
    [addItem addTarget:self action:@selector(clickedItem:) forControlEvents:UIControlEventTouchUpInside];
    return addItem;
}

- (void)clickedItem:(UIButton *)sender{
    NSInteger index = sender.tag - 2000;
    if (_addIndexBlock) {
        _addIndexBlock(index);
    }
}
@end