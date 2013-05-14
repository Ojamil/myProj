//
//  SignUpViewController.h
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import <UIKit/UIKit.h>


@class SignUpViewController;

@protocol SignUpViewControllerDelegate <NSObject>

- (void)SignUpViewControllerDidCancel:
(SignUpViewController *)controller;
- (void)SignUpViewControllerDidSave:
(SignUpViewController *)controller;
@end

@interface SignUpViewController : UIViewController
{
   
    IBOutlet UIScrollView *scrollview;
}
@property(nonatomic,retain) UIScrollView *scrollview;
- (IBAction)testFieldDoneEditing:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password2;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *telephone;

@property (nonatomic, weak) id <SignUpViewControllerDelegate> delegate;
- (IBAction)backgroundTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *done;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancel;


@end