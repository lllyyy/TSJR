//
//  JCLYKView.m
//  JCLFutures
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import "JCLYKView.h"

@implementation JCLYKView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self tapActionBlock:^{
           
            [self endEditing:YES];
            
        }];
        self.y_select = YES;
        self.k_select = YES;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        self.content_bg = [JCLKitObj JCLView:self color:[UIColor blackColor]];
        self.title = [JCLKitObj JCLLable:self.content_bg font:17*JCLWIDTH/375 color:[UIColor whiteColor] alignment:1];
        self.title.backgroundColor = JCLRGB(42, 44, 56);
        self.title.text = @"止盈止损设置";
        self.next_content = [JCLKitObj JCLView:self.content_bg color:JCLRGB(34, 37, 46)];
        self.image_y = [JCLKitObj JCLImage:self.next_content];
        self.image_y.image = [UIImage imageNamed:@"选中-2"];
        self.image_y.userInteractionEnabled = YES;
        self.image_k = [JCLKitObj JCLImage:self.next_content];
        self.image_k.image = [UIImage imageNamed:@"选中-2"];
        self.image_k.userInteractionEnabled = YES;
        
        self.content_y = [JCLKitObj JCLLable:self.next_content font:15*JCLWIDTH/375 color:JCLRGB(102, 102, 105) alignment:1];
        self.content_y.text = @"止盈";
        self.content_k = [JCLKitObj JCLLable:self.next_content font:15*JCLWIDTH/375 color:JCLRGB(102, 102, 105) alignment:1];
        self.content_k.text = @"止损";
        
        self.contentField_y = [JCLKitObj JCLField:self.next_content font:16*JCLWIDTH/375 color:JCLRGB(255, 255, 255) delegate:self];
        self.contentField_y.backgroundColor = JCLRGB(42, 44, 56);
        self.contentField_y.keyboardType = UIKeyboardTypeDecimalPad;
        self.contentField_k = [JCLKitObj JCLField:self.next_content font:16*JCLWIDTH/375 color:JCLRGB(255, 255, 255) delegate:self];
        self.contentField_k.backgroundColor = JCLRGB(42, 44, 56);
        self.contentField_k.keyboardType = UIKeyboardTypeDecimalPad;
        
        self.cancel = [JCLKitObj JCLLable:self.content_bg font:17*JCLWIDTH/375 color:[UIColor whiteColor] alignment:1];
        self.cancel.backgroundColor = JCLRGB(34, 37, 46);
        self.cancel.text = @"取消";
        self.sure = [JCLKitObj JCLLable:self.content_bg font:17*JCLWIDTH/375 color:[UIColor blueColor] alignment:1];
        self.sure.backgroundColor = JCLRGB(34, 37, 46);
        self.sure.text = @"确认";
        
        [self.cancel tapActionBlock:^{
           
            [self removeFromSuperview];
            
        }];
        [self.image_y tapActionBlock:^{
           
            self.y_select = !self.y_select;
            self.image_y.image = self.y_select?[UIImage imageNamed:@"选中-2"]:[UIImage imageNamed:@"方形未选中"];
        }];
        [self.image_k tapActionBlock:^{
            
            self.k_select = !self.k_select;
            self.image_k.image = self.k_select?[UIImage imageNamed:@"选中-2"]:[UIImage imageNamed:@"方形未选中"];
            
        }];
        [self.sure tapActionBlock:^{
            
            self.block(_y_select, _k_select,self.contentField_y.text,self.contentField_k.text);
            
        }];
    }
    return self;
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.content_bg.frame = CGRectMake(30*JCLWIDTH/375, JCLHEIGHT/2-125*JCLWIDTH/375, JCLWIDTH-60*JCLWIDTH/375, 240*JCLWIDTH/375);
    self.title.frame = CGRectMake(0*JCLWIDTH/375, 0*JCLWIDTH/375, JCLWIDTH-60*JCLWIDTH/375, 50*JCLWIDTH/375);
    self.next_content.frame = CGRectMake(0*JCLWIDTH/375, self.title.maxY, JCLWIDTH-60*JCLWIDTH/375, 135*JCLWIDTH/375);
    self.image_y.frame = CGRectMake(25*JCLWIDTH/375, 30*JCLWIDTH/375, 20*JCLWIDTH/375, 20*JCLWIDTH/375);
    self.image_k.frame = CGRectMake(25*JCLWIDTH/375, self.image_y.maxY+30*JCLWIDTH/375, 20*JCLWIDTH/375, 20*JCLWIDTH/375);
    self.content_y.frame = CGRectMake(self.image_y.maxX+12*JCLWIDTH/375, 30*JCLWIDTH/375, 35*JCLWIDTH/375, 20*JCLWIDTH/375);
    self.content_k.frame = CGRectMake(self.image_y.maxX+12*JCLWIDTH/375,  self.image_y.maxY+30*JCLWIDTH/375, 35*JCLWIDTH/375, 20*JCLWIDTH/375);
    self.contentField_y.frame = CGRectMake(self.content_k.maxX+10*JCLWIDTH/375, 23*JCLWIDTH/375, JCLWIDTH-90*JCLWIDTH/375-self.content_k.maxX, 35*JCLWIDTH/375);
    self.contentField_k.frame = CGRectMake(self.content_k.maxX+10*JCLWIDTH/375, self.contentField_y.maxY+15, JCLWIDTH-90*JCLWIDTH/375-self.content_k.maxX, 35*JCLWIDTH/375);
    self.cancel.frame = CGRectMake(0, self.next_content.maxY+1, (JCLWIDTH-60*JCLWIDTH/375)/2-1, 240*JCLWIDTH/375-self.next_content.maxY-1);
    self.sure.frame = CGRectMake((JCLWIDTH-60*JCLWIDTH/375)/2, self.next_content.maxY+1, (JCLWIDTH-60*JCLWIDTH/375)/2, 240*JCLWIDTH/375-self.next_content.maxY-1);
}
-(void)updateStatus:(NSString *)y_price with:(NSString *)k_price{
    
    NSString *new_code;
   
    if (self.market.integerValue==5) {
        
      
         new_code = [NSString stringWithFormat:@"DC%@", self.code];
        
    } else if(self.market.integerValue==6) {
        

         new_code = [NSString stringWithFormat:@"ZC%@", self.code];
        
    }else if(self.market.integerValue==3) {
        

        new_code = [NSString stringWithFormat:@"SF%@", self.code];
        
    }else if(self.market.integerValue==4) {
        

        new_code = [NSString stringWithFormat:@"SC%@", self.code];
        
    }else if(self.market.integerValue==24) {
        

        new_code = [NSString stringWithFormat:@"OIL%@", self.code];
        
    }
    NSArray *code_obj =  [JCLMarketObj JCLSearchCode:new_code];
    self.decimal = [code_obj[4] integerValue];
    if (y_price.floatValue>0) {
        
        self.y_select = YES;
        self.image_y.image = [UIImage imageNamed:@"选中-2"];
        self.contentField_y.text = [JCLMarketObj JCLMarketPrice:y_price.floatValue decimal:code_obj[4]];
    }
    if (k_price.floatValue>0) {
        
        self.k_select = YES;
        self.image_k.image = [UIImage imageNamed:@"选中-2"];
        self.contentField_k.text = [JCLMarketObj JCLMarketPrice:k_price.floatValue decimal:code_obj[4]];
    }
}
-(void)showWindow{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    NSInteger flag=0;
    const NSInteger limited = self.decimal;
    
    for (int i = futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
