//
//  WriteNoteViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "WriteNoteViewController.h"

@interface WriteNoteViewController ()

@property BOOL isFullScreen;

@end

@implementation WriteNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)saveNote:(id)sender {
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * notesArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (notesArray) {
        tmp = [[NSMutableArray alloc] initWithArray:notesArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  currenttime=[dateformatter stringFromDate:senddate];
    NSLog(@"123=%@",currenttime);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    //NSInteger sec = [comps second];
    //NSString *month2;
  
    Note * note = [[Note alloc] init];
    note.content = self.Text.text;
    note.year = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        note.month = [NSString stringWithFormat: @"JAN ,"];
    }
    else if(month == 2){
        note.month = [NSString stringWithFormat: @"FEB ,"];
    }
    else if(month == 3){
        note.month = [NSString stringWithFormat: @"MAR ,"];
    }
    else if(month == 4){
        note.month = [NSString stringWithFormat: @"APR ,"];
    }
    else if(month == 5){
        note.month = [NSString stringWithFormat: @"MAY ,"];
    }
    else if(month == 6){
        note.month = [NSString stringWithFormat: @"JUN ,"];
    }
    else if(month == 7){
        note.month = [NSString stringWithFormat: @"JUL ,"];
    }
    else if(month == 8){
        note.month = [NSString stringWithFormat: @"AUG ,"];
    }
    else if(month == 9){
        note.month = [NSString stringWithFormat: @"SEP ,"];
    }
    else if(month == 10){
        note.month = [NSString stringWithFormat: @"OCT ,"];
    }
    else if(month == 11){
        note.month = [NSString stringWithFormat: @"NOV ,"];
    }
    else if(month == 12){
        note.month = [NSString stringWithFormat: @"DEC ,"];
    }
    //note.month = [NSString stringWithFormat: @"%ld", (long)month];
    if (week == 1) {
        note.week = [NSString stringWithFormat: @"Sunday"];
    }
    else if(week == 2){
        note.week = [NSString stringWithFormat: @"Monday"];
    }
    else if(week == 3){
        note.week = [NSString stringWithFormat: @"Tuesday"];
    }
    else if(week == 4){
        note.week = [NSString stringWithFormat: @"Wednesday"];
    }
    else if(week == 5){
        note.week = [NSString stringWithFormat: @"Thursday"];
    }
    else if(week == 6){
        note.week = [NSString stringWithFormat: @"Friday"];
    }
    else if(week == 7){
        note.week = [NSString stringWithFormat: @"Saturday"];
    }
    //    note.week = [NSString stringWithFormat: @"%ld", (long)week];

    note.date = [NSString stringWithFormat: @"%ld", (long)day];

    note.hour = [NSString stringWithFormat: @"%ld", (long)hour];

    note.minute = [NSString stringWithFormat: @"%ld", (long)min];
    
    [tmp addObject:note];
    
    NSData * notes = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [notes writeToURL:file atomically:NO];
}


- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    _isFullScreen = NO;
    [self.image setImage:savedImage];
    
    self.image.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.image.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.image.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.image.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            
            self.image.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.image.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //[imagePickerController release];
    }
}




- (IBAction)choosephoto:(id)sender {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
    

}
@end
