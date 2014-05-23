//
//  ViewController.m
//  BlockProgramming
//
//  Created by Gagan on 24/04/14.
//  Copyright (c) 2014 Gagan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*......................................................................................*/
    float (^oneFrom)(float);
    oneFrom=    ^(float      aFloat)
    {
        float  result =  aFloat -  1.0;
        return        result;
    };
    
 /*......................................................................................*/  //For mutable variable concept   __block makes variable a mutable variable
   __block int xVal=5;
    int (^MultiplyMethods)(int)=^(int numInt)
    {
        xVal++;
        return xVal*numInt;
    };
  NSLog(@"After multplication On Block Value is : %d", MultiplyMethods(10));
    /*.................................................................................*/  //Filtering objects from two arrays
    NSArray   *array = @[@"A",  @"B", @"C", @"A", @"B", @"Z", @"G", @"are",  @"Q"];
    NSSet  *filterSet =[NSSet  setWithObjects:@"A", @"Z",  @"Q",  nil];
    BOOL (^test)(id object, NSInteger index, BOOL *stop);
    test=^(id object, NSInteger index, BOOL *stop){
        if(index<5)
        {
            if([filterSet containsObject:object])
            {
                return YES;
            }
        }
        return NO;
    };
}

//This method shows an example of callback using blocks.
- (IBAction)CallWebservice:(id)sender {
    [self CallWebServiceBlock:^(BOOL isSuccess)
     {
         if(isSuccess)
         {
             NSLog(@"Success");
         }
         else{
             NSLog(@"Error");
         }
         [self.myActivityIndicator stopAnimating];
     }];
}

- (IBAction)sortingArray:(id)sender {
    NSArray *unSortedArray=[NSArray arrayWithObjects:@"Gagan 12",@"Vishal 23",@"123 Gagan",@"123",@"Gagan",@"1L2I3S4T",@"#!@qwerty",@"qwer12#ty", nil];
    static NSStringCompareOptions comparisionOption=NSCaseInsensitiveSearch | NSNumericSearch |NSWidthInsensitiveSearch |NSForcedOrderingSearch;
    NSLocale *locale=[NSLocale currentLocale];
    NSComparator    finderSortBlock    =^(id   string1, id   string2)
    {
        NSRange string1Range=NSMakeRange(0,[string1 length]);
        return        [string1 compare:string2 options:comparisionOption range:string1Range locale:locale];
    };
    NSArray *sortedArray=[unSortedArray sortedArrayUsingComparator:finderSortBlock ];
    NSLog(@"sortedArray is : %@",sortedArray);
}

-(void)CallWebServiceBlock:(MyCompletionBlock)completionBlock
{
    [self.myActivityIndicator startAnimating];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=jack+johnson"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error)
        {
            completionBlock(NO);
        }
        else if(data.length==0)
        {
            completionBlock(NO);
        }
        else
        {
            completionBlock(YES);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
