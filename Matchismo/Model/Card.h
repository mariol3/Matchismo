//
//  Card.h
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//
//  Generic Card class that will be extended

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, strong) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;
@end
