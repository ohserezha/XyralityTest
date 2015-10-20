//
//  LoginViewController.m
//  XyralityTest
//
//  Created by ezkeemo on 10/20/15.
//  Copyright © 2015 ezkeemo. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"
#import "WorldsListTableViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (IBAction)processButtonTapped:(id)sender {
    if (![self areLoginPassFieldsValid]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ouch!" message:@"One of textfields is empty. Please fill it with correct value" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    [[APIManager sharedManager] getWorldsListWithCredentialsLogin:self.loginTextField.text password:self.passwordTextField.text onSuccess:^(id responseObject) {
        if (responseObject && responseObject[@"allAvailableWorlds"]) {
            WorldsListTableViewController *worldsListController = [[WorldsListTableViewController alloc] init];
            NSArray *worldsList = (NSArray *)responseObject[@"allAvailableWorlds"];
            worldsListController.worldsList = worldsList;
            [self.navigationController pushViewController:worldsListController animated:YES];
        }
    } onFailure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"An error occured while talking to server" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

#pragma mark - Helpers

- (BOOL)areLoginPassFieldsValid {
    if ([self.loginTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}
@end
