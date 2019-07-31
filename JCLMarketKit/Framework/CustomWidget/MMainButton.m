#import "MMainButton.h"


@implementation MMainButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureButton];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
}

- (void)configureButton
{
//    [self setTitleColor:JCLRGB(197, 171, 112) forState:UIControlStateNormal];
//    [self setTitleColor: JCLRGB(197, 171, 112) forState:UIControlStateDisabled];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setBackgroundColor:JCLRGB(197, 171, 112) forState:0];
//    [self setBackgroundImage:[UIImage imageNamed:@"btn_bottom_no"] forState:UIControlStateDisabled];
//    [self setBackgroundImage:[UIImage imageNamed:@"btn_bottom_active"] forState:UIControlStateHighlighted];
}

@end
