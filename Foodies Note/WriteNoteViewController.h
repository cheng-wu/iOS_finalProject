//
//  WriteNoteViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface WriteNoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *Text;

- (IBAction)saveNote:(id)sender;

@end
