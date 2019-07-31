

#import "MMTableViewCell.h"


@implementation MMTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        UIImageView *accessoryIV = [[UIImageView alloc] init];
        accessoryIV.frame = CGRectMake(0, 0, 15, 15);
        accessoryIV.image = [UIImage imageNamed:@"arrow_list"] ;
        self.accessoryView = accessoryIV;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.accessoryView.right = self.right - 11;
    
}
@end
