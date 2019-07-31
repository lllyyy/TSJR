//
//  TSJRNewDetailCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/21.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRNewDetailCell.h"

@implementation TSJRNewDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.attributedTextView];
       
        [self.attributedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(self);
        }];
        self.attributedTextView.textDelegate =self;
        
    }
    return self;
}


- (DTAttributedTextView *)attributedTextView {
    if (!_attributedTextView) {
        _attributedTextView = [[DTAttributedTextView alloc] init];
        _attributedTextView.scrollEnabled = NO;
        _attributedTextView.textDelegate =self;
        _attributedTextView.backgroundColor =JCL_Cell_COL;
      
   }
    return _attributedTextView;
}



#pragma mark - private Methods
//使用HtmlString,和最大左右间距，计算视图的高度
- (CGSize)getAttributedTextHeightHtml:(NSString *)htmlString with_viewMaxRect:(CGRect)_viewMaxRect{
    //获取富文本
    NSAttributedString *attributedString =  [self getAttributedStringWithHtml:htmlString];
    //获取布局器
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    //获取Frame
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:_viewMaxRect range:entireString];
    //得到大小
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded;
}

//Html->富文本NSAttributedString
- (NSAttributedString *)getAttributedStringWithHtml:(NSString *)htmlString{
    //获取富文本
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    return attributedString;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    NSLog(@"attachment %@",attachment);
    if([attachment isKindOfClass:[DTImageTextAttachment class]]){
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        imageView.url = attachment.contentURL;
        return imageView;
    }
    return nil;
}

//#pragma mark - DTLazyImageViewDelegate
//
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    NSLog(@"pred  ========  %@",pred);
    BOOL didUpdate = NO;
    
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [self.attributedTextView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            oneAttachment.originalSize = imageSize;
            
            didUpdate = YES;
        }
    }
    
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        // do it on next run loop because a layout pass might be going on
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.attributedTextView relayoutText];
            
            CGSize neededSize = [self.attributedTextView.attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:kScreenWidth];
           
                [self.attributedTextView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(10);
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(-15);
                    make.height.mas_equalTo(neededSize.height);
                }];
            
            if (self.getCellHeight) {
                self.getCellHeight(neededSize.height);
            }
            
            [self.attributedTextView relayoutText];
            
            
        });
    }
}

@end
