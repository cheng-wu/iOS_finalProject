//
//  WebViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/6.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)goback:(id)sender;
- (IBAction)WriteNote:(id)sender;

@property (strong, nonatomic) NSMutableDictionary* URLArray;
//@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)NSString*mobileUrl;
@end
