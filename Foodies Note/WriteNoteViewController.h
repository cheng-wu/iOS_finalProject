//
//  WriteNoteViewController.h
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface WriteNoteViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *Text;

- (IBAction)saveNote:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) NSString * imagepath;

- (IBAction)choosephoto:(id)sender;


@end
