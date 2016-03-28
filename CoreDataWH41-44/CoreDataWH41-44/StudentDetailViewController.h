//
//  StudentDetailViewController.h
//  CoreDataWH41-44
//
//  Created by Nikolay Berlioz on 27.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "CoreDataViewController.h"

@class Student;

@interface StudentDetailViewController : CoreDataViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Student *student;



@end
