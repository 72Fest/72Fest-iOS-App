//
//  PhotoUploadViewController.h
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDownView.h"

#define LABEL_FONT [UIFont fontWithName:@"Archive" size:20]
@interface PhotoUploadViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate> {
    BOOL cameraWasUsed;
}

//Upload code
- (void)uploadImage:(UIImage *)img;
- (void)setUploadState:(BOOL)isUploading;

//NSURL delegate methods and connection operations
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data; 
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

- (void)resetConnection:(NSURLConnection *)connection;

//Countdown methods
- (void)requestCountdownMetadata:(NSString *)countDownURLStr;
- (void)displayCountdownWithCaption:(NSString *)captionStr andDate:(NSDate *)countdownDate;

//Image picker delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

//Action Sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

//Photo actions
- (void)takePhotoBtnPressed;
- (void)choosePhotoBtnPressed;

//Nav bar item actions
- (void)infoItemPressed:(id)sender;
- (void)infoViewClosed:(id)sender;

//IB Actions
- (IBAction)selectPhotoFromSourcePressed:(id)sender;
- (IBAction)uploadBtnPressed:(id)sender;

@property (nonatomic, strong) UIImage *curImage;
@property (nonatomic, strong) UIImage *fullSizeImage;
@property (nonatomic, strong) NSURLConnection *curConnection;
@property (nonatomic, strong) IBOutlet UIButton *selectPhotoFromSource;
@property (nonatomic, strong) IBOutlet UIButton *uploadBtn;
@property (nonatomic, strong) IBOutlet UILabel *uploadTxt;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet CountDownView *countDownTimer;
@property (nonatomic, strong) UITabBar *parentTabBar;
@property (strong, nonatomic) IBOutlet UITextView *uploadTextView;
@property (weak, nonatomic) IBOutlet UIView *uploadContainer;
@property (weak, nonatomic) IBOutlet UILabel *uploadTextLabel;

@end
