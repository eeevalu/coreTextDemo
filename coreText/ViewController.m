//
//  ViewController.m
//  coreText
//
//  Created by Eva on 16/8/12.
//  Copyright © 2016年 Eva. All rights reserved.
//

#import "ViewController.h"

#define font 17
@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (assign, nonatomic) BOOL isSelect;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self protocolIsSelect:self.isSelect];
    
}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请遵守以下协议《111协议》《22协议》《33协议》《44协议》《5555协议》《6666协议》"];
    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"《111协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《22协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《33协议》"]];
    
    
    UIImage *image = [UIImage imageNamed:select == YES ? @"link_blue" : @"link_blue"];
    CGSize size = CGSizeMake(font + 2, font + 2);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [image drawInRect:CGRectMake(0, 2, size.width, size.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = resizeImage;
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                        value:@"checkbox://"
                        range:NSMakeRange(0, imageString.length)];
    [attributedString appendAttributedString:imageString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];
    _textview.attributedText = attributedString;
    _textview.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textview.contentInset = UIEdgeInsetsMake(-10, 0, 30, 0);

    _textview.delegate = self;
    _textview.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textview.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"33支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"111支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
        NSLog(@"22支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}
@end
