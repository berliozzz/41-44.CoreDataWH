//
//  StudentDetailViewController.m
//  CoreDataWH41-44
//
//  Created by Nikolay Berlioz on 27.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "DataManager.h"
#import "Student.h"


@interface StudentDetailViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *namesOfRows;

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *emailField;

@end

@implementation StudentDetailViewController
@synthesize managedObjectContext =_managedObjectContext;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.namesOfRows = [NSArray arrayWithObjects:@"First Name", @"Last Name", @"Email", nil];
    
    self.tableView.delegate = self;
    
    if (!self.student)
    {
        Student *student = [[DataManager sharedManager] addEmptyStudent];
        self.student = student;
    }
    
    
}

- (void) saveContext {
    // Save the context.
    NSError *error = nil;
    if (![[[DataManager sharedManager] managedObjectContext] save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
}

#pragma mark - Actions

- (void) actionSave:(UIBarButtonItem*)sender
{
    [self saveContext];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if (indexPath.row == 0)
    {
        cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
        
        UITextField *firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                    CGRectGetWidth(cell.frame) / 2, 43)];
        firstNameField.placeholder = @"Enter First Name";
        
        if (self.student.firstName)
        {
            firstNameField.text = self.student.firstName;
        }
        
        [cell addSubview:firstNameField];
        firstNameField.delegate = self;
        self.firstNameField = firstNameField;
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
        
        UITextField *lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                   CGRectGetWidth(cell.frame) / 2, 43)];
        lastNameField.placeholder = @"Enter Last Name";
        
        if (self.student.lastName)
        {
            lastNameField.text = self.student.lastName;
        }
        
        [cell addSubview:lastNameField];
        lastNameField.delegate = self;
        self.lastNameField = lastNameField;
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
        
        UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                CGRectGetWidth(cell.frame) / 2, 43)];
        emailField.placeholder = @"Enter Email";
        
        if (self.student.email)
        {
            emailField.text = self.student.email;
        }
        
        emailField.returnKeyType = UIReturnKeyDone;
        emailField.adjustsFontSizeToFitWidth = YES;
        emailField.minimumFontSize = 12.f;
        [cell addSubview:emailField];
        emailField.delegate = self;
        self.emailField = emailField;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.namesOfRows count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Add student";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Course *course = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) //if field empty
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"It is field should not be empty!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if ([textField isEqual:self.firstNameField])
    {
        self.student.firstName = self.firstNameField.text;
        [self saveContext];
    }
    else if ([textField isEqual:self.lastNameField])
    {
        self.student.lastName = self.lastNameField.text;
        [self saveContext];
    }
    else if ([textField isEqual:self.emailField])
    {
        self.student.email = self.emailField.text;
        [self saveContext];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.firstNameField])
    {
        [self.lastNameField becomeFirstResponder];
    }
    else if ([textField isEqual:self.lastNameField])
    {
        [self.emailField becomeFirstResponder];
    }
    else if ([textField isEqual:self.emailField])
    {
        [textField resignFirstResponder];
    }
    
    
    return YES;
}




@end
