//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mario Grimaldi on 02/05/14.
//  Copyright (c) 2014 Mario. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
