#import "MMTextField.h"

@interface MMTextField ()

@end

@implementation MMTextField

- (id)init
{
    self = [super init];
    if (self)  {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.textColor = JCL_Text_COL;
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        self.font = [UIFont systemFontOfSize:15];
        [self setValue: JCL_Text_COL forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // draw top border
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}


// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}



@end
