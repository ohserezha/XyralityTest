//
//  LoginViewController.h
//  XyralityTest
//
//  Created by ezkeemo on 10/20/15.
//  Copyright © 2015 ezkeemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)processButtonTapped:(id)sender;
@end
