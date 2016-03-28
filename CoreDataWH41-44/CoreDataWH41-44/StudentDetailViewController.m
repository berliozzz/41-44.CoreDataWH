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


@interface StudentDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *namesOfRows;

@end

@implementation StudentDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.namesOfRows = [NSArray arrayWithObjects:@"First Name", @"Last Name", @"Email", nil];
    
    self.tableView.delegate = self;
    
    
    
    
}

#pragma mark - Actions

- (void) actionSave:(UIBarButtonItem*)sender
{
    [[DataManager sharedManager] saveContext];
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

    if (!self.student)
    {
        Student *student = [[DataManager sharedManager] randomStudent];
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                        CGRectGetWidth(cell.frame) / 2, 43)];
            firstNameField.placeholder = @"Enter First Name";
            student.firstName = firstNameField.text;
            
            [cell addSubview:firstNameField];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                     CGRectGetWidth(cell.frame) / 2, 43)];
            student.lastName = lastNameField.text;
            lastNameField.placeholder = @"Enter Last Name";
            [cell addSubview:lastNameField];
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                    CGRectGetWidth(cell.frame) / 2, 43)];
            student.email = emailField.text;
            emailField.placeholder = @"Enter Email";
            emailField.adjustsFontSizeToFitWidth = YES;
            emailField.minimumFontSize = 12.f;
            [cell addSubview:emailField];
        }
        
        self.student = student;
        
    }else
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                        CGRectGetWidth(cell.frame) / 2, 43)];
            firstNameField.text = self.student.firstName;
            
            [cell addSubview:firstNameField];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                       CGRectGetWidth(cell.frame) / 2, 43)];
            lastNameField.text = self.student.lastName;
            [cell addSubview:lastNameField];
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = [self.namesOfRows objectAtIndex:indexPath.row];
            
            UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.frame) / 2, 0,
                                                                                    CGRectGetWidth(cell.frame) / 2, 43)];
            emailField.text = self.student.email;
            emailField.adjustsFontSizeToFitWidth = YES;
            emailField.minimumFontSize = 12.f;
            [cell addSubview:emailField];
        }
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





@end
